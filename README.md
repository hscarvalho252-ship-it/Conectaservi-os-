# Conecta Serviços — PWA com sincronização online

Esta versão mantém o PWA instalável e adiciona sincronização entre celulares usando Supabase.

## 1. Criar o banco online
1. Crie um projeto no Supabase.
2. Abra **SQL Editor**.
3. Execute o arquivo `supabase.sql` deste projeto.
4. Em **Project Settings → API**, copie a **Project URL** e a chave **anon/public**.
5. Abra `config.js` e coloque os dois valores:
   - `window.SUPABASE_URL = 'https://SEU-PROJETO.supabase.co';`
   - `window.SUPABASE_ANON_KEY = 'SUA_CHAVE_ANON';`
6. Não use a chave `service_role` no site.

## 2. Publicar no GitHub Pages
Envie todos os arquivos para o repositório, incluindo `config.js` e `supabase.sql`.
Ative GitHub Pages em **Settings → Pages → Deploy from a branch → main → / (root)**.

## 3. Como fica o fluxo
- Profissional se cadastra no celular → dados são gravados no Supabase.
- ADM abre o painel em outro celular → os dados vêm do mesmo banco online.
- O botão de WhatsApp usa **55 79 99990-55301**.
- O aplicativo continua instalável como PWA.

## 4. Credenciais iniciais da demonstração
- ADM: `jefersoncarvalho252@gmail.com`
- Senha: `ben2018`
- Senha de autorização de cliente: `26`

## Importante sobre segurança
A sincronização desta primeira versão usa uma linha JSON compartilhada e políticas públicas para permitir o funcionamento simples no GitHub Pages. Para colocar o aplicativo em produção com dados reais, a próxima etapa recomendada é migrar login e permissões para **Supabase Auth + RLS por usuário**, sem senhas administrativas no JavaScript.
