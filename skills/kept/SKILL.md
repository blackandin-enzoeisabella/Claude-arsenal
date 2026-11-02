---
name: kept
description: Especialista no Kept (keptinventory), inventário self-hosted de tudo que você possui e onde está - locais, cômodos, prateleiras, caixas e itens com fotos, notas fiscais, manuais, garantias, etiquetas QR, mapa 3D, empréstimos, mudança de casa, lembretes, veículos, assistente de IA e servidor MCP. Use para instalar o Kept, organizar inventário doméstico ou de pequeno negócio, imprimir etiquetas, controlar garantias e conectar ao Claude via MCP. Triggers - kept, inventário doméstico, onde guardei, etiquetas qr para caixas, controle de garantia, homebox alternativo, mudança de casa.
---

# Kept

Repo: https://github.com/keptinventory/kept · self-hosted (Docker Compose ou Kubernetes) · site keptinventory.info

> Há outro projeto "kept" (ericerkz/kept, notas estilo Google Keep). Se o usuário falar de **notas**, confirme qual.

## Instalação (Compose v2; testado com 1 GB RAM / 1 CPU)
```bash
mkdir kept && cd kept
curl -fsSLO https://raw.githubusercontent.com/keptinventory/kept/v1.14.3/compose.yaml   # verifique a versão mais recente nas releases
docker compose run --rm init     # pergunta o endereço (prefira nome: http://kept.home.arpa:8080), gera .env e o código de setup
docker compose up -d             # porta 8080 (KEPT_HTTP_PORT muda)
```
Abrir o endereço, informar o código de setup, criar a primeira conta (vira admin). **Use um nome de host estável** — ele vai impresso nos QR codes das etiquetas.

## Modelo de dados
Local (casa, garagem, depósito) → place (cômodo, prateleira) → caixa → item. Itens: fotos, documentos (nota fiscal, manual), tags, campos customizados, quantidade.

## Fluxos de especialista
- **Etiquetar primeiro**: imprima folha de etiquetas (ID curto + QR) e cole nas caixas antes de cadastrar; depois cadastre escaneando.
- **Captura por foto**: fotografe item/nota fiscal/etiqueta → seu provedor de IA sugere os campos (OpenAI, Anthropic, Google, OpenRouter, Groq ou Ollama local) → você confirma.
- **Garantias e revisões**: lembretes por app, e-mail, push, ntfy, Telegram ou feed de calendário.
- **Mudança**: caixas numeradas com folha de conteúdo, rastreadas no caminhão, desempacotadas por scan.
- **Empréstimos**: quem está com o quê e quando devolve (sem conta para quem pegou).
- **Seguro**: relatório de seguro gerado do inventário.

## MCP
Agentes conectam em `<sua-instancia>/mcp` (ver docs "MCP clients"). Alterações pedidas pelo assistente aguardam sua confirmação.

## Privacidade
Sem telemetria; checagem de update desligada por padrão; IA só se você ligar. Instalável como app no celular (funciona offline). Integração com Home Assistant disponível.

## Verificação
`docker compose ps` saudável; criar uma caixa, imprimir a etiqueta, escanear o QR com o celular → abre a caixa.
