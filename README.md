# Starnew Informática — Guia do Site e Informações Importantes

Este repositório contém o site institucional da Starnew Informática. Abaixo estão os requisitos funcionais e de conteúdo, diretrizes de SEO, acessibilidade, performance, segurança e notas de implantação.

## O que o site deve conter

### Estrutura de páginas/seções
- Home (SPA por âncoras):
  - Hero com proposta de valor, 2–3 CTAs principais
  - Quem Somos (história, diferenciais, marcas autorizadas: SMS, NHS, Ragtech)
  - Serviços (assistência técnica, manutenção, contratos corporativos)
  - Produtos e Locação (descrições, chamadas para cotação)
  - Clientes e Cases (prova social, depoimentos)
  - Blog (teasers dos artigos)
  - FAQ (perguntas frequentes)
  - Contato (formulário + dados da empresa)
- Páginas legais:
  - Política de Privacidade (`privacidade.html`)
  - Termos de Uso (`termos.html`)
- Blog:
  - Artigos em HTML (diretório `blog/`) ou outra solução futura

### Conteúdo mínimo obrigatório
- Dados da empresa (visíveis no site e consistentes):
  - Razão social: Starnew Informática LTDA
  - E-mail: `starnew@starnew.com.br`
  - Telefones: `(71) 3276-0406` / `71 9694-3024`
  - Endereço: Av Professor Rômulo Almeida, Edifício Executive Center, Loja B, Acupe de Brotas, Salvador, BA
  - Horário de funcionamento: Seg–Sex 08:00–17:30
  - Marcas autorizadas: SMS, NHS, Ragtech
- Imagem social (Open Graph): `images/og-image.jpg` (1200×630)
- Favicon/ícones: em `images/`

## SEO e metadados
- Title e meta description por página
- Canonical (`<link rel="canonical" ...>`)
- Open Graph/Twitter Cards (imagem válida e acessível publicamente)
- JSON-LD (Schema.org):
  - `LocalBusiness` (dados da empresa)
  - `FAQPage` (se houver FAQ)
- Arquivos auxiliares:
  - `robots.txt` com link para `sitemap.xml`
  - `sitemap.xml` listando `index.html`, páginas legais e posts do blog
- Google Search Console: manter meta de verificação

## Acessibilidade (WCAG)
- Hierarquia semântica (`<h1>…<h3>`)
- Foco visível, navegação por teclado, ARIA em elementos interativos
- Labels associados a inputs; textos alternativos descritivos em imagens
- Contraste adequado em claro/escuro

## Formulário e LGPD
- Formulário de contato com validação e estados de feedback
- Checkbox obrigatório de consentimento com link para `privacidade.html`
- Banner de cookies com aceitar/rejeitar; carregar scripts de terceiros somente após consentimento

## Performance
- Imagens:
  - Preferir WebP/AVIF com fallback (`<picture>`), `loading="lazy"`, `width/height` definidos
  - `srcset/sizes` para responsividade
- CSS/JS:
  - Em produção, preferir Tailwind compilado e minificado (evitar Tailwind CDN)
  - Scripts com `defer`; evitar código inline quando possível
- Fonts:
  - `preconnect` a `fonts.googleapis.com` e `fonts.gstatic.com`
  - Preferir `woff2` com `display=swap` (ou self-host)

## Segurança
- HTTPS obrigatório + HSTS
- CSP estrita (evitar `'unsafe-inline'` em `script-src`/`style-src`)
- Desabilitar `server_tokens`; cabeçalhos de segurança (X-Content-Type-Options, Referrer-Policy, Permissions-Policy)
- Rate limiting em endpoints de formulário/proxy

## Infra e implantação (Nginx)
- Raiz do site: `/var/www/starnew.com.br`
- Configuração base recomendada: ver `nginx.conf` no repositório (HTTP→HTTPS, HTTP/2, cache estático, compressão gzip)
- Preload/Preconnect: manter apenas se os recursos existirem
- SPA com roteamento por âncoras não requer fallback; se adotar roteamento client-side, usar:
  ```
  location / {
    try_files $uri $uri/ /index.html;
  }
  ```
- Compressão Brotli (opcional): habilitar no Nginx/CDN

## Análises e monitoramento
- GA4 (via GTM) condicionado por consentimento do banner de cookies
- Google Search Console configurado e sitemap submetido
- Monitoramento de uptime e erros (opcional)

## Pendências e verificações rápidas
- Garantir existência de `images/og-image.jpg` (referenciada nas metas OG)
- Remover do Nginx qualquer preload para arquivos inexistentes (ex.: `images/logo.webp`) ou adicionar o arquivo correspondente
- Seções do site com conteúdo real (depoimentos, cases, posts do blog)

## Evolução recomendada
- Migrar para stack com build (Vite + Vue 3 + Tailwind compilado) para melhor performance e manutenção
- Converter imagens para formatos modernos e automatizar geração de `srcset`
- PWA: `manifest.json` + service worker para cache offline

## Estrutura atual (alto nível)
```
/ (raiz)
  index.html
  privacidade.html
  termos.html
  blog/
  images/
  robots.txt
  sitemap.xml
  nginx.conf
```

## Licença e créditos
- © 2024 Starnew Informática. Todos os direitos reservados.
- Conteúdo e estrutura mantidos pela equipe Starnew.
