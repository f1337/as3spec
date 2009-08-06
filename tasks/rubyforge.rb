# require Jeweler
begin
  require 'rake/contrib/sshpublisher'
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end

# publish gem to rubyforge
namespace :rubyforge do

  desc "Release gem and RDoc documentation to RubyForge"
# task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]
  task :release => ["rubyforge:release:gem"]

  namespace :release do
    desc 'Publish sprout-as4spec-library.zip to RubyForge'
    task :sprout do
      config = YAML.load(
          File.read(File.expand_path('~/.rubyforge/user-config.yml'))
      )
  
      host = "#{config['username']}@rubyforge.org"
      remote_dir = "/var/www/gforge-projects/as3spec/"
      local_dir = 'pkg'
			files = "#{Rake.application.jeweler.gemspec.name}-#{Rake.application.jeweler.version}.zip"
	
      Rake::SshFilePublisher.new(host, remote_dir, local_dir, files).upload
    end

    # desc "Publish RDoc to RubyForge."
    # task :docs => [:rdoc] do
    #   config = YAML.load(
    #       File.read(File.expand_path('~/.rubyforge/user-config.yml'))
    #   )
    #   
    #   host = "#{config['username']}@rubyforge.org"
    #   remote_dir = "/var/www/gforge-projects/the-perfect-gem/"
    #   local_dir = 'rdoc'
    #   
    #   Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
    # end
  end
end
