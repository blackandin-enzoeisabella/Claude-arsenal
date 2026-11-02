---
name: safety-net
description: Especialista no CC Safety Net (kenryu42), guarda pré-execução para agentes de código que bloqueia comandos destrutivos (git reset --hard, git push --force, rm -rf perigoso, scripts piped da internet) e acesso a segredos (.env, chaves SSH, ~/.aws, credenciais) antes da ferramenta rodar. Use para instalar, diagnosticar, escolher preset (Standard/Strict/Paranoid), adicionar rulebooks (Terraform, AWS, gcloud, Azure) e compartilhar política no repo. Triggers - safety net, cc-safety-net, claude code safety net, bloquear rm -rf, proteger .env, hook de segurança, agente destrutivo.
---

# CC Safety Net

Repo: https://github.com/kenryu42/cc-safety-net · MIT · Node.js 22+ · Windows/macOS/Linux
Suporta Claude Code, Codex, Cursor, Copilot CLI, OpenCode, Amp, Gemini/Antigravity e outros.

## Instalar (faça isso antes de dar autonomia a qualquer agente)
```bash
npx -y cc-safety-net@latest install     # instala nos CLIs de agente desta máquina
npx -y cc-safety-net@latest doctor      # confirma que a proteção está ativa
npx -y cc-safety-net@latest update
npx -y cc-safety-net uninstall
```
Mantenha o `@latest`: a spec sem versão pode reaproveitar cache antigo do npx.

## O que bloqueia
- **Destrutivos**: `git reset --hard`, `git push --force`, `git clean -fdx`, `rm -rf` em alvos perigosos, `curl ... | sh`.
- **Segredos**: SSH keys, `.env`, `~/.aws`, credenciais de CLIs — tanto via shell quanto pelas ferramentas de arquivo do agente.

## Ajustar política
```bash
npx cc-safety-net gui        # presets Standard / Strict / Paranoid, liga/desliga regras
```
- **Rulebooks oficiais**: Terraform, AWS, gcloud, Azure — ative se mexe com infra.
- **Regras próprias** em JSON (rulebook custom).
- **Time**: commite `.cc-safety-net/` no repo → clones e sessões na nuvem herdam a mesma política.
- **Biblioteca**: `checkCommand` em Node para embutir em ferramentas próprias.

## Recomendação de especialista
- Solo dev: **Standard** global + **Strict** em repos de produção/infra.
- Se usa `--dangerously-skip-permissions` (ex.: Vibecraft, Emdash): **Strict** ou **Paranoid**, sem exceção.
- Quando bloquear algo legítimo: não desinstale — rode o comando você mesmo no terminal, ou crie exceção específica na GUI.
- Camada complementar: `pasteguard` (o que sai para o provedor) — safety-net cuida do que o agente executa/lê localmente.

## Verificação
`npx -y cc-safety-net@latest doctor` sem falhas. Teste real numa pasta descartável: peça ao agente `git reset --hard HEAD~1` → deve ser bloqueado antes de executar.
