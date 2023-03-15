#Vagrantfile

Vagrant.configure("2") do |config|
    servers=[
        {
            :hostname => "Node01",
            :box => "bento/ubuntu-18.04", 
            :ip => "172.16.1.51",
            :ssh_port => '2201'
        }
        
    ]

    servers.each do |machine|
        config.vm.define machine[:hostname] do |node|
            node.vm.box = machine[:box]
            node.vm.hostname = machine[:hostname]
            node.vm.network :private_network, ip: machine[:ip]
            node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
            node.vm.network "forwarded_port", guest: 5901, host: 5901, id: "vnc"
            node.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", 2048]
                vb.customize ["modifyvm", :id, "--cpus", 1]
            end
        end
        
        if machine[:hostname] == 'Node01' then
            # copie des fichiers necessaires à l'initialisation
            config.vm.provision "file", source: "./xstartup.sh", destination: "~/.vnc/xstartup"
            config.vm.provision "file", source: "daemon", destination: "~/vncserver@.service"
            config.vm.provision "file", source: "init-script.sh", destination: "~/init-script.sh"
            #on lance le script sans être root 
            # privileged: false
            config.vm.provision :shell, :inline => "sh /home/vagrant/init-script.sh", privileged: false
            #config.vm.provision "shell", inline: => "sh /home/vagrant/init-script.sh"
        end
        

    end

end
