disks = [1024, 2048, 1024, 2048]
load File.expand_path('.vagrant/tmp/remote_vagrantfile')

Vagrant.configure(2) do |config|
  config.vm.provider :virtualbox do |vb|
    disks.each_with_index do | disk_size, index |
      disk_file = ".virtual_disks/virtual_disk#{index}.vdi"
      vb.customize ["createhd",  "--filename", disk_file, "--size", disk_size]
      vb.customize ["storageattach", :id, "--storagectl", "prometheus-storage-0", "--port", index + 1, "--type", "hdd", "--medium", disk_file]
    end
  end
  config.vm.synced_folder ".", "/t_functional", type: "rsync"
end
