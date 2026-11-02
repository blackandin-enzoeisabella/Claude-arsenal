---
name: agent-browser
description: Especialista no agent-browser (vercel-labs), CLI nativa em Rust de automação de navegador para agentes de IA. Use quando precisar abrir sites, clicar, preencher formulários, fazer scraping, tirar screenshot/PDF, testar UI end-to-end, extrair texto de página renderizada ou automatizar fluxos web pelo terminal. Triggers - agent-browser, automação de navegador, browser automation, scraping, headless chrome, testar site, preencher formulário, screenshot de página.
---

# agent-browser

Repo: https://github.com/vercel-labs/agent-browser · CLI Rust · Chrome for Testing

CLI pensada para agentes: em vez de seletores frágeis, você tira um **snapshot da árvore de acessibilidade** e age por **refs** (`@e2`). Barato em tokens e robusto.

## Instalação
```bash
npm install -g agent-browser     # ou: brew install agent-browser | cargo install agent-browser
agent-browser install            # baixa o Chrome for Testing (1ª vez)
agent-browser install --with-deps   # Linux: instala libs do sistema
agent-browser upgrade            # atualiza pelo método de instalação detectado
```

## Loop padrão (sempre este)
```bash
agent-browser open https://exemplo.com
agent-browser snapshot                  # árvore com refs @eN
agent-browser fill @e3 "email@x.com"
agent-browser click @e5
agent-browser snapshot                  # SEMPRE re-snapshot depois de navegar/mudar a página
agent-browser get text @e1
agent-browser screenshot --if-changed pagina.png
agent-browser close
```
Refs mudam quando a página muda — nunca reutilize um ref antigo após navegação.

## Comandos úteis
- `read [url]` — texto legível da página (melhor que screenshot para conteúdo).
- `screenshot --annotate` — imagem com elementos numerados (para depurar visualmente).
- `screenshot --full` / `pdf arquivo.pdf`.
- `find role button click --name "Enviar"` — por papel ARIA.
- `select`, `check`, `upload <sel> <arquivos>`, `drag`, `press Enter`, `scroll down 500`.
- `eval "<js>"` — JavaScript na página (use com parcimônia).
- `connect <porta>` — anexar a um Chrome já aberto via CDP (sessões logadas).

## Boas práticas de especialista
- Prefira `read`/`get text` a screenshots: menos tokens, mais exato.
- `screenshot --if-changed` evita imagens repetidas.
- Clique falha cedo se outro elemento cobre o alvo (banner de cookies, modal): feche o elemento indicado e re-snapshot.
- Para testes E2E: script bash com a sequência + `get text` para asserts; saída não-zero = falha.
- Respeite termos de uso/robots e não automatize login em contas de terceiros sem autorização.

## Verificação
`agent-browser open https://example.com && agent-browser get text "h1"` deve retornar "Example Domain".
