---
name: pasteguard
description: Especialista no PasteGuard, proxy local de privacidade que mascara PII e segredos (nomes, e-mails, telefones, cartões, chaves de API, tokens, senhas) antes de chegarem ao ChatGPT, Claude, Gemini, APIs de LLM ou agentes de código. Use quando houver dados de clientes, logs de produção, credenciais ou LGPD/GDPR envolvidos no uso de IA, para instalar o proxy, configurar Mask Mode ou Route Mode e apontar apps/SDKs para ele. Triggers - pasteguard, mascarar pii, anonimizar dados para ia, lgpd ia, vazamento de segredo, redact, proxy de privacidade.
---

# PasteGuard

Repo: https://github.com/sgasser/pasteguard · Apache 2.0 · Bun + Hono + GLiNER · SQLite/Postgres

O provedor vê placeholders; você mantém os originais. Respostas são restauradas no caminho de volta (inclusive streaming).

## Três lugares de proteção
1. **Chat no navegador** — extensão experimental para ChatGPT, Claude, Gemini.
2. **Apps e APIs** — troque a base URL do SDK pelo proxy.
3. **Agentes de código** — Claude Code, Codex, Cursor etc. (ver docs "Coding Agents").

## Subir o proxy
```bash
docker run --rm -p 3000:3000 ghcr.io/sgasser/pasteguard:latest
# se o detector (0.9.3) sair com SIGSEGV:
docker run --rm -p 3000:3000 -e ORT_DISABLE_TELEMETRY=1 ghcr.io/sgasser/pasteguard:latest
```
Dashboard em `http://localhost:3000` — mostra o que foi detectado, mascarado e o que chegou ao provedor.
Para logs persistentes, Compose ou modelos GLiNER próprios: docs do projeto.

## Apontar um app
```python
from openai import OpenAI
client = OpenAI(base_url="http://localhost:3000/openai/v1")
# chat.completions.create(...) e responses.create(...) passam pelo pipeline
```

## Modos
- **Mask Mode**: substitui PII/segredos por placeholders e restaura na resposta.
- **Route Mode**: requisições com dado sensível vão para LLM local (Ollama, vLLM, llama.cpp); o resto segue para a nuvem.

## O que detecta
Nomes, locais, e-mails, telefones, cartões, IBAN, IPs, VAT (multilíngue); chaves OpenAI/Anthropic/Stripe/AWS/GitHub, chaves SSH/PEM, JWT, bearer tokens, senhas, connection strings.

## Opinião de especialista
- **CPF/CNPJ**: valide no dashboard se estão sendo pegos para o seu caso; se não, configure regra/entidade custom antes de usar com dados BR.
- Detecção semântica tem falso negativo: PasteGuard **reduz** risco, não substitui contrato/DPA com o provedor nem política de dados.
- Rode na mesma máquina/rede do app; o proxy vê tudo em claro — proteja-o como um segredo.
- Combine com `safety-net` (bloqueia leitura de `.env`/chaves pelo agente) — camadas diferentes.

## Verificação
Enviar via proxy: "Meu e-mail é joao@exemplo.com e minha chave sk-test-123" → no dashboard o request ao provedor deve mostrar placeholders, e a resposta volta com os valores restaurados.
