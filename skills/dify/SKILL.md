---
name: dify
description: Especialista no Dify (langgenius), plataforma open source de desenvolvimento de apps LLM com workflows visuais, pipeline RAG, agentes, suporte a centenas de modelos, prompt IDE, LLMOps e Backend-as-a-Service com API. Use para instalar o Dify self-hosted, criar chatbots, agentes e workflows de IA, montar base de conhecimento (RAG) com documentos, expor apps via API e integrar ao seu produto. Triggers - dify, workflow de ia, rag, chatbot com documentos, base de conhecimento, llmops, agente de ia low-code, flowise alternativo, n8n de ia.
---

# Dify

Repo: https://github.com/langgenius/dify · Docker Compose · mínimo 2 CPU / 4 GiB RAM · Cloud disponível

## Instalação self-hosted
```bash
git clone https://github.com/langgenius/dify.git
cd dify/docker
cp .env.example .env          # revisar SECRET_KEY, senhas, portas
docker compose up -d
```
Abrir `http://localhost/install` e criar o admin. Depois: Settings → Model Provider → chave Anthropic/OpenAI/OpenRouter ou Ollama local.

## Escolha do tipo de app (opinião)
| Precisa de… | Tipo |
|---|---|
| Responder perguntas sobre documentos | **Chatflow** + Knowledge (RAG) |
| Processo determinístico (classificar → extrair → gravar) | **Workflow** |
| Tarefa aberta com ferramentas | **Agent** |
| Prompt simples com variáveis | Chatbot/Text generator |

## RAG bem feito
- Limpe documentos antes (remova cabeçalhos/rodapés repetidos).
- Chunk ~500–800 tokens com overlap; **busca híbrida** + rerank quando disponível.
- Teste com 20 perguntas reais em "Retrieval Testing" antes de publicar.
- Instrua o modelo: responder só com base no contexto e dizer "não sei".

## Usar via API (Backend-as-a-Service)
Cada app gera uma **API key própria** (Access API):
```bash
# chat
curl -X POST 'http://localhost/v1/chat-messages' \
  -H "Authorization: Bearer $DIFY_APP_KEY" -H 'Content-Type: application/json' \
  -d '{"inputs":{},"query":"Qual o prazo de entrega?","response_mode":"blocking","user":"cliente-123"}'
# workflow
curl -X POST 'http://localhost/v1/workflows/run' \
  -H "Authorization: Bearer $DIFY_APP_KEY" -H 'Content-Type: application/json' \
  -d '{"inputs":{"texto":"..."},"response_mode":"blocking","user":"job-1"}'
```
Use `response_mode: "streaming"` (SSE) em interfaces de chat. Envie `conversation_id` para manter contexto. Confira a aba API do app para o contrato exato da sua versão.

## Integrações deste arsenal
- `deskcomm-crm`: Dify como cérebro de respostas sobre catálogo/políticas.
- `presenton`: workflow do Dify gera o conteúdo → API do Presenton gera o PPTX.
- `openobserve`: observabilidade de LLM (custos, latência) se precisar além do LLMOps nativo.

## Armadilhas
- Atualizar: `git pull` + revisar diferenças no `.env.example` antes de `docker compose up -d` — variáveis novas são comuns.
- Exponha atrás de HTTPS; a chave de app dá acesso à API do app — não coloque no frontend público sem proxy.

## Verificação
`docker compose ps` saudável; app de teste responde no "Preview" e o `curl` de chat-messages retorna `answer`.
