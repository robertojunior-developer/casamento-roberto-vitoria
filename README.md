# Roberto & Vitória — site de casamento v2

Site premium com **React/Vite**, API **Java 21 + Spring Boot 3**, **PostgreSQL 16** e migrações **Flyway**. Mantém o visual da primeira versão, substituindo o armazenamento local por dados compartilhados no servidor.

## O que funciona

- RSVP persistido no PostgreSQL (com acompanhantes, crianças e observações).
- Lista de presentes editável no painel; intenções de presente registradas como **pendentes**, nunca como pagamento automático.
- PIX direto configurável via variável de ambiente (chave exibida para copiar); sem integração bancária.
- Mural de mensagens com aprovação antes de publicação.
- Administração protegida por HTTP Basic no servidor; exportação CSV de RSVP e contribuições.
- API com validação de dados, SQL parametrizado e credenciais fora do frontend.

## Instalação local

**Pré-requisitos:** Java 21, Maven 3.9+, Node 20+, Docker + Docker Compose.

1. Copie `.env.example` para `.env` e configure `DATABASE_PASSWORD`, `ADMIN_USER`, `ADMIN_PASSWORD` (senhas fortes e diferentes), `PIX_KEY`, `PIX_NAME`, `PIX_BANK`.
2. No terminal, na pasta raiz, execute `docker compose --env-file .env up -d`.
3. Em outro terminal, abra `backend` e execute:

```bash
export DATABASE_PASSWORD='sua-senha-do-env'
export ADMIN_PASSWORD='sua-senha-admin'
export ADMIN_USER='admin'
export PIX_KEY='sua-chave-pix'
export PIX_NAME='nome-do-favorecido'
export PIX_BANK='seu-banco'
mvn spring-boot:run
```

No Windows PowerShell, use `$env:DATABASE_PASSWORD="..."` e assim por diante, ou configure as variáveis no IDE.

4. Em outro terminal, abra `frontend` e execute `npm install` e `npm run dev`.
5. Acesse a URL informada pelo Vite. O proxy `/api` encaminha para `localhost:8080`.
6. Clique no cadeado do menu para entrar no painel com `ADMIN_USER` e `ADMIN_PASSWORD`.

## Deploy

Hospede frontend e API no mesmo domínio (proxy `/api`), com **HTTPS obrigatório** e banco PostgreSQL gerenciado com backups. Não exponha a porta do PostgreSQL à internet. Configure todas as variáveis de ambiente no servidor, não no repositório. Para um deploy de produção, acrescente rate limiting/CAPTCHA nos formulários públicos, proteção de dados/LGPD, monitoramento, backups e um fluxo de autenticação administrativa com sessão segura/2FA. HTTP Basic é uma primeira proteção de MVP e deve ser usado apenas sobre HTTPS.

## Atenção

- Data, local e fotos são exemplos editáveis em `frontend/src/main.jsx` (`CONFIG`). Confirme os dados antes de publicar.
- **Não existe cobrança de cartão de crédito nem confirmação automática de PIX**. Os valores informados pelos convidados são intenções; confirme cada depósito no extrato bancário antes de marcar como recebido.
- Não importe o `localStorage` da v1 automaticamente: os dados da demonstração ficam no navegador original. O banco novo começa com 6 presentes de exemplo.
- `PIX_KEY` deve pertencer ao destinatário correto e ser validada antes de publicar. Nunca inclua segredos no JavaScript.
