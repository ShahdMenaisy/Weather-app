Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true 
  config.hostmanager.manage_host = true
  
### First vm  ####
  config.vm.define "m01" do |m01|
    m01.vm.box = "eurolinux-vagrant/centos-stream-9"
    m01.vm.box_version = "9.0.43"
    m01.vm.hostname = "m01"
    m01.vm.network "private_network", ip: "192.168.56.15"
    m01.vm.provider "virtualbox" do |vb|
     vb.memory = "512"
     vb.cpus = 1	
   end

  end
  
### Second vm  #### 
  config.vm.define "m02" do |m02|
    m02.vm.box = "eurolinux-vagrant/centos-stream-9"
    m02.vm.box_version = "9.0.43"
    m02.vm.hostname = "m02"
    m02.vm.network "private_network", ip: "192.168.56.14"
    m02.vm.provider "virtualbox" do |vb|
     vb.memory = "512"
     vb.cpus = 1
   end
  end
  
  
end
