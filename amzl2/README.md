# README

## Instalação

Primeiramente, deve-se ter instalados na máquina hospedeira:

1. VirtualBox (https://www.virtualbox.org/wiki/Downloads)
1. Vagrant (https://www.vagrantup.com/downloads.html)
1. Cmder (**somente para windows**) (https://cmder.net/)
> **Obs.:**
> 
> ### Para máquinas Windows
> * Escolher a versão 64-bits do Vagrant.
> * Após a instalação, será necessário reiniciar a máquina.
> 
> Também instale o emulador de terminal **Cmder** (https://cmder.net/)
> para poder executar os scripts `*.sh` no Windows.
>
> Os drives `C:`, `D:` etc. são mapeados nas pastas `/c`, `/d` etc.,
> respectivamente.

## Repositório

Os arquivos para subir as máquinas virtuais estão no GitHub
no endereço: https://github.com/stakah/vagrant/archive/master.zip

Após baixar e descompactar o arquivo ZIP, por exemplo, na pasta
`C:\work`, faça um `cd` para entrar na pasta `vagrant\amzl2`

```shell
C:\work>cd vagrant\amzl2
```

> **Para Linux/Mac OS X**
> Por exemplo, descompacte o arquivo na sua pasta home `~/work` e 
> faça um `cd` para entrar na pasta `vagrant/amzl2`
> ```shell
> ~/work>cd vagrant/amzl2
> ```

## Para criar o ambiente em uma única VM
Pelo terminal, na pasta `work/vagrant/amzl2` faça:
```
...work/vagrant/amzl2>vagrant up
```
Será criada uma VM identificada por `amzolx2` com o endereço IP
`192.168.33.101`.

### Para criar o ambiente em três VMs separadas

Pelo terminal, na pasta `work/vagrant/amzl2` faça:
```shell
...work/vagrant/amzl2>vagrant up Vagrantfile.3vm
```

Serão criadas três VMs, a saber:

- amzolx2-mysqldb: Servidor MySQL
  - IP: 192.168.33.101
- amzolx2-backend: Servidor de backend com Python3, Nginx e Uwsgi
  - IP: 192.168.33.102
- amzolx2-frontend: Servidor de frontend com Node.js, Ionic 5 e Angular 8
  - IP: 192.168.33.103

## Para usar as maquinas

Na pasta raíz onde está o arquivo `Vagrantfile` criar uma pasta com o conteúdo do
repositório com os códigos do backend e frontend.

```shell
...work/vagrant/amzl2> mkdir myproj
...work/vagrant/amzl2> cd myproj
```

## Para se conectar

Utilizar:

```
/> ssh vagrant@192.168.33.101

ou,

...work/vagrant/amzl2>vagrant ssh amzolx2
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
