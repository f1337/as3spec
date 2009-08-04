# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sprout-as3spec-library}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Fleet"]
  s.date = %q{2009-08-04}
  s.description = %q{AS3Spec is a tiny BDD framework for AS3, inspired by Bacon and RSpec. Built upon sprout project-generation tool for ActionScript/Flash/Flex/AIR.}
  s.email = %q{disinnovate@gmail.com}
  s.files = [
    "sprout.spec"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/disinnovate/as3spec}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["."]
  s.rubyforge_project = %q{as3spec}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{AS3Spec is a tiny BDD framework for AS3, inspired by Bacon and RSpec. Built upon sprout project-generation tool for ActionScript/Flash/Flex/AIR.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
