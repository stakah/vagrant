vagrant-lamp
============

Readable, Transparent Shell-Provisioning for a LAMP-Environment with MariaDB

# What is it?

vavgrant-lamp provides a Shell Provisioner [for Vagrant](http://www.vagrantup.com/) which will leave you
with a working Ubuntu-LAMP-Environment with MariaDB 5.5.

## Installed Components
* apache2
* joe
* pwgen
* git
* php5
* mariadb
* composer

# How to use it

Install vagrant-lamp as a git-submodule in your project, like so:

    git submodule add git://github.com/Lukx/vagrant-lamp.git vagrant

vagrant-lamp will try to detect the correct folder for your DocumentRoot,
which works especially fine if you name it, relative to your project root,
one of `web`, `public`, `htdocs`. The Project Root itself will be used, 
if none of the other dirs were found. I believe, the auto-detection can be
improved, and I am looking forward to seeing your ideas.

Thus, your Folder Structure should now look something like this, if `web` was your
public document root.

    |-Project Rooot
    |   |-.gitmodules
    |   |-.git/
    |   |-web/
    |   |   |-index.php
    |   |
    |   |-vagrant/  -> *(files from this project)*

Then, within the newly created vagrant folder, use `vagrant up` to get your machine started.

When everything went right, you'll have
* a running Apache2 Server on http://10.10.47.11/ with PHP Support
* a MariaDB database `vagrant` with user `vagrant` and password `vagrant`

## Don't forget...

* ... to clear your application framework cache, especially if there are any errors
that might have to do with paths, environments, etc.
* ... to setup your database configuration
* ... to provide your feedback if you have!

# Credit
I started off with edlingeer's excellent [answer on StackOverflow](http://stackoverflow.com/a/18032942/841636) and
adapted it to my needs, a more modular setup and using MariaDB; plus some minor setup.