---
name: webssh
description: Especialista no WebSSH (huashengdun), cliente SSH no navegador em Python (tornado, paramiko, xterm.js) com senha, chave pública (RSA, ECDSA, Ed25519, chaves criptografadas) e 2FA TOTP. Use para dar acesso SSH via navegador, subir o wssh com HTTPS, configurar política de host key, rodar atrás de proxy reverso ou em Docker, e endurecer a segurança. Triggers - webssh, wssh, ssh no navegador, terminal web, acessar servidor pelo browser.
---

# WebSSH

Repo: https://github.com/huashengdun/webssh · Python 3.10+

```
browser <== http/websocket ==> webssh <== ssh ==> servidor ssh
```

## Rápido
```bash
pip install webssh
wssh                       # http://127.0.0.1:8888
```

## Opções que importam
```bash
wssh --address='127.0.0.1' --port=8888           # só local (padrão seguro)
wssh --certfile=cert.crt --keyfile=cert.key      # HTTPS
wssh --policy=reject                             # rejeita host key desconhecida (recomendado)
wssh --logging=debug --log-file-prefix=main.log
wssh --help
```
Conexão por URL/console do navegador: `wssh.connect(hostname, port, username, password, privatekey, passphrase, totp)`.

## Segurança — leia antes de expor
O WebSSH vira um **ponto de entrada para todos os seus servidores**. Regras:
1. **Nunca** exponha na internet sem camada de autenticação na frente (Cloudflare Access, Tailscale, oauth2-proxy, basic auth no proxy).
2. Sempre HTTPS (direto ou via Caddy/Nginx com WebSocket habilitado).
3. `--policy=reject` + host keys conhecidas — evita MITM.
4. Prefira chave Ed25519 com passphrase a senha; ative TOTP no servidor alvo.
5. Rodar como usuário sem privilégio, de preferência em container isolado.

## Proxy reverso (Caddy)
```
ssh.seudominio.com {
    reverse_proxy 127.0.0.1:8888
}
```
(Caddy repassa WebSocket automaticamente.) Inicie o wssh com `--xheaders` atrás de proxy para obter o IP real (confira `wssh --help` da sua versão).

## Alternativas
Gerenciar containers com terminal integrado: `dockge` / `logdeck` já trazem terminal web — talvez você nem precise do WebSSH.

## Verificação
Abrir a URL, conectar num host de teste com chave, rodar `uname -a`; tentar host com key desconhecida sob `--policy=reject` deve falhar.
