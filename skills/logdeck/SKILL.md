---
name: logdeck
description: Especialista no LogDeck, logs persistentes, alertas e gestão de containers Docker/Podman em um único binário Go, com busca por texto/regex/nível, terminal, edição de env e limites, multi-host via socket/TCP/SSH, CLI e servidor MCP. Use para ver e buscar logs de containers, alertar container morto/OOM/padrão de log no Slack, Discord, Telegram, ntfy, e dar ao Claude acesso aos logs via MCP. Triggers - logdeck, logs docker, logs de container, dozzle alternativo, alerta container caiu, oom, docker logs.
---

# LogDeck

Repo: https://github.com/AmoabaKelvin/logdeck · GPL-3.0 · Go · Docker e Podman

Diferencial vs Dozzle: **guarda logs em disco** — sobrevive a `docker compose up --build` e containers removidos.

## Subir
```bash
docker run -d --name logdeck \
  -p 8123:8080 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /proc:/host/proc:ro \
  -v logdeck-data:/data \
  --restart unless-stopped \
  amoabakelvin/logdeck:latest
```
`http://localhost:8123`. **Inicia sem login — ative autenticação em Settings antes de expor.** Mantenha o volume `logdeck-data` (config, logs, histórico de alertas).

## CLI + MCP (para o Claude investigar incidentes)
```bash
curl -fsSL https://raw.githubusercontent.com/AmoabaKelvin/logdeck/main/install.sh | sh   # leia o script antes
logdeck grep "connection refused"     # busca nos logs recentes de todos os containers
logdeck mcp                           # MCP via stdio
```
Ambos usam token de API (Settings): **`read`** só observa, **`admin`** age. Dê `read` ao agente por padrão.
```bash
claude mcp add logdeck -- logdeck mcp
```

## Alertas que todo servidor deveria ter
1. Container morreu (exit ≠ 0).
2. OOM kill.
3. Padrão de log: `ERROR|FATAL|panic|Traceback` nos serviços principais (com cooldown para não spammar).
Canais: Slack, Discord, ntfy, Gotify, Telegram ou webhook.

## Fluxo de incidente com o Claude
1. `logdeck grep` pelo erro → identificar container e horário.
2. Correlacionar com deploy/restart (o LogDeck mostra containers removidos via filtro Removed).
3. Ajustar env/limites de memória pela UI sem recriar o container, se for o caso.
4. Precisa de métricas/traces entre serviços? Escale para `openobserve`.

## Armadilhas
- Socket do Docker = root no host. Restrinja quem acessa a UI; considere socket-proxy em produção.
- Retenção: configure para não lotar o disco (docs: Log history).

## Verificação
UI lista os containers; `docker run --rm alpine sh -c 'echo ERRO_TESTE; exit 1'` aparece nos logs e dispara o alerta de container morto.
