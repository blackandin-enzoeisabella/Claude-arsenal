---
name: mailflare
description: Especialista no Mailflare, alternativa self-hosted ao Google Workspace com e-mail em domínio próprio, regras de roteamento, calendário, agendamento público (booking), drive e agentes de IA com MCP, rodando na Cloudflare ou em Docker. Use para implantar e-mail profissional barato (envio via Cloudflare, Resend ou Amazon SES), criar caixas, conectar domínio, importar e-mails (IMAP, Gmail Takeout, mbox) e ligar o MCP. Triggers - mailflare, email com domínio próprio, email profissional grátis, google workspace alternativo, cloudflare email, resend, ses.
---

# Mailflare

Repo: https://github.com/hieunc229/mailflare · Cloudflare Workers (D1/R2/Queues) ou 1 container Docker · 34 idiomas incluindo PT-BR

## Custo (por que é atraente)
- Receber: Cloudflare Email Routing (grátis).
- Enviar: Resend grátis (3.000/mês) ou Amazon SES (sai do sandbox pedindo produção à AWS); envio pela própria Cloudflare exige Workers Paid (US$5/mês).

## Deploy na Cloudflare
1. **Deploy to Cloudflare** — mantenha o nome do app `mailflare` (outro nome quebra).
2. Abrir `/setup`, criar admin (o /setup roda as migrações — não rode migração remota manualmente).
3. Conectar domínio (da mesma conta Cloudflare) e criar a primeira caixa.

**`CF_TOKEN` obrigatório** (secret do Worker), token com escopo:
- Todas as contas: Email Sending:Edit, DNS Settings:Edit, Email Routing Addresses:Edit
- Todas as zonas: DNS Settings:Edit, Email Routing Rules:Edit, Zone Settings:Edit, DNS:Edit

Via agente: recursos esperados — D1 `mailflare`, R2 `mailflare-raw`, filas `mailflare-inbound`, `mailflare-outbound`, `mailflare-agent`; `npm run deploy`; tokens pedidos por input secreto, **nunca** em argumento de comando ou commit.

## Docker (qualquer servidor)
```bash
cp .env.docker.example .env.docker
docker compose up -d --build
```
Banco: D1 (padrão), Postgres, MySQL, Turso/libSQL ou SQLite (`DATABASE_URL`). Arquivos: R2, B2 ou S3.

## MCP
Settings → API keys → criar chave com **Allow MCP access**, escolher caixas e ferramentas permitidas. Envio via MCP passa por `request_send`, que cria **revisão humana** antes de enviar — mantenha assim.

## Entregabilidade (checklist de especialista)
SPF, DKIM e DMARC corretos (comece DMARC com `p=none` e suba para `quarantine`); aquecer domínio novo com volume baixo; não usar para disparo em massa — para isso, serviço de e-mail marketing.

## Verificação
Enviar de Gmail para a caixa nova (chega), responder (chega no Gmail sem cair em spam), e checar cabeçalhos: `spf=pass dkim=pass dmarc=pass`.
