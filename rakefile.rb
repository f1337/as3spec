require 'rake/packagetask'
require 'sprout'

# Optionally load gems from a server other than rubyforge:
# set_sources 'http://gems.projectsprouts.org'
sprout 'as3'

require 'tasks/flashplayer_redgreen_task'
#require 'tasks/rubyforge'
require 'tasks/sprout'

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



# package .swc as .zip
Rake::PackageTask.new(Rake.application.jeweler.gemspec.name, Rake.application.jeweler.version) do |p|
	p.need_zip = true
	p.package_files.include("#{model.bin_dir}/#{model.project_name}.swc")
end

# generate sprout.spec
task :sprout_spec do |t|
  File.open('sprout.spec', 'w') do |f|
    f.write <<EOF
- !ruby/object:Sprout::RemoteFileTarget
  platform: universal
  url: http://cloud.github.com/downloads/disinnovate/as3spec/as3spec.swc.zip
  archive_path: '#{Rake.application.jeweler.gemspec.name}-#{Rake.application.jeweler.version}/#{model.bin_dir}/#{model.project_name}.swc'
EOF
  end
end