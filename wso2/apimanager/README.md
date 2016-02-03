# WSO2 API Manager v1.10.0 Vagrant Box #

# Requisitos #
* Vagrant 1.8+ (https://www.vagrantup.com/)
* VirtualBox 5.0+ (https://www.virtualbox.org/wiki/Downloads)
* WSO2 API Manager v1.10.0 zip (http://wso2.com/api-management/try-it/)

# Instalando #
Baixe os arquivos dessa pasta numa pasta temporária.

Faça o download do arquivo compactado do WSO2 API Manager e copie-o nesta pasta.

# Executando #
Pelo terminal:

    cd vagrant/apimanager
    vagrant up

# Acessando #
Pelo browser acesse:

|                URL              |      Descrição      |
|---------------------------------|---------------------|
| http://localhost:9444/carbon    | API Manager Console |
| http://localhost:9444/publisher | API Publisher       |
| http://localhost:9444/store     | API Store           |

* Login: admin
* Password: admin
