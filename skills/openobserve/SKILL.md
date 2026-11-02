---
name: openobserve
description: Especialista no OpenObserve (O2), plataforma de observabilidade open source para logs, métricas, traces (OpenTelemetry), RUM, session replay, alertas, dashboards, pipelines e observabilidade de LLM, alternativa ao Datadog, Splunk e Elasticsearch com armazenamento muito mais barato em binário único. Use para instalar o OpenObserve, enviar logs/traces/métricas de apps (Node, Python, FastAPI, Next.js), criar dashboards e alertas, e consultar com SQL/PromQL. Triggers - openobserve, observabilidade, logs centralizados, traces, opentelemetry, otel, datadog alternativo, elasticsearch alternativo, monitoramento, apm.
---

# OpenObserve

Repo: https://github.com/openobserve/openobserve · Rust · binário único ou Docker/Helm · Cloud com free tier (50 GB/dia)

## Subir local/servidor
```bash
docker run -d --name openobserve \
  -v $PWD/data:/data \
  -p 5080:5080 \
  -e ZO_ROOT_USER_EMAIL="voce@exemplo.com" \
  -e ZO_ROOT_USER_PASSWORD="TroqueEstaSenha#2026" \
  public.ecr.aws/zinclabs/openobserve:latest
```
UI: `http://localhost:5080`. Troque a senha do exemplo; em produção use variáveis de um `.env`.

## Enviar dados
**Logs JSON (teste rápido):**
```bash
curl -u voce@exemplo.com:SENHA -X POST \
  http://localhost:5080/api/default/app_logs/_json \
  -H 'Content-Type: application/json' \
  -d '[{"level":"info","msg":"teste","service":"api"}]'
```
(`default` = organização, `app_logs` = stream.)

**OpenTelemetry (traces/métricas/logs)** — padrão recomendado: aponte o exporter OTLP HTTP para `http://<host>:5080/api/default` com header `Authorization: Basic <base64 email:senha>`. A UI mostra em "Data Sources/Ingestion" os snippets exatos por linguagem — copie de lá para sua versão.
- Python/FastAPI: `opentelemetry-instrument` + `OTEL_EXPORTER_OTLP_ENDPOINT`.
- Node/Next.js: `@opentelemetry/sdk-node` com auto-instrumentations.
- Containers: Fluent Bit / Vector / OTel Collector lendo logs do Docker.
- Frontend: RUM + session replay pelo SDK de browser.

## Consultar
Logs com SQL (`SELECT * FROM app_logs WHERE level='error' ORDER BY _timestamp DESC LIMIT 50`); métricas com SQL ou PromQL; traces com waterfall e service graph.

## Alertas e dashboards mínimos (opinião)
- Dashboard: RPS, taxa de erro, p95/p99 de latência por serviço (RED).
- Alertas: taxa de erro > X% em 5 min; p99 > SLO; ausência de logs de um serviço (morto silencioso).
- Pipelines no ingest para **redigir dados sensíveis** e reduzir volume.

## Quando NÃO usar
Um VPS com poucos containers e só logs → `logdeck` é mais simples. Dados no OpenObserve são **imutáveis** (só se apaga por retenção) — bom para auditoria, defina retenção antes.

## Verificação
O `curl` de ingestão retorna sucesso e o registro aparece em Logs → stream `app_logs`.
