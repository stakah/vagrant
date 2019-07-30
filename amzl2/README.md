# README

## Para criar as máquinas

```
vagrant up
```

### Serão criadas três máquinas

- amzolx2-mysqldb: Servidor MySQL
  - IP: 192.168.33.101
- amzolx2-backend: Servidor de backend com Python3, Nginx e Uwsgi
  - IP: 192.168.33.102
- amzolx2-frontend: Servidor de frontend com Node.js, Ionic 5 e Angular 8
  - IP: 192.168.33.103

## Para usar as maquinas

Na pasta raíz onde está o arquivo `Vagrantfile` criar uma pasta com o conteúdo do
repositório com os códigos do backend e frontend.

Para se conectar, utilizar:

```
ssh vagrant@IP-DA-MAQUINA

exemplo:

ssh vagrant@192.168.33.101

ou,

vagrant ssh nome-da-maquina

exemplo:

vagrant ssh amzolx2-frontend
```

A senha do usuário `vagrant` é `vagrant`.

> Obs.:
> Para instalar as dependências do projeto Ionic com uma maquina hospedeira Windows,
> utilizar `yarn` de dentro da maquina `amzolx2-frontend`
> 
> ```
> npm rebuild node-sass
> npm install -g yarn
> cd /vagrant/dir/to/ionic/frontend/project
> rm -rf node_modules
> yarn install --no-bin-links
> ```
> 
