# Conecta Serviços — PWA

Aplicativo web instalável (PWA) para clientes, profissionais e administrador.

## Publicar no GitHub Pages
1. Crie um repositório no GitHub.
2. Envie **todos os arquivos e pastas** deste projeto mantendo a estrutura.
3. Vá em **Settings → Pages**.
4. Em **Build and deployment**, selecione **Deploy from a branch**.
5. Escolha a branch `main` e a pasta `/ (root)` e salve.
6. Abra a URL HTTPS fornecida pelo GitHub Pages.

## Instalação
- Android/Chrome: quando o navegador liberar a instalação, o botão **Instalar aplicativo** aparece na tela de login; também pode aparecer o comando de instalação no menu do navegador.
- iPhone/iPad: abra a URL no Safari → **Compartilhar** → **Adicionar à Tela de Início**.

## Acesso inicial do administrador
- E-mail: `jefersoncarvalho252@gmail.com`
- Senha: `ben2018`
- A senha de autorização para editar/excluir clientes: `26`

## Importante
Esta versão é uma PWA front-end e usa `localStorage` no aparelho/navegador. Os dados não ficam sincronizados entre celulares. Para uso comercial real, substitua a autenticação e o armazenamento local por um backend/banco de dados seguro (por exemplo, Supabase/Firebase) e não mantenha senhas administrativas diretamente no código do navegador.
