---
name: sqlit
description: Especialista no sqlit, TUI amigável para bancos SQL no terminal (PostgreSQL, MySQL, MariaDB, SQLite, SQL Server, DuckDB, CockroachDB, ClickHouse, Snowflake, Supabase, Turso, Oracle e mais) com gerenciador de conexões, autocomplete, histórico, descoberta de containers Docker, túnel SSH e modo CLI com saída CSV/JSON. Use para consultar, explorar e exportar dados de bancos pelo terminal, criar conexões salvas e rodar SQL em scripts. Triggers - sqlit, consultar banco no terminal, sql tui, cliente sql leve, dbeaver alternativo, exportar query para csv, conectar postgres/supabase.
---

# sqlit

Repo: https://github.com/Maxteabag/sqlit · Python · `sqlit-tui` no PyPI

## Instalação
```bash
pipx install sqlit-tui        # recomendado
uv tool install sqlit-tui
pip install sqlit-tui
yay -S sqlit                  # Arch
nix run github:Maxteabag/sqlit
```
O "dependency wizard" instala drivers que faltarem.

## Uso interativo
```bash
sqlit                          # escolhe conexão e entra
sqlit --mock=sqlite-demo       # explorar a UI sem banco
sqlit postgresql://user:pass@localhost:5432/mydb
sqlit sqlite:///caminho/banco.db
```
Atalhos aparecem no rodapé; modo Vim disponível. **Docker discovery** encontra bancos rodando em containers — Enter conecta.

## Conexões salvas (senhas vão para o keyring do SO)
```bash
sqlit connections add postgresql --name "Local" --server localhost --username user --password-command "pass show db/local"
sqlit connections add sqlite --name "App" --file-path ./app.db
# SSH tunnel
sqlit connections add postgresql --name "Remoto" --server db-host --username dbuser \
  --ssh-enabled --ssh-host ssh.exemplo.com --ssh-username sshuser --ssh-auth-type key
```
Prefira `--password-command` (1Password `op read`, `pass`, Vault) a `--password` em texto — senão a senha fica no histórico do shell.

## Modo CLI (o que o Claude deve usar em automação)
```bash
sqlit query -c "Local" -q "SELECT count(*) FROM users" --format json
sqlit query -c "Local" -f relatorio.sql --format csv > relatorio.csv
```
Saída JSON é ideal para o agente ler e analisar; CSV para planilha.

## Regras de especialista ao consultar bancos
- Em produção, conecte com **usuário read-only**.
- Sempre `LIMIT` em exploração; `EXPLAIN` antes de query pesada.
- `UPDATE`/`DELETE` só com `WHERE` revisado e dentro de transação (`BEGIN; ... ; ROLLBACK;` para testar).
- Supabase: use a connection string do pooler para scripts.

## Verificação
`sqlit query -c "<conexão>" -q "SELECT 1" --format json` retorna `1`.
