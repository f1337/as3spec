# require Jeweler
begin
  require 'jeweler'
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


# sprout build task: builds "sprout-as3spec-library.gem"
task :sprout => [ :swc, :package, :sprout_spec, 'sprout:gemspec', 'sprout:build' ]


# build gem with Jeweler in "sprout" namespace
namespace :sprout do
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
		# gem.add_dependency('sprout', '>= 0.7.206')
		gem.rubyforge_project = 'as3spec'
	  # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
	end
end