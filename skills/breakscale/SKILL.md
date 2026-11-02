---
name: breakscale
description: Especialista no Breakscale, simulador de system design por eventos discretos onde você monta sistemas (load balancers, caches, bancos, filas e mais 29 componentes), aumenta o tráfego até quebrar e vê latência p99, filas, circuit breakers e retry storms medidos. Roda no navegador, no VS Code e como servidor MCP. Use para validar arquitetura antes de escalar, estudar system design, achar gargalos e transformar a arquitetura de um repositório em simulação. Triggers - breakscale, system design, simular carga, gargalo, capacidade, p99, retry storm, load test de arquitetura, entrevista system design.
---

# Breakscale

Repo: https://github.com/workersio/breakscale · web: breakscale.tech · VS Code Marketplace · MCP

## Três formas de uso
1. **Navegador**: breakscale.tech, escolha um exemplo, suba o slider de tráfego até algo ficar vermelho. Sem conta; designs compartilhados são criptografados no link.
2. **VS Code**: instalar "Breakscale" → paleta → *Open Breakscale* (offline).
3. **MCP (melhor com o Claude)**:
```bash
claude mcp add --transport http --scope user breakscale https://mcp.breakscale.tech/mcp
# local: npx -y breakscale-mcp --stdio   (Node 20)
```
No claude.ai: Personalizar → Conectores → conector personalizado com a URL. Em clientes com MCP Apps, o canvas abre ao vivo no chat.

## Prompts de especialista
- "Leia este repo e transforme a arquitetura em um design Breakscale. **Diga quais números você chutou.**"
- "Projete um encurtador de URL para 2.000 req/s e mostre onde quebra."
- "Dobre o tráfego. O que falha primeiro e como corrigir **sem adicionar servidores**?"
- "Compare timeout curto + 3 retries vs timeout maior + 1 retry com backoff."

## Lições que a ferramenta deixa visíveis (use para explicar)
- Utilização > ~80% → p99 dispara (teoria de filas): planeje folga.
- Retries sem backoff/jitter transformam lentidão em queda total (exemplo **Retry Storm**: goodput zero com banco a 100%).
- Cache tem hit ratio — simule o miss storm no cold start.
- Circuit breaker e bulkhead isolam falha; rate limiter protege o núcleo.

## Fluxo recomendado
1. Desenhar o sistema atual (ou pedir ao MCP a partir do repo).
2. Calibrar com números reais quando houver (latência média do banco, RPS de pico de logs/OpenObserve).
3. Rodar 1×, 2×, 5× o pico. Anotar o primeiro componente a saturar.
4. Aplicar a correção mais barata e re-simular. Levar a conclusão para um ADR.

## Verificação
O MCP responde com números medidos e um link breakscale.tech que abre o design.
