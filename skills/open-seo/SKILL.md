---
name: open-seo
description: Especialista no OpenSEO, alternativa open source ao Semrush e Ahrefs com pesquisa de palavras-chave, rank tracking, análise de concorrentes, backlinks, auditoria de site e visibilidade em IA, com MCP e Agent Skills. Use para fazer pesquisa de SEO, auditar sites, acompanhar posições, self-hospedar o OpenSEO (Docker ou Cloudflare) e conectar o MCP ao Claude. Triggers - openseo, open seo, seo, palavras-chave, keyword research, backlinks, auditoria de site, rank tracking, semrush alternativo, ahrefs alternativo.
---

# OpenSEO

Repo: https://github.com/every-app/open-seo · dados via DataForSEO (pague só o que usar) · Hospedado: openseo.so

## Modos de uso
1. **Hospedado** (openseo.so) — mais rápido; assinatura opcional.
2. **Self-host Docker**:
```bash
git clone https://github.com/every-app/open-seo.git && cd open-seo
export COMPOSE_FILE=deploy/standalone/compose.yaml
cp deploy/standalone/.env.example deploy/standalone/.env
# no .env: STORAGE_SECRET_KEY=$(openssl rand -hex 32) e DATAFORSEO_API_KEY=<base64 de login:senha>
docker compose pull && docker compose up -d
docker compose logs -f init     # esperar "OpenSEO initialized and ready."
```
Abrir `http://localhost:3001` e **criar o admin imediatamente** (o registro fecha depois do primeiro). Requer ≥ 4 GiB para o Docker.
3. **Cloudflare** (sem servidor, plano grátis): ver `docs/SELF_HOSTING_CLOUDFLARE.md`.

Recursos opcionais no `.env`: `OPENROUTER_API_KEY` (pesquisa/resumos), Google OAuth (Search Console/Analytics). Aplicar: `docker compose up -d --force-recreate init web crawl-gateway`.

## MCP no Claude Code
```bash
claude mcp add --transport http openseo https://app.openseo.so/mcp     # hospedado
```
Self-host: use a URL da sua instância e siga a tela de setup de agentes do app. Skills oficiais: `npx skills add every-app/open-seo --skill <nome>`.

## Fluxos de especialista
- **Pesquisa de palavras-chave**: semente → volume, dificuldade, intenção → agrupar por intenção (informacional/comercial/transacional) → 1 página por cluster.
- **Concorrentes**: palavras em que eles ranqueiam e você não (gap) → priorizar por volume × facilidade.
- **Auditoria**: erros técnicos primeiro (4xx/5xx, canonical, noindex indevido, títulos duplicados, Core Web Vitals) antes de conteúdo.
- **Rank tracking**: acompanhar semanalmente, não diariamente (ruído).
- **Visibilidade em IA (GEO)**: checar se o site é citado em respostas de IA para as perguntas-chave.

## Custos
Cada consulta gasta crédito DataForSEO. Estime antes de rodar lotes grandes; o hospedado cobra ~28% sobre o custo da API.

## Verificação
`docker compose ps` saudável, admin criado, uma busca de palavra-chave retorna volume (prova que a chave DataForSEO funciona).
