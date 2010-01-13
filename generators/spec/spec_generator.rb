# Generate a new as3spec Spec and rebuild the spec suite.
# This generator can be executed as follows:
# 
#   script/generate spec utils.MathUtil
#
class SpecGenerator < Sprout::Generator::NamedBase # :nodoc:

  def manifest
    record do |m|
      m.directory full_test_dir
      m.template "Spec.as", full_test_case_path
      m.template '../../suite/templates/SpecSuite.as', File.join(test_dir, 'SpecSuite.as'), :collision => :force
    end
  end
  
end
