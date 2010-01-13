# Generate a new as3spec Spec and rebuild the spec suite.
# This generator can be executed as follows:
# 
#   script/generate spec utils.MathUtil
#
class SuiteGenerator < Sprout::Generator::NamedBase # :nodoc:

  def manifest
    record do |m|
      m.directory full_test_dir
      m.template 'SpecSuite.as', File.join(test_dir, 'SpecSuite.as'), :collision => :force
    end
  end
  
end
