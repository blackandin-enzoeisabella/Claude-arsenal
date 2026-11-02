---
name: arsenal
description: Roteador do arsenal de ferramentas open source. Use quando a tarefa envolver escolher ou combinar ferramentas para vídeo (editar, cortar, gravar tela, clipes), automação de navegador, CRM/WhatsApp, e-mail próprio, agendar posts, self-hosting com Docker, logs/observabilidade, banco de dados no terminal, finanças pessoais, gestão de projetos, apresentações, workflows de IA/RAG, diagramas, SEO, privacidade de dados para LLM ou segurança de agentes. Também quando o usuário digitar /arsenal ou perguntar "qual ferramenta uso para X".
---

# Arsenal — roteador de ferramentas

Você tem 30 skills de especialista instaladas. Esta skill decide **qual usar**, e em que ordem.
Regra: identifique a intenção → escolha a skill pela tabela → carregue a skill específica e siga-a.
Se duas servem, prefira a que já está instalada/rodando na máquina do usuário (verifique antes de instalar outra).

## Mapa intenção → skill

| Intenção do usuário | Skill | Por quê |
|---|---|---|
| Editar vídeo com timeline, no navegador, sem marca d'água | `openreel` | Editor visual completo, local |
| Cortar/converter/legendar/exportar vídeo via comando | `ffmpeg` | Determinístico, scriptável, verificável |
| Transformar podcast/live longa em clipes verticais | `bridgeclip` | IA encontra os momentos e reenquadra |
| Gravar demo/tutorial de tela com zoom automático | `recordly` | Gravador + editor focado em demos |
| Teleprompter para gravar/apresentar | `textream` | Rastreia a fala palavra por palavra (macOS/iOS) |
| Ditado por voz offline (speech-to-text) | `handy` | Whisper/Parakeet local, cola no app ativo |
| Automatizar navegador, scraping, testar UI, preencher formulário | `agent-browser` | CLI feita para agentes, refs de acessibilidade |
| CRM com agentes de IA no WhatsApp | `deskcomm-crm` | Self-hosted, LGPD, feito para vendas por chat |
| E-mail com domínio próprio + agenda + drive | `mailflare` | Alternativa ao Google Workspace na Cloudflare |
| Arquivar/indexar/buscar e-mails para compliance | `open-archiver` | Ingestão IMAP/Gmail/M365/PST, retenção, legal hold |
| Agendar posts em redes sociais | `cogsend` | Self-hosted na Cloudflare, tem MCP |
| Gerenciar stacks docker compose com UI | `dockge` | Arquivos compose continuam seus |
| Ver logs de containers, alertas de container caído | `logdeck` | Binário Go único, CLI + MCP |
| Observabilidade completa (logs, métricas, traces, RUM) | `openobserve` | Alternativa barata ao Datadog/Elastic |
| Terminal SSH no navegador | `webssh` | `pip install webssh` e pronto |
| Consultar banco SQL no terminal (Postgres, MySQL, SQLite...) | `sqlit` | TUI + modo CLI com saída CSV/JSON |
| Simular arquitetura e achar o gargalo antes de escalar | `breakscale` | Simulação de eventos discretos, MCP |
| Diagrama de arquitetura / fluxo desenhado à mão | `excalidraw-mcp` | MCP oficial do Excalidraw |
| Construir app/workflow de IA, RAG, chatbot com API | `dify` | Plataforma LLMOps visual + API |
| Gerar apresentação PPTX/PDF por IA ou API | `presenton` | Self-hosted, PPTX editável, API REST |
| Gestão de projetos/sprints/kanban self-hosted | `taskosaur` | PM com IA conversacional |
| Finanças pessoais, lançar gastos, importar extrato OFX/CSV | `ezbookkeeping` | Leve, roda em Raspberry Pi, tem MCP |
| Inventário doméstico (o que tenho e onde está) | `kept` | QR codes, mapa 3D, MCP |
| SEO: palavras-chave, backlinks, auditoria, rank | `open-seo` | Alternativa ao Semrush/Ahrefs, paga por uso |
| Mascarar PII/segredos antes de mandar para LLM | `pasteguard` | Proxy local de privacidade |
| Bloquear comandos destrutivos de agentes (rm -rf, push --force) | `safety-net` | Hook pré-execução |
| Rodar vários agentes de código em paralelo (worktrees) | `emdash` | App desktop de orquestração |
| Alternativa open source ao Claude Cowork / skills compartilhadas | `openwork` | Desktop + MCP de capacidades |
| Visualizar o que o Claude Code está fazendo (3D) | `vibecraft` | Hooks + visualização ao vivo |
| Mapa 3D global com voos, navios, satélites ao vivo (OSINT) | `gods-eye-view` | Dados públicos, controle por voz |

## Combos prontos (pipelines)

- **Fábrica de conteúdo**: `recordly` (grava) → `ffmpeg` (corta, normaliza áudio, exporta 9:16) → `bridgeclip` (clipes de trechos longos) → `cogsend` (agenda nas redes). Roteiro antes com `textream`.
- **Servidor self-hosted**: `dockge` (sobe stacks) → `logdeck` (logs/alertas por container) → `openobserve` (quando precisar de métricas/traces) → `webssh` (acesso de emergência).
- **Negócio BR vendendo por WhatsApp**: `deskcomm-crm` + `mailflare` (e-mail do domínio) + `open-archiver` (guarda e-mails) + `taskosaur` (operação) + `ezbookkeeping` (caixa pessoal).
- **Agentes de código seguros**: `safety-net` (sempre) + `pasteguard` (quando houver dados de cliente) + `emdash` (paralelismo) + `vibecraft` (visibilidade).
- **Produto de IA**: `dify` (backend de IA) + `presenton` (relatórios em slides via API) + `agent-browser` (testes E2E) + `breakscale` (capacidade).

## Regras gerais para todas as skills do arsenal

1. **Verifique antes de instalar**: `command -v <bin>`, `docker ps`, porta ocupada (`ss -ltnp | grep <porta>`).
2. **Segredos nunca em linha de comando ou commit**: use `.env` (no `.gitignore`) ou variável de ambiente; tokens de MCP via `${VAR}`.
3. **Exposição à internet**: nada de painel admin aberto sem autenticação + HTTPS (proxy reverso tipo Caddy/Traefik ou Cloudflare Tunnel/Tailscale).
4. **Versões mudam**: os comandos foram verificados nos READMEs oficiais em 2026-11-02. Se algo falhar, leia o README atual do repo (link em cada skill) antes de improvisar.
5. **Feche o ciclo**: toda skill termina com uma verificação (healthcheck, `curl`, `doctor`, abrir a URL). Não declare pronto sem verificar.
