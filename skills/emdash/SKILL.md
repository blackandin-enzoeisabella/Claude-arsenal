---
name: emdash
description: Especialista no Emdash (generalaction, YC W26), ambiente de desenvolvimento agêntico desktop open source que roda vários agentes de código em paralelo (Claude Code, Codex, OpenCode, Amp, Cursor...), cada tarefa em seu próprio git worktree, com revisão de diffs, PRs, CI e projetos remotos via SSH. Use para planejar e executar trabalho paralelo com agentes, transformar issues (GitHub, Linear, Jira) em tarefas de agente e comparar soluções. Triggers - emdash, agentes em paralelo, worktree, multi-agente, rodar vários claude, parallel coding agents. (Não confundir com EmDash CMS em Astro.)
---

# Emdash — agentes de código em paralelo

Repo: https://github.com/generalaction/emdash · Apache-2.0 · app desktop (builds em Releases)

> Atenção ao nome: existe também o **EmDash CMS** (emdash-cms/emdash, CMS TypeScript sobre Astro). Se o usuário falar de "CMS", "sucessor do WordPress" ou Astro, é o outro — confirme.

## O que resolve
Rodar N agentes ao mesmo tempo sem conflito: cada tarefa = branch + **git worktree** isolado. Você compara diffs, abre PR, vê CI e faz merge do que funcionou.

## Instalação
Baixar o build da última release (macOS/Windows/Linux). O Emdash detecta automaticamente os CLIs de agente instalados (Claude Code, Codex, Cursor, OpenCode, Amp, Devin, Qwen Code, Droid, Copilot).
Telemetria opcional: desligar em Settings ou iniciar com `TELEMETRY_ENABLED=false`.

## Fluxo recomendado
1. Projeto local ou **remoto via SSH/SFTP** (credenciais no keychain do SO).
2. Puxe issues de GitHub, Linear, Jira, GitLab, Asana etc. → cada issue vira tarefa de um agente.
3. Para problemas difíceis, rode **2–3 agentes na mesma tarefa** com abordagens diferentes e escolha o melhor diff.
4. Revise o diff, rode testes, abra PR pelo próprio Emdash, acompanhe CI, merge.

## Como o Claude ajuda aqui
- Quebrar uma feature em tarefas **independentes** (sem tocar os mesmos arquivos) para paralelizar sem conflito de merge.
- Escrever prompts de tarefa autocontidos: objetivo, arquivos envolvidos, critério de pronto, comando de teste.
- Revisar os diffs concorrentes e recomendar qual mergear.

## Armadilhas
- Hooks: o Emdash instala entradas marcadas na config do agente para rastrear status; se usar `vibecraft` ou `safety-net`, confira `~/.claude/settings.json` depois.
- Worktrees compartilham o `.git`: não rode `git gc --prune` agressivo com tarefas abertas.
- Agentes em paralelo multiplicam custo de API — limite a quantidade.
- Dependências: cada worktree precisa do seu `node_modules`/venv; considere cache (pnpm store) para não estourar disco.

## Verificação
Criar duas tarefas no mesmo repo → dois worktrees em branches distintas aparecem em `git worktree list`.
