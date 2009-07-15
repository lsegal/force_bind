require 'rubygems'
require 'rake/gempackagetask'

load 'bind_class.gemspec'
Rake::GemPackageTask.new(SPEC) do |pkg|
  pkg.gem_spec = SPEC
  pkg.need_zip = true
  pkg.need_tar = true
end

desc "Install the gem locally"
task :install => :package do 
  sh "#{SUDO} gem install pkg/#{SPEC.name}-#{SPEC.version}.gem --local"
  sh "rm -rf pkg/yard-#{SPEC.version}" unless ENV['KEEP_FILES']
end
