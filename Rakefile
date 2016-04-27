require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# Disable the push to rubygems.org
Rake::Task[:release].clear

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = [
    'Rakefile',
    'lib/**/*.rb',
    'spec/**/*.rb',
    '*.gemspec',
    'bin/*']
end

task default: [:spec, :rubocop]

task :publish do
  require_relative 'lib/vagrant-t_functional/version'
  sh "gem inabox pkg/vagrant-t_functional-#{VagrantPlugins::T_functional::VERSION}.gem "\
  '-g https://gems.service.verticloud.com'
end

task :clean do
  FileUtils.rm_f('pkg/vagrant-t_functional-*.gem')
end

task all: [:default, :build]
