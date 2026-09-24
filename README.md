# Conecta Serviços

Projeto HTML/CSS/JavaScript com Supabase para publicar no GitHub Pages.

## O que já está incluído

- Página inicial com visual escuro e dourado.
- Cadastro e login com Supabase Auth.
- Perfis de Cliente, Profissional e Administrador.
- Cadastro de profissional com taxa de R$ 4,99.
- Botão automático para conversar com o ADM no WhatsApp.
- Fluxo de pagamento manual: profissional paga ao ADM, envia comprovante e aguarda confirmação.
- Painel administrativo para ativar o profissional por 30 dias.
- Cadastro de serviços e cidade.
- Clientes podem solicitar orçamento.
- Profissionais podem aceitar ou recusar solicitações.
- Link direto para WhatsApp.

## 1. Criar o projeto no Supabase

1. Entre em https://supabase.com
2. Crie um projeto.
3. Abra SQL Editor.
4. Cole e execute todo o conteúdo do arquivo `supabase-schema.sql`.
5. Vá em Project Settings > API e copie:
   - Project URL
   - anon public key

## 2. Configurar o HTML

Abra `index.html` e altere:

```js
const SUPABASE_URL = "COLE_AQUI_SUA_URL_SUPABASE";
const SUPABASE_ANON_KEY = "COLE_AQUI_SUA_CHAVE_ANON";
```

O número do ADM já está configurado no código:
`79999055301`

Se quiser alterar, mude a constante `ADMIN_WHATSAPP`.

## 3. Criar o primeiro administrador

1. Crie um usuário em Authentication > Users.
2. Faça login uma vez para gerar o perfil.
3. No SQL Editor execute:

```sql
update public.profiles
set role = 'admin'
where email = 'SEU_EMAIL_ADMIN@EMAIL.COM';
```

Saia e entre novamente.

## 4. Publicar no GitHub Pages

1. Crie um repositório no GitHub.
2. Envie `index.html` e `supabase-schema.sql`.
3. Vá em Settings > Pages.
4. Em Build and deployment, selecione:
   - Source: Deploy from a branch
   - Branch: main
   - Folder: /root
5. Salve e aguarde o endereço do site.

## Como funciona o pagamento do profissional

1. O profissional cria a conta.
2. O cadastro fica com status `pending`.
3. O sistema abre o WhatsApp do ADM com uma mensagem pronta.
4. O profissional paga R$ 4,99 diretamente ao ADM via Pix.
5. O profissional envia o comprovante pelo WhatsApp.
6. O ADM confere o pagamento.
7. No painel administrativo, o ADM clica em "Confirmar pagamento e liberar 30 dias".
8. O sistema grava a data de vencimento em `subscription_until`.

## Observações importantes

- O HTML pode ser hospedado no GitHub Pages, mas os dados e autenticação ficam no Supabase.
- Não coloque a `service_role key` no HTML. Use somente a chave `anon public`.
- Para produção, configure também confirmação de e-mail, recuperação de senha, políticas de privacidade e termos de uso.
- O fluxo Pix deste projeto é manual, conforme solicitado. O sistema não confirma Pix automaticamente.
