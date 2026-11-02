---
name: taskosaur
description: Especialista no Taskosaur, plataforma open source self-hosted de gestão de projetos com execução de tarefas por IA conversacional (kanban, sprints, dependências, time tracking, importação Jira/Trello, BYO LLM). Use para instalar o Taskosaur, estruturar projetos e sprints, quebrar features em tarefas, gerenciar via linguagem natural e integrar pela API. Triggers - taskosaur, gestão de projetos, kanban, sprint, jira alternativo, trello alternativo, gerenciar tarefas, project management self-hosted.
---

# Taskosaur

Repo: https://github.com/Taskosaur/Taskosaur · Licença BSL (Business Source License — não é OSI; leia antes de uso comercial/revenda) · Node 22+ · PostgreSQL 16 · Redis 7

## Instalação (Docker, recomendado)
```bash
git clone https://github.com/Taskosaur/Taskosaur.git taskosaur
cd taskosaur
cp .env.example .env            # ajustar segredos, SMTP, URL
docker compose -f docker-compose.dev.yml up
```
- Frontend: `http://localhost:3001` · Backend: `http://localhost:3000` · API docs (Swagger): `http://localhost:3000/api/docs`
- O compose `dev` sobe Postgres/Redis, instala deps e gera Prisma. Para produção, siga a seção Deployment do repo (não exponha o compose dev).

## IA conversacional
Configure sua chave (OpenAI, Anthropic, OpenRouter ou modelo local). Comandos como "Crie uma sprint com os bugs de alta prioridade da semana passada" são executados no app (a IA navega a interface e age).

## Estrutura de especialista para dev solo/freela
- **Workspace por cliente**, projeto por entrega.
- Colunas: Backlog → A fazer (sprint) → Em andamento (limite WIP 2) → Revisão → Feito.
- Sprints de 1 semana quando o tempo é limitado; meta de sprint em 1 frase.
- Tarefa pronta para executar: verbo + resultado + critério de aceite + estimativa (≤ 4h; maior → quebrar).
- Time tracking alimenta orçamento de freelas futuros.

## Como o Claude ajuda
- Quebrar uma feature/PRD em épicos → tarefas com critérios de aceite e dependências.
- Criar tarefas em lote pela API (veja `/api/docs` para endpoints e auth da sua versão).
- Revisão semanal: o que travou, o que entra na próxima sprint.

## Migração
Importação de **Jira e Trello** disponível — exporte de lá e importe para não recomeçar do zero.

## Verificação
Frontend abre em 3001, `/api/docs` responde em 3000, criar projeto + tarefa e movê-la no kanban.
