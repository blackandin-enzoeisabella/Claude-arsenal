---
name: cogsend
description: Especialista no CogSend, agendador de posts self-hosted na sua conta Cloudflare para Mastodon, Bluesky, LinkedIn, Threads, Instagram e X, com editor de threads, versão por plataforma, vídeo, retries automáticos, insights, API e servidor MCP. Use para instalar, conectar contas, escrever/adaptar posts por rede, agendar publicações e operar o CogSend pelo Claude via MCP. Triggers - cogsend, agendar post, agendador de redes sociais, buffer alternativo, publicar no linkedin/threads/bluesky/instagram/x.
---

# CogSend

Repo: https://github.com/cogsend/cogsend · Cloudflare Workers + D1 + R2 · docs: cogsend.com/docs

Seus posts e tokens ficam na **sua** conta Cloudflare. Instância de 1 admin costuma caber no plano grátis (R2 exige cartão cadastrado).

## Instalação
**Um clique (recomendado):**
1. Gerar chave de criptografia em cogsend.com/key e **guardar cópia** (perder = reconectar todas as contas).
2. Botão Deploy → login Cloudflare + GitHub → colar a chave em `APP_ENCRYPTION_KEY`.
3. Abrir a URL, informar a chave, e-mail, senha; configurar 2FA e salvar códigos de backup.

**Pelo terminal** (Node 22.17+, 24 ou 26+; versões ímpares não):
```bash
git clone --depth 1 https://github.com/cogsend/cogsend.git cogsend
cd cogsend && npm install && npm run setup
# atualizar depois:
git pull && npm ci && npm run deploy:release
```

## Conectar contas
Mastodon e Bluesky funcionam direto. LinkedIn, Threads, Instagram e X exigem **app OAuth** próprio (o diálogo guia) — ou conecte via Zernio.

## MCP no Claude Code
Gere uma chave em Settings (Read-only salvo se precisar publicar). `.mcp.json`:
```json
{ "mcpServers": { "cogsend": { "type": "http", "url": "https://SUA-INSTANCIA/api/mcp",
  "headers": { "Authorization": "Bearer ${COGSEND_API_KEY}" } } } }
```
Exporte `COGSEND_API_KEY` no ambiente. Nunca commite a chave.

## Escrevendo como especialista
- Um rascunho → aba por plataforma: X/Threads/Bluesky curtos e diretos; LinkedIn com gancho na 1ª linha e quebras; Instagram com legenda + hashtags no fim.
- **Auto-split** quebra texto longo em thread respeitando limites de cada rede.
- Imagens sempre com **alt text**. Vídeo: um por post, convertido no navegador quando a rede exige.
- Preview link (somente leitura, expira) para aprovação de cliente — ótimo para freelas de social media.
- Agende em lote a semana inteira; confira **Insights** (publicados vs falhos e motivo).

## Armadilhas
- Workers free permite 5 cron triggers — não crie crons extras na mesma conta sem checar.
- Falhas temporárias tentam 5×; falha permanente (token expirado) exige reconectar a conta.

## Verificação
Post de teste agendado para +2 min numa conta Mastodon/Bluesky aparece publicado em Posts com status ok.
