# Roberto & Vitória — site de casamento v2

Site premium com **React/Vite**, API **Java 21 + Spring Boot 3**, **PostgreSQL 16**, migrações **Flyway**, PIX direto e integração preparada para **cartão de crédito via Mercado Pago Checkout Bricks**.

## Tecnologias

- Frontend: React 18, Vite, CSS próprio, Mercado Pago JS SDK carregado sob demanda.
- Backend: Java 21, Spring Boot 3.4, JDBC, Spring Security, Flyway.
- Banco: PostgreSQL.
- Deploy atual: Render Web Service para API, Render Static Site para frontend e Render PostgreSQL.

## O que funciona

- RSVP persistido no PostgreSQL.
- Lista de presentes editável no painel.
- PIX direto com QR Code, chave, favorecido e banco.
- Cartão de crédito via Mercado Pago Bricks, sem armazenar número do cartão ou CVV.
- Webhook Mercado Pago com validação HMAC quando `MP_WEBHOOK_SECRET` estiver configurado.
- Histórico administrativo de pagamentos por cartão.
- Mural de mensagens com aprovação antes de publicação.
- Administração protegida por HTTP Basic no servidor.

## Variáveis de ambiente

Backend:

```env
DATABASE_URL=jdbc:postgresql://host:5432/database
DATABASE_USER=usuario
DATABASE_PASSWORD=senha
ADMIN_USER=admin
ADMIN_PASSWORD=senha-forte
PIX_KEY=61999630736
PIX_NAME=Roberto Fernandes
PIX_BANK=Nubank
MP_PUBLIC_KEY=TEST-ou-APP_USR-public-key
MP_ACCESS_TOKEN=TEST-ou-APP_USR-access-token
MP_WEBHOOK_SECRET=secret-gerado-no-painel-mercado-pago
PORT=8080
```

Não coloque `MP_ACCESS_TOKEN`, `MP_WEBHOOK_SECRET`, senha do banco ou senha admin no frontend nem no Git.

## Instalação local

Pré-requisitos: Java 21, Maven 3.9+, Node 20+, Docker + Docker Compose.

1. Configure `.env` local e suba o PostgreSQL com `docker compose --env-file .env up -d`.
2. Em `backend`, configure as variáveis acima e execute `mvn spring-boot:run`.
3. Em `frontend`, execute `npm install` e `npm run dev`.
4. Acesse a URL informada pelo Vite. O proxy `/api` encaminha para `localhost:8080`.

## Mercado Pago — configuração

1. Acesse o painel de desenvolvedores Mercado Pago e crie/abra sua aplicação.
2. Use credenciais de **teste** primeiro:
   - `MP_PUBLIC_KEY`: chave pública de teste.
   - `MP_ACCESS_TOKEN`: access token de teste.
3. Configure o webhook no painel Mercado Pago para:

```txt
https://SEU_BACKEND_RENDER.onrender.com/api/webhooks/mercadopago
```

4. Ative eventos de pagamento, especialmente `payment`.
5. Copie a assinatura secreta gerada em Webhooks e configure em `MP_WEBHOOK_SECRET`.
6. Teste com cartões e usuários oficiais de teste do Mercado Pago.
7. Só depois substitua por credenciais de produção.

## Recebimento imediato

A aprovação do pagamento não significa disponibilidade imediata do saldo. Prazos de recebimento, antecipação, taxas e modalidade “receber na hora” dependem das condições habilitadas na sua conta Mercado Pago Pessoa Física. Não há taxa fixa codificada no projeto.

Verifique no painel Mercado Pago, normalmente em áreas como **Seu dinheiro**, **Custos**, **Configurações de recebimento**, **Tarifas e prazos** ou equivalente da conta. Se o painel oferecer opção de recebimento mais rápido/na hora, ative por lá. A API deste projeto respeita o que a conta Mercado Pago disponibilizar.

## Fluxo cartão

1. Convidado escolhe presente.
2. Seleciona “Cartão de crédito”.
3. Mercado Pago Bricks coleta e tokeniza os dados sensíveis.
4. Frontend envia token e dados não sensíveis ao backend.
5. Backend busca o preço oficial do presente no banco e cria o pagamento no Mercado Pago com `X-Idempotency-Key`.
6. Backend registra o pagamento como `creating`/status retornado.
7. Webhook consulta o status oficial no Mercado Pago.
8. Se aprovado, a intenção de presente relacionada é marcada como `confirmed`.

O frontend nunca deve ser fonte de verdade para preço ou aprovação.

## Testes obrigatórios antes de produção

- `mvn test` no backend.
- `npm run build` no frontend.
- Testar Pix existente.
- Testar cartão aprovado em sandbox.
- Testar cartão recusado em sandbox.
- Testar parcelamento exibido pelo Brick.
- Testar webhook e reenvio de notificação.
- Confirmar que `MP_ACCESS_TOKEN` não aparece no bundle frontend.
- Entrar no painel e verificar a tabela “Pagamentos Mercado Pago”.

## Deploy no Render

Backend:

- Web Service Docker usando o `Dockerfile` da raiz.
- Variáveis de ambiente configuradas no painel Render.
- URL pública usada no webhook Mercado Pago.

Frontend:

- Static Site com root `frontend`.
- Build command: `npm install && npm run build`.
- Publish directory: `dist`.
- Rewrite `/api/*` para o backend Render.

Após configurar variáveis Mercado Pago no Render, faça novo deploy do backend e frontend.

## Segurança

- Não armazenar número completo de cartão, validade ou CVV.
- Não confiar em status vindo do cliente.
- Validar webhook com `MP_WEBHOOK_SECRET`.
- Usar HTTPS.
- Usar senha admin forte.
- Não fazer cobranças reais em teste.
- Não versionar `.env`.

## Limitações conhecidas

- O painel mostra histórico de pagamentos, mas filtros avançados são básicos.
- O status definitivo depende do webhook e da consulta oficial ao Mercado Pago.
- O fluxo foi preparado para sandbox/produção, mas precisa de credenciais reais/teste configuradas no Render antes de testes funcionais com cartão.
