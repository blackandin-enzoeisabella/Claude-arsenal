---
name: vibecraft
description: Especialista no Vibecraft (Nearcyan), visualização 3D ao vivo das sessões do Claude Code via hooks, com orquestração de múltiplas instâncias em tmux, feed de atividade, entrada por voz e áudio espacial. Use para instalar/configurar o Vibecraft, rodar vários Claudes em paralelo e mandar prompts pelo navegador, ou depurar hooks. Triggers - vibecraft, vibecraff, visualizar claude code, multi-claude, workshop 3d, hooks do claude code.
---

# Vibecraft

Repo: https://github.com/Nearcyan/vibecraft · MIT · macOS/Linux (Windows não — hooks exigem bash) · Node 18+

Mostra o Claude "andando" entre estações de um workshop 3D conforme usa ferramentas; captura respostas, subagentes, erros e commits. Usa suas instâncias locais — nada de arquivos ou prompts é enviado.

## Instalação
```bash
# dependências
brew install jq tmux            # macOS
sudo apt install jq tmux        # Debian/Ubuntu

npx vibecraft setup             # configura os hooks do Claude Code (uma vez)
npx vibecraft                   # servidor → http://localhost:4003
# opções: --port/-p <porta>
```
Online: vibecraft.sh também conecta às instâncias locais.
Desinstalar: `npx vibecraft uninstall` (remove hooks, mantém dados).

## Controle pelo navegador
```bash
tmux new -s claude
claude
```
Na visualização, marque "Send to tmux" e envie prompts.

## Multi-clauding (o recurso que importa)
- **+ New** (`Alt+N`): cria sessão com nome, diretório e flags (`-r`, `--chrome`, `--dangerously-skip-permissions`).
- `1-6` seleciona sessão; cada uma roda em seu tmux com status idle/working/offline.
- Zonas pulsam quando uma sessão precisa de input ou termina.
- Detalhes da API em `docs/ORCHESTRATION.md` do repo.

## Opinião de especialista
- **Não** use `--dangerously-skip-permissions` em sessões paralelas sem a skill `safety-net` instalada — o paralelismo multiplica o raio de estrago.
- Para paralelismo com isolamento de código (worktrees, PRs), `emdash` é melhor; Vibecraft é sobre **visibilidade e controle**.
- Voz exige chave Deepgram.

## Armadilhas
- Sem `jq`, os hooks falham silenciosamente — teste `command -v jq`.
- Se outra ferramenta (ex. Emdash, safety-net) também instala hooks, confira `~/.claude/settings.json` após o setup para garantir que nenhum sobrescreveu o outro.

## Verificação
Com o servidor rodando, executar qualquer comando no Claude Code deve mover o personagem e aparecer no feed.
