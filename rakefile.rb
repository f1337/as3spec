require 'sprout'

# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'as3'

require 'tasks/flashplayer_redgreen_task'

############################################
# Configure your Project Model
model = project_model :model do |m|
  m.project_name            = 'as3spec'
  m.language                = 'as3'
  m.background_color        = '#FFFFFF'
  m.width                   = 970
  m.height                  = 550
  m.test_output							= "#{m.bin_dir}/as3specRunner.swf"
  # m.use_fdb               = true
  # m.use_fcsh              = true
  # m.preprocessor          = 'cpp -D__DEBUG=false -P - - | tail -c +3'
  # m.preprocessed_path     = '.preprocessed'
  # m.src_dir               = 'src'
  # m.lib_dir               = 'lib'
  # m.swc_dir               = 'lib'
  # m.bin_dir               = 'bin'
  # m.test_dir              = 'test'
  # m.doc_dir               = 'doc'
  # m.asset_dir             = 'assets'
  # m.compiler_gem_name     = 'sprout-flex4sdk-tool'
  # m.compiler_gem_version  = '>= 4.0.0'
  # m.source_path           << "#{m.lib_dir}/as3spec"
  # m.libraries             << :corelib
end

desc 'Compile and debug the application'
debug :debug

desc 'Compile run the test harness'
flashplayer :test => model.test_output
mxmlc model.test_output => :model do |t|
	t.debug				 = true
	t.input				 = "#{model.src_dir}/as3specRunner.mxml"
	t.source_path << model.test_dir
end

desc 'Compile the optimized deployment'
deploy :deploy

desc 'Create documentation'
document :doc

desc 'Compile a SWC file'
swc :swc

# set up the default rake task
task :default => :debug


# build gem
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sprout-as3spec-library"
    gem.summary = %Q{AS3Spec is a tiny BDD framework for AS3, inspired by Bacon and RSpec. Built upon sprout project-generation tool for ActionScript/Flash/Flex/AIR.}
    gem.description = %Q{AS3Spec is a tiny BDD framework for AS3, inspired by Bacon and RSpec. Built upon sprout project-generation tool for ActionScript/Flash/Flex/AIR.}
    gem.email = "disinnovate@gmail.com"
    gem.homepage = "http://github.com/disinnovate/as3spec"
    gem.authors = [ "Michael Fleet" ]
		gem.executables = []
		gem.files = FileList['sprout.spec']
		gem.extra_rdoc_files = []
		gem.require_path = '.'
#		gem.add_dependency('sprout', '>= 0.7.206')
		gem.rubyforge_project = 'as3spec'
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

# publish gem to rubyforge
begin
  require 'rake/contrib/sshpublisher'
  namespace :rubyforge do

    desc "Release gem and RDoc documentation to RubyForge"
#    task :release => ["rubyforge:release:gem", "rubyforge:release:docs"]
    task :release => ["rubyforge:release:gem"]

    namespace :release do
      desc "Publish RDoc to RubyForge."
      task :docs => [:rdoc] do
        config = YAML.load(
            File.read(File.expand_path('~/.rubyforge/user-config.yml'))
        )

        host = "#{config['username']}@rubyforge.org"
        remote_dir = "/var/www/gforge-projects/the-perfect-gem/"
        local_dir = 'rdoc'

        Rake::SshDirPublisher.new(host, remote_dir, local_dir).upload
      end
    end
  end
rescue LoadError
  puts "Rake SshDirPublisher is unavailable or your rubyforge environment is not configured."
end