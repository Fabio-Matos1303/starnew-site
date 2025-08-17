## Plano de Desenvolvimento por Sprints — Migração para Vite + Vue 3

### Contexto e Objetivo
Migrar o site atual (HTML + CSS + JS inline) para uma SPA moderna com Vite + Vue 3 + TypeScript, mantendo o foco em SEO, desempenho (Core Web Vitals), acessibilidade (WCAG), segurança (CSP sem inline) e agilidade de desenvolvimento.

### Escopo de Alto Nível
- Migrar homepage para componentes Vue por seções.
- Implantar roteamento para páginas legais e blog.
- Padronizar estilos com Tailwind compilado (sem CDN) e remover JS/CSS inline.
- Otimizar imagens (WebP/AVIF, srcset) e adicionar PWA (manifest + service worker).
- SEO técnico (metas, OG/Twitter, JSON‑LD) via `@vueuse/head`.
- Analytics (GA4) condicionado a consentimento (LGPD).
- Pipeline de build/deploy, CDN e headers seguros (CSP sem `'unsafe-inline'`).

### Stack alvo
- Build: Vite
- App: Vue 3 (script setup) + TypeScript
- Estilos: Tailwind CSS (JIT, purge) + PostCSS + Autoprefixer
- Roteamento: Vue Router (history mode)
- Estado de dados: TanStack Query (vue-query)
- Metatags/SEO: @vueuse/head
- Validação: Zod
- Formulário: fetch + Formspree (fase 1) e validação client-side
- PWA: vite-plugin-pwa (Workbox)
- Imagem: vite-plugin-image-optimizer (ou imagetools) + pipeline de conversão
- Compressão: vite-plugin-compression (brotli) + Nginx brotli
- Qualidade: ESLint + Prettier + Husky (pre-commit)
- CI/CD: GitHub Actions + deploy (Cloudflare Pages/VPS com Nginx)

---

## Cronograma por Sprints (1-2 semanas cada)

### Sprint 0 — Descoberta, Métricas e Arquitetura
- Levantar inventário de seções/componentes do site atual.
- Definir modo de roteamento (history) e fallback no Nginx (`try_files`).
- Coletar baseline de métricas: Lighthouse/PageSpeed, WebPageTest, CWV do CrUX.
- Decisões de plugins (PWA, imagens, compressão) e política de CSP alvo (sem inline).
- Planejar migração do blog (fase 1: `public/blog` estático; fase 2: Markdown + rotas).
- Abrir branch `feat/migracao-vue`.
- Critérios de aceite:
  - Documento de arquitetura e checklist de CSP/hosts de terceiros.
  - Baseline de performance/SEO/A11y registrada.

### Sprint 1 — Fundações do Projeto
- Scaffold: `npm create vite@latest starnew-vue -- --template vue-ts`. ✅ Concluído
- Dependências instaladas: Vue Router, @vueuse/head, @tanstack/vue-query, tailwindcss v4, postcss, autoprefixer, zod, vite-plugin-pwa, vite-plugin-compression, vite-plugin-image-optimizer, eslint, prettier, husky. ✅ Concluído
- Base de código: Router configurado, `App.vue` com `<RouterView/>`, `HomeView.vue` com metadados via `@vueuse/head`. ✅ Concluído
- Estilos: Tailwind v4 aplicado via `@import "tailwindcss"` em `src/style.css`. ✅ Concluído
- Qualidade: ESLint (flat config) + Prettier configurados; Husky pre-commit (lint + typecheck). ✅ Concluído
- Scripts: `lint`, `format`, `typecheck` adicionados ao `package.json`. ✅ Concluído
- Build: `npm run build` verde. ✅ Concluído
- Critérios de aceite:
  - `npm run dev` e `npm run build` verdes. ✅
  - `npm run lint` e `npm run typecheck` passam localmente e via hook. ✅

### Sprint 2 — Layout Base, Tema e Cabeçalhos
- `App.vue` com layout base e shell da SPA. ✅ Concluído
- Componentes criados: `Header.vue`, `Footer.vue`, `ThemeToggle.vue`, `CookieBanner.vue`. ✅ Concluído
- Tema: alternância claro/escuro com persistência em `localStorage`. ✅ Concluído
- Banner de cookies com aceitar/rejeitar. ✅ Concluído
- Navegação mobile adicionada no `Header.vue` (menu hambúrguer). ✅ Concluído
- Tokens básicos de tema aplicados em `src/style.css`. ✅ Concluído
- Próximos itens: ajustar branding (logo, paleta) e preparar seções da Home (Sprint 3). ⏳
- Critérios de aceite (parcial):
  - Estrutura do shell entregues. ✅
  - Sem JS inline no HTML. ✅

### Sprint 3 — Seções Principais da Home
- Estrutura inicial da Home criada: `Hero`, âncoras `#quemsomos`, `#servicos`, `#contato`. ✅ Em progresso
- `ProdutosLocacao`: abas iniciais implementadas (`ProductTabs.vue`). ✅ Em progresso
- Componentes adicionados: `ClientesCases`, `FAQ` (com acessibilidade básica), `BlogTeaser`. ✅ Em progresso
- Acessibilidade: navegação por teclado, ARIA e foco.
- Navegação suave e destaque de seção ativa via Vue (intersection observer).
- Critérios de aceite:
  - Paridade funcional/visual com a home atual.
  - Lighthouse A11y ≥ 95.

### Sprint 4 — Formulário de Contato (LGPD)
- `ContactForm.vue` criado com validação Zod, estados de erro, loading e mensagens. ✅ Concluído
- Integração com Formspree (action) e honeypot + tempo mínimo anti‑spam. ✅ Concluído
- Checkbox obrigatório de consentimento com link para `privacidade.html`. ✅ Concluído
- Critérios de aceite:
  - Validação e feedback acessíveis. ✅
  - Envio resiliente com estados de UI. ✅

### Sprint 5 — Páginas Legais e Roteamento
- Rotas adicionadas: `/privacidade` e `/termos` com views dedicadas. ✅ Concluído
- Header atualizado com links para páginas legais (desktop e mobile). ✅ Concluído
- Migração de conteúdo: aplicada versão resumida nas views; refino para conteúdo completo pendente. ⏳
- Ajustar Nginx para fallback SPA: `try_files $uri $uri/ /index.html;`.
- Critérios de aceite:
  - Rotas funcionam em refresh direto (Nginx ok).
  - Metatags específicas por rota.

### Sprint 6 — SEO Técnico e Metadados
- `@vueuse/head` para title/description/OG/Twitter por view.
- Injetar JSON‑LD (LocalBusiness e FAQ) via componentes dedicados.
- Corrigir `og:image` e gerar assets sociais (1200x630).
- `robots.txt` e `sitemap.xml` (fase 1 estático; fase 2 geração em CI).
- Critérios de aceite:
  - Rich Results para FAQ/LocalBusiness válidos.
  - PageSpeed SEO ≥ 95.

### Sprint 7 — Imagens e Performance
- Pipeline de imagens: conversão para WebP/AVIF, geração de `srcset/sizes`.
- `vite-plugin-image-optimizer` (ou processo externo + assets em `public`).
- Lazy loading, placeholders blur, dimensões explícitas para evitar CLS.
- `vite-plugin-compression` (brotli) + habilitar brotli no Nginx/Cloudflare.
- Critérios de aceite:
  - LCP ≤ 2.5s em 4G ‘Slow’ na homepage.
  - Tamanho total transferido reduzido significativamente (≥ 50% vs baseline).

### Sprint 8 — PWA e Consent‑Aware Analytics
- `vite-plugin-pwa`: manifest.json, ícones, pre‑cache, atualização suave.
- Gate de scripts de terceiros por consentimento (GA4 via GTM opcional).
- Ajuste de CSP para incluir apenas domínios necessários, sem `'unsafe-inline'`.
- Critérios de aceite:
  - PWA installable + offline básico.
  - CSP estrita sem quebras (relatórios `report-to` opcional).

### Sprint 9 — Blog (Fase 1: Público Estático; Fase 2: Markdown)
- Fase 1: mover `blog/*` para `public/blog` e linkar do `BlogTeaser`.
- Fase 2 (opcional): `vite-plugin-md` + rotas geradas + `Article` schema e OG por post.
- Critérios de aceite:
  - Links do teaser abrem posts existentes.
  - Se fase 2: build gera rotas e metas por front‑matter.

### Sprint 10 — QA Final, Observabilidade e Go‑Live
- Testes cross‑browser/dispositivos, A11y (axe), e2e essenciais (Playwright).
- Monitoramento: GA4, Search Console, Health checks, Error tracking (Sentry opcional).
- CI/CD: GitHub Actions (lint, typecheck, build, artefatos), deploy em produção.
- Documentação de operação e hand‑off.
- Critérios de aceite:
  - Scores Lighthouse (PWA, Perf, A11y, SEO) ≥ metas.
  - Deploy automatizado/rollback pronto.

---

## Entregáveis por Sprint
- Branches e PRs com descrição e screenshots/Lighthouse antes/depois.
- Checklists de A11y/SEO/Perf preenchidos.
- Notas de release com mudanças e riscos.

## Riscos e Mitigações
- Regressão visual: Storybook opcional ou catálogos de componentes + VRT (Percy) na fase final.
- CSP quebrando libs: evitar inline, usar `@vueuse/head` e arquivos externos; testar em ambiente staging com CSP strict.
- LCP alto por imagens: priorizar conversão e `srcset`; usar `preload` das hero images responsivas.
- GA4 e consentimento: carregar somente após consent; fallback funcional sem analytics.

## Estrutura de Pastas Proposta
```
starnew-vue/
  ├─ public/
  │  ├─ blog/            # Fase 1: posts estáticos
  │  ├─ icons/           # ícones PWA
  │  ├─ robots.txt
  │  └─ sitemap.xml
  ├─ src/
  │  ├─ assets/
  │  ├─ components/
  │  │  ├─ Header.vue
  │  │  ├─ Footer.vue
  │  │  ├─ CookieBanner.vue
  │  │  └─ ThemeToggle.vue
  │  ├─ views/
  │  │  ├─ Home.vue
  │  │  ├─ Privacidade.vue
  │  │  └─ Termos.vue
  │  ├─ router/
  │  │  └─ index.ts
  │  ├─ composables/
  │  ├─ main.ts
  │  └─ app.css
  ├─ index.html
  ├─ vite.config.ts
  ├─ tailwind.config.js
  └─ package.json
```

## Scripts e Instalação (referência)
```bash
# Scaffold
npm create vite@latest starnew-vue -- --template vue-ts
cd starnew-vue

# Dependências
npm i vue-router @vueuse/head @tanstack/vue-query zod
npm i -D tailwindcss postcss autoprefixer vite-plugin-pwa vite-plugin-compression vite-plugin-image-optimizer eslint prettier husky

# Tailwind
npx tailwindcss init -p
# Configure tailwind.config.js -> content: ["./index.html","./src/**/*.{vue,ts}"]

# Husky
npx husky init
echo 'npm run lint && npm run typecheck' > .husky/pre-commit

# Dev/Build
npm run dev
npm run build
```

## Ajustes de Nginx (history mode SPA)
```
location / {
  try_files $uri $uri/ /index.html;
}
```

## Métricas de Sucesso
- LCP ≤ 2.5s (mobile), CLS ≤ 0.1, INP ≤ 200ms (amostra real)
- Lighthouse: Perf ≥ 90, A11y ≥ 95, SEO ≥ 95, PWA installable
- Zero inline scripts/estilos (CSP sem `'unsafe-inline'`)
- CI/CD com build, lint e deploy automatizados

## Notas Finais
- Manter o blog em `public/blog` inicialmente reduz risco e acelera a entrega. A evolução para Markdown/rotas geradas pode ser feita após estabilização.
- Toda dependência de terceiros deve respeitar o consentimento (LGPD) e ser carregada de forma assíncrona/deferida.
