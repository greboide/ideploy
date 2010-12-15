# language: pt
Funcionalidade: deploy no server
  Para que eu consiga fazer um deploy fácil
  Como desenvolvedor
  Vou criar tarefas no Thor para deployment
  Cenário: Fazendo deploy
    Dado que eu terminei de codar uma feature
    E o projeto está configurado para deploy
    Quando eu atualizar o repo localmente
    E atualizar o repositório no servidor
    E re-atualizar o servidor web
    Então eu devo ter meu deployment realizado
  @wip
  Cenário: Configurando o deploy
    Dado que eu iniciei um novo projeto
    Quando preencho o "server, user e path" em config/deploy.yml
    E tenho acesso via chaves ssh ao servidor web
    Então eu devo ter o projeto configurado








