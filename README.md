# Moip Exemplo de integração

Exemplo de integração do Moip usando o [Checkout Transparente](http://labs.moip.com.br/transparente/) utilizando a gem [MyMoip](https://github.com/Irio/mymoip).

## Instalação

Copiar o arquivo `config/keys.yml.example` para `config/keys.yml`.

Editar o arquivo e informar o `token` e `key` obtidos no [Moip](https://desenvolvedor.moip.com.br/sandbox/MainMenu.do?method=home).

Instalar as dependencias
```
$ bundle install
```

Rodar o servidor

```
$ shotgun
== Shotgun/WEBrick on http://127.0.0.1:9393/
[2012-07-01 22:06:16] INFO  WEBrick 1.3.1
[2012-07-01 22:06:16] INFO  ruby 1.9.3 (2012-02-16) [x86_64-darwin10.8.0]
[2012-07-01 22:06:16] INFO  WEBrick::HTTPServer#start: pid=49873 port=9393
```

## Instalação e deploy no heroku

```
$ heroku apps:create my_app_on_heroky
$ git push heroku master
$ heroku config:add TOKEN=XXX KEY=XXX
```

## Licence
MIT License. Copyright 2012 Zigotto®. http://www.zigotto.com