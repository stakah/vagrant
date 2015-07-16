** WSO2 Identity Server 5.0.0 **
# README.md
Provisions a VirtualBox VM with WSO2 Identity Server using Vagrant.

> Requires `VirtualBox 4.3` and `Vagrant 1.7.3`
>
> Download sites<br>
> [VirtualBox](https://www.virtualbox.org/wiki/Downloads)<br>
> [Vagrant](http://www.vagrantup.com/downloads.html)

## Provisioning scripts
`provision-jdk.sh` Provisions Java Development Kit.

Current version is `1.7.0u79b15`. First time it is run the script `wget`'s the jdk from Oracle. Afterwards, it just copies the donwloaded file into the VM.

`provision-wso2is.sh` Provisions WSO2 Identity Server.

Current version is `5.0.0`. For this script to work it's necessary to previously download the WSO2 Identity Server zip file from [wso2.com][wso2].

Start up the VM using:

    vagrant up

After the VM is started and the provisioning scripts are finnished, access the VM console using:

    vagrant ssh

Start WSO2 Identity Server in cosole mode by executing `startup.sh`.

    sh startup.sh

Or, start as background process:

    cd /opt/wso2is/bin
    sh wso2server.sh start

Stop the WSO2 Identity Server by typing `Ctrl`+`C` in the executing console.

Or, stop the background process:

    cd /opt/wso2is/bin
    sh wso2server.sh stop

Halt the VM using:

    vagrant halt

Or, just put the VM to sleep by using:

    vagrant suspend

And resume a suspended VM by using:

    vagrant resume

To remove the VM, use:

    vagrant destroy

Next time you `vagrant up`, a new VM will be created and provisioned.


## Install patches
It's highly recommended to install the patches available at [wso2.com][wso2].

<div style="align:center;">
<table style="width:95%;">
  <tbody>
    <tr>
      <td>patch1095</td>
      <td>patch1235</td>
      <td>patch1262</td>
    </tr>
    <tr>
      <td>patch1193</td>
      <td>patch1256</td>
      <td>patch1268</td>
    </tr>
    <tr>
      <td>patch1194</td>
      <td>patch1261</td>
      <td>patch1270</td>
    </tr>
  </tbody>
</table>
</div>

### Patched zip file
After installing the patches you can create a patched zip file to be used instead of the one with no patches.

To create the zip file, install `zip` tool in the VM

    vagrant ssh
    sudo apt-get install zip

Create the patched zip file:

    zip -r wso2is-5.0.0-patched.zip /opt/wso2is-5.0.0/

Copy the new file into Host folder containing the `Vagrant` file:

    cp wso2is-5.0.0-patched.zip /vagrant

Edit `provison-wso2is.sh` to replace `wso2is-5.0.0.zip` with `wso2is-5.0.0-patched.zip`.

Replace

    iszip=$isversion.zip

with

    iszip=$isversion-patched.zip

Next time you create a new VM using `vagrant up` it'll already be patched.

[wso2]: http://wso2.com
