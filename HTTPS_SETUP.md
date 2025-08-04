# 🔒 Guia de Configuração HTTPS - Starnew Informática

## 📋 Pré-requisitos

- Acesso root/sudo ao servidor
- Domínio `starnew.com.br` configurado
- Servidor web (Apache ou Nginx) instalado
- Acesso ao painel de controle do provedor de hospedagem

---

## 🚀 PASSO A PASSO - CONFIGURAÇÃO HTTPS

### **PASSO 1: Escolher o Tipo de Certificado**

#### **Opção A: Let's Encrypt (Gratuito) - RECOMENDADO**
```bash
# Instalar Certbot
sudo apt update
sudo apt install certbot

# Para Apache
sudo certbot --apache -d starnew.com.br -d www.starnew.com.br

# Para Nginx
sudo certbot --nginx -d starnew.com.br -d www.starnew.com.br
```

#### **Opção B: Certificado Comercial**
- Comprar certificado SSL (GoDaddy, Comodo, etc.)
- Fazer upload dos arquivos para o servidor
- Configurar manualmente

---

### **PASSO 2: Configurar o Servidor Web**

#### **Para Apache:**
1. Fazer upload do arquivo `.htaccess` para a raiz do site
2. Verificar se os módulos estão habilitados:
```bash
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod expires
sudo a2enmod deflate
sudo systemctl restart apache2
```

#### **Para Nginx:**
1. Copiar o conteúdo do arquivo `nginx.conf` para:
   ```bash
   sudo nano /etc/nginx/sites-available/starnew.com.br
   ```
2. Habilitar o site:
   ```bash
   sudo ln -s /etc/nginx/sites-available/starnew.com.br /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl restart nginx
   ```

---

### **PASSO 3: Configurar DNS**

#### **Registros DNS Necessários:**
```dns
# Registro A para domínio principal
starnew.com.br.    A    [IP_DO_SERVIDOR]

# Registro A para www
www.starnew.com.br. A    [IP_DO_SERVIDOR]

# Registro TXT para verificação (Google Search Console)
starnew.com.br.    TXT   "google-site-verification=SEU_CODIGO_AQUI"
```

#### **Onde configurar:**
- Painel de controle do provedor de hospedagem
- Ou painel de controle do registrador de domínio

---

### **PASSO 4: Configurar Renovação Automática (Let's Encrypt)**

#### **Cron Job para Renovação:**
```bash
# Editar crontab
sudo crontab -e

# Adicionar linha para renovação automática
0 12 * * * /usr/bin/certbot renew --quiet
```

#### **Testar Renovação:**
```bash
sudo certbot renew --dry-run
```

---

### **PASSO 5: Configurar Monitoramento**

#### **Instalar Dependências:**
```bash
sudo apt install curl openssl mailutils
```

#### **Configurar Script de Monitoramento:**
1. Copiar o arquivo `monitor_ssl.sh` para o servidor
2. Editar o arquivo e configurar:
   - `DOMAIN="starnew.com.br"`
   - `EMAIL="seu-email@starnew.com.br"`
3. Adicionar ao crontab para execução diária:
   ```bash
   sudo crontab -e
   # Adicionar linha
   0 8 * * * /caminho/para/monitor_ssl.sh
   ```

---

### **PASSO 6: Verificar Configuração**

#### **Comandos de Verificação:**
```bash
# Verificar certificado SSL
openssl s_client -connect starnew.com.br:443 -servername starnew.com.br

# Testar redirecionamento HTTP -> HTTPS
curl -I http://starnew.com.br

# Verificar headers de segurança
curl -I https://starnew.com.br

# Testar HSTS
curl -I https://starnew.com.br | grep -i "strict-transport-security"
```

#### **Ferramentas Online:**
- **SSL Labs:** https://www.ssllabs.com/ssltest/
- **Security Headers:** https://securityheaders.com/
- **Mozilla Observatory:** https://observatory.mozilla.org/

---

### **PASSO 7: Configurar Google Search Console**

1. Acessar: https://search.google.com/search-console
2. Adicionar propriedade: `https://starnew.com.br`
3. Verificar propriedade (via DNS ou arquivo HTML)
4. Submeter sitemap: `https://starnew.com.br/sitemap.xml`

---

### **PASSO 8: Configurar Google Analytics 4**

1. Acessar: https://analytics.google.com/
2. Criar propriedade para `starnew.com.br`
3. Obter ID de medição (G-XXXXXXXXXX)
4. Adicionar código de rastreamento ao site

---

## 🔧 CONFIGURAÇÕES ESPECÍFICAS POR PROVEDOR

### **Hostinger:**
1. Painel de Controle → SSL → Ativar SSL Gratuito
2. Aguardar ativação (pode levar até 24h)
3. Configurar redirecionamento 301 no .htaccess

### **GoDaddy:**
1. Painel de Controle → SSL → Instalar Certificado
2. Escolher certificado gratuito ou comercial
3. Seguir assistente de instalação

### **Locaweb:**
1. Painel de Controle → SSL → Ativar Certificado
2. Configurar redirecionamento automático
3. Verificar configurações de cache

### **DigitalOcean/AWS/VPS:**
1. Seguir passos do Let's Encrypt
2. Configurar firewall para portas 80 e 443
3. Configurar backup automático

---

## 🚨 SOLUÇÃO DE PROBLEMAS

### **Erro: Certificado não confiável**
- Verificar se o certificado foi instalado corretamente
- Aguardar propagação DNS (até 48h)
- Verificar se o domínio está apontando para o servidor correto

### **Erro: Redirecionamento não funciona**
- Verificar configuração do .htaccess
- Verificar se mod_rewrite está habilitado
- Limpar cache do navegador

### **Erro: Headers de segurança não aparecem**
- Verificar se mod_headers está habilitado (Apache)
- Verificar sintaxe da configuração Nginx
- Reiniciar servidor web

### **Erro: Performance baixa**
- Verificar se compressão Gzip está habilitada
- Verificar configurações de cache
- Otimizar imagens e recursos

---

## 📞 SUPORTE

### **Contatos Úteis:**
- **Provedor de Hospedagem:** [Contato do provedor]
- **Registrador de Domínio:** [Contato do registrador]
- **Desenvolvedor:** [Seu contato]

### **Logs Importantes:**
- Apache: `/var/log/apache2/error.log`
- Nginx: `/var/log/nginx/error.log`
- SSL Monitor: `/var/log/ssl_monitor.log`

---

## ✅ CHECKLIST FINAL

- [ ] Certificado SSL instalado e funcionando
- [ ] Redirecionamento HTTP → HTTPS configurado
- [ ] Headers de segurança implementados
- [ ] DNS configurado corretamente
- [ ] Renovação automática configurada
- [ ] Monitoramento ativo
- [ ] Google Search Console configurado
- [ ] Google Analytics configurado
- [ ] Testes de segurança realizados
- [ ] Backup configurado

---

**🎉 Parabéns! Seu site agora está seguro com HTTPS!**

*Este guia foi criado especificamente para o site da Starnew Informática. Para dúvidas ou problemas, consulte a documentação do seu provedor de hospedagem.* 