---
name: presenton
description: Especialista no Presenton, gerador open source de apresentações com IA (alternativa ao Gamma, Canva e Beautiful.ai), self-hosted via Docker ou desktop, com PPTX totalmente editável e PDF, templates próprios em HTML/Tailwind, BYOK (OpenAI, Anthropic, Gemini, Ollama...), API REST e servidor MCP. Use para gerar slides a partir de prompt ou documento, automatizar decks via API, criar templates a partir de um PPTX existente e rodar com modelos locais. Triggers - presenton, gerar apresentação, slides com ia, pptx automático, gamma alternativo, deck por api, pitch deck.
---

# Presenton

Repo: https://github.com/presenton/presenton · Apache 2.0 · Docker / desktop (Mac, Windows, Linux)

## Subir
```bash
docker run -it --name presenton -p 5001:80 \
  -e AUTH_USERNAME=admin -e AUTH_PASSWORD=troque-esta-senha \
  -v "./app_data:/app_data" \
  ghcr.io/presenton/presenton:latest
```
`http://localhost:5001`. Configure provedor de texto e imagem (OpenAI, Gemini, Anthropic, Azure, Bedrock, Ollama, endpoint compatível; imagens: GPT Image, Gemini, Pexels, Pixabay). Para não enviar nada à galeria Community: `-e PRESENTON_COMMUNITY_ENABLED=false`.

## API (automação)
Admin → API keys → gerar `sk-presenton-...`.
```bash
curl -X POST http://localhost:5001/api/v1/ppt/presentation/generate \
  -H "Authorization: Bearer $PRESENTON_KEY" -H "Content-Type: application/json" \
  -d '{"content":"Proposta comercial: app de controle financeiro para salões","n_slides":8,"language":"Portuguese","template":"general","export_as":"pptx"}'
```
- `export_as`: `pptx` ou `pdf`.
- Arquivos de base: enviar antes em `/api/v1/ppt/files/upload`.
- Controle total do conteúdo por slide com `slides_markdown`.
MCP embutido para gerar apresentações direto do agente.

## Receita de deck que convence (o Claude escreve o `content`)
1. Título + promessa em 1 frase. 2. Problema (dado concreto). 3. Solução. 4. Como funciona (3 passos). 5. Prova (case/número). 6. Preço/plano. 7. Próximos passos/CTA.
Uma ideia por slide, título como afirmação ("Reduz faltas em 30%"), não tópico ("Benefícios").
Gere com `slides_markdown` quando o conteúdo já estiver decidido — a IA só diagrama.

## Templates
- Copie um template embutido para **Custom** e edite.
- **AI Template Generation**: crie template a partir de um PPTX com sua identidade visual.

## Combina com
`textream` (importa notas do apresentador do PPTX), `dify` (workflow gera conteúdo → API do Presenton).

## Armadilhas
- Sem volume `app_data`, apresentações e configs somem ao recriar o container.
- Defina `AUTH_USERNAME/PASSWORD` se o host for acessível por outras pessoas.

## Verificação
O `curl` de geração retorna caminho/URL do arquivo; o PPTX abre editável no PowerPoint/LibreOffice.
