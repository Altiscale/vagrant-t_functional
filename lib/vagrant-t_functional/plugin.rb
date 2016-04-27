require 'aws-sdk'

begin
  require 'vagrant'
rescue LoadError
  raise 'The vagrant-host-shell plugin must be run within Vagrant.'
end

module VagrantPlugins
  class Plugin < Vagrant.plugin('2')
    name 't_functional'

    command("runtests") do
      Command
    end
  end

  class Command < Vagrant.plugin(2,:command)
    def execute

      options = {}
      options[:force] = false

      opts = OptionParser.new do |o|
        o.banner = "Usage: vagrant runtests [vm-name] --prometheus prometheus-image-id"
        o.separator ""

        o.on("-p", "--prometheus IMAGE", String, "Remote Vagrantfile") do |p|
          options[:prometheus] = p
        end
      end

      # Parse the options
      argv = parse_options(opts)
      return 1 if !argv

      raise "MISSING: Prometheus id" unless options[:prometheus]

      download_from_s3(options[:prometheus])

      with_target_vms(argv, :reverse => true) do |vm|
        vm.action(:up)
      end

      with_target_vms(nil, single_target: true) do |vm|
        vm.action(:ssh_run, ssh_run_command: 'echo "llllllllll"; rm -rf *; git clone -b alti_rpmtest https://github.com/Altiscale/sig-core-t_functional.git; sudo sig-core-t_functional/runtests.sh')
      end

      return 0
    end

    private

    def download_from_s3(prometheus)
      prometheus_local_path = '.vagrant/tmp/remote_vagrantfile'
      prometheus_local_dir = File.dirname(prometheus_local_path)
      Dir.mkdir(prometheus_local_dir) unless Dir.exists?(prometheus_local_dir)
      s3 = ::Aws::S3::Client.new(region: ENV['AWS_REGION'] || 'us-west-1')
      s3.get_object({ bucket:'vcc-hostdb', key: "Vagrantfile.#{prometheus}" }, target: prometheus_local_path) unless File.exists?(prometheus_local_path)
    end
  end
end
