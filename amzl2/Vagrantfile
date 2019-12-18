VAGRANTFILE_API_VERSION = "2"

VM_BASE_NAME = "amzolx2"
BASE_LOCAL_IP = "192.168.33"
MYSQLDB_NODE_IP = "#{BASE_LOCAL_IP}.101"
BACKEND_NODE_IP = "#{BASE_LOCAL_IP}.102"
FRONTEND_NODE_IP = "#{BASE_LOCAL_IP}.103"

machines = [
  {
    "vm_name" => "#{VM_BASE_NAME}", "memory" => 2048, "cpus" => 1, "hostname" => "#{VM_BASE_NAME}",
    "ip_address" => "#{BASE_LOCAL_IP}.101",
    "forwarded_ports" => [
      {"guest" => 3306, "host" => 3306},
      {"guest"=> 8000, "host" => 8000},
      # {"guest"=> 8100, "host" => 8100},
      # {"guest"=> 3000, "host" => 3000},
      # {"guest"=> 3001, "host" => 3001}
    ],
    "provisions" => [
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set mysql-server", "path" => "provisioning/setup-mysql.sh", "privileged" => true},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set mysql-root", "path" => "provisioning/set-mysql-root.sh", "privileged" => true},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "create mysql-db", "path" => "amzl2/create-mysql-db.sh", "privileged" => true},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "create mysql-user", "path" => "amzl2/create-mysql-user.sh", "privileged" => true},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set git", "path" => "provisioning/setup-git.sh", "privileged" => true},

      # {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set mysql-client", "path" => "provisioning/setup-mysql-client.sh", "privileged" => true},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set python3 and virtualenv", "path" => "provisioning/setup-python3.sh", "privileged" => false},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set nginx", "path" => "provisioning/setup-nginx.sh", "privileged" => true},
      # {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set git", "path" => "provisioning/setup-git.sh", "privileged" => true},
      {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set uwsgi", "path" => "provisioning/setup-uwsgi.sh", "privileged" => false},

      # {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set git", "path" => "provisioning/setup-git.sh", "privileged" => true},
      # {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set nodejs", "path" => "provisioning/setup-nodejs.sh", "privileged" => false},
      # {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set ionic", "path" => "provisioning/setup-ionic.sh", "privileged" => true},
      # {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set angular", "path" => "provisioning/setup-angular.sh", "privileged" => false},
    ]
  },
  # {
  #   "vm_name" => "#{VM_BASE_NAME}-backend", "memory" => 1024, "cpus" => 1, "hostname" => "#{VM_BASE_NAME}-backend",
  #   "ip_address" => "#{BASE_LOCAL_IP}.102",
  #   "forwarded_ports" => [
  #     {"guest"=> 8000, "host" => 8000}
  #   ],
  #   "provisions" => [
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set mysql-client", "path" => "provisioning/setup-mysql-client.sh", "privileged" => true},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set python3 and virtualenv", "path" => "provisioning/setup-python3.sh", "privileged" => false},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set nginx", "path" => "provisioning/setup-nginx.sh", "privileged" => true},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set git", "path" => "provisioning/setup-git.sh", "privileged" => true},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set uwsgi", "path" => "provisioning/setup-uwsgi.sh", "privileged" => false},
  #   ]
  # },
  # {
  #   "vm_name" => "#{VM_BASE_NAME}-frontend", "memory" => 1024, "cpus" => 1, "hostname" => "#{VM_BASE_NAME}-frontend",
  #   "ip_address" =>  "#{BASE_LOCAL_IP}.103",
  #   "forwarded_ports" => [
  #     {"guest"=> 8100, "host" => 8100},
  #     {"guest"=> 3000, "host" => 3000},
  #     {"guest"=> 3001, "host" => 3001}
  #   ],
  #   "provisions" => [
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set git", "path" => "provisioning/setup-git.sh", "privileged" => true},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set nodejs", "path" => "provisioning/setup-nodejs.sh", "privileged" => false},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set ionic", "path" => "provisioning/setup-ionic.sh", "privileged" => true},
  #     {"type" => "shell", "keep_color" => true, "run" => "once", "name" => "set angular", "path" => "provisioning/setup-angular.sh", "privileged" => false},
  #   ]
  # }
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/amazonlinux-2"
  config.vm.box_version = "1.1.0"
  
  config.vm.provision "shell", run: "once", name: "set motd", path: "provisioning/set_motd.sh"
  config.vm.provision "shell", run: "once", name: "set amazon-linux-extras", path: "provisioning/setup-amazon-linux-extras.sh"

  machines.each { |machine|
    if ARGV[0] == "up" then
      print("Creating machine '#{machine["vm_name"]}' ...\n")
    end

    config.vm.define vm_name = machine["vm_name"] do |vmaquina|               
      vmaquina.vm.network "private_network", ip: machine["ip_address"]
      machine["forwarded_ports"].each {|port|
        vmaquina.vm.network "forwarded_port", guest: port["guest"], host: port["host"]
      }

      vmaquina.vm.hostname = machine["hostname"]
      vmaquina.vm.network "public_network"

      vmaquina.vm.provider "virtualbox" do |vb|
        vb.name = machine["vm_name"]
        vb.gui = false
        vb.memory = machine["memory"]
        vb.cpus = machine["cpus"]
      end

      machine["provisions"].each do |provision|
        vmaquina.vm.provision provision["type"], run: provision["run"], name: provision["name"], keep_color: machine["keep_color"], path: provision["path"], privileged: provision["privileged"]
      end
    end
  }
  
end
