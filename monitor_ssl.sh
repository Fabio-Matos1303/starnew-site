#!/bin/bash
# Script de Monitoramento SSL para Starnew Informática
# Autor: Manus AI
# Data: Janeiro 2024

DOMAIN="starnew.com.br"
EMAIL="admin@starnew.com.br"
LOG_FILE="/var/log/ssl_monitor.log"

# Função para log
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Verificar se o domínio está acessível
check_domain() {
    if ! curl -s --head https://$DOMAIN > /dev/null; then
        log_message "ERRO: Domínio $DOMAIN não está acessível via HTTPS"
        echo "ALERTA: Domínio $DOMAIN não está acessível via HTTPS!" | mail -s "Alerta SSL - $DOMAIN" $EMAIL
        return 1
    fi
    return 0
}

# Verificar expiração do certificado
check_certificate() {
    EXPIRY=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:443 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -d= -f2)
    
    if [ -n "$EXPIRY" ]; then
        EXPIRY_DATE=$(date -d "$EXPIRY" +%s)
        CURRENT_DATE=$(date +%s)
        DAYS_LEFT=$(( ($EXPIRY_DATE - $CURRENT_DATE) / 86400 ))
        
        log_message "Certificado SSL expira em $DAYS_LEFT dias"
        
        if [ $DAYS_LEFT -lt 30 ]; then
            log_message "ALERTA: Certificado SSL expira em $DAYS_LEFT dias!"
            echo "ALERTA: Certificado SSL do domínio $DOMAIN expira em $DAYS_LEFT dias!" | mail -s "Alerta SSL - $DOMAIN" $EMAIL
        fi
    else
        log_message "ERRO: Não foi possível obter informações do certificado SSL"
        echo "ERRO: Não foi possível obter informações do certificado SSL para $DOMAIN" | mail -s "Erro SSL - $DOMAIN" $EMAIL
    fi
}

# Verificar headers de segurança
check_security_headers() {
    HSTS=$(curl -s -I https://$DOMAIN | grep -i "strict-transport-security" | wc -l)
    CSP=$(curl -s -I https://$DOMAIN | grep -i "content-security-policy" | wc -l)
    XFO=$(curl -s -I https://$DOMAIN | grep -i "x-frame-options" | wc -l)
    
    if [ $HSTS -eq 0 ]; then
        log_message "AVISO: Header HSTS não encontrado"
    fi
    
    if [ $CSP -eq 0 ]; then
        log_message "AVISO: Header CSP não encontrado"
    fi
    
    if [ $XFO -eq 0 ]; then
        log_message "AVISO: Header X-Frame-Options não encontrado"
    fi
}

# Verificar redirecionamento HTTP -> HTTPS
check_redirect() {
    HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://$DOMAIN)
    
    if [ "$HTTP_RESPONSE" != "301" ] && [ "$HTTP_RESPONSE" != "302" ]; then
        log_message "AVISO: Redirecionamento HTTP -> HTTPS pode não estar funcionando corretamente (código: $HTTP_RESPONSE)"
    fi
}

# Verificar performance SSL
check_ssl_performance() {
    SSL_LAB_URL="https://api.ssllabs.com/api/v3/analyze?host=$DOMAIN"
    SSL_GRADE=$(curl -s "$SSL_LAB_URL" | grep -o '"grade":"[A-F]"' | cut -d'"' -f4)
    
    if [ -n "$SSL_GRADE" ]; then
        log_message "SSL Labs Grade: $SSL_GRADE"
        
        if [ "$SSL_GRADE" = "F" ] || [ "$SSL_GRADE" = "T" ]; then
            log_message "ALERTA: SSL Labs Grade baixa: $SSL_GRADE"
            echo "ALERTA: SSL Labs Grade baixa ($SSL_GRADE) para $DOMAIN" | mail -s "Alerta SSL Grade - $DOMAIN" $EMAIL
        fi
    fi
}

# Função principal
main() {
    log_message "Iniciando verificação SSL para $DOMAIN"
    
    # Verificar domínio
    if check_domain; then
        # Verificar certificado
        check_certificate
        
        # Verificar headers de segurança
        check_security_headers
        
        # Verificar redirecionamento
        check_redirect
        
        # Verificar performance (opcional - pode ser lento)
        # check_ssl_performance
    fi
    
    log_message "Verificação SSL concluída"
}

# Executar função principal
main

# Manter apenas os últimos 1000 logs
tail -n 1000 "$LOG_FILE" > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE" 