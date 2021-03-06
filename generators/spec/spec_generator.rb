# Generate a new as3spec Spec and rebuild the spec suite.
# This generator can be executed as follows:
# 
#   script/generate spec utils.MathUtil
#
class SpecGenerator < SuiteGenerator # :nodoc:

  def manifest
    record do |m|
      m.directory full_test_dir
      m.template "Spec.as", full_test_case_path
      m.template '../../suite/templates/SpecSuite.as', File.join(model.spec_dir, 'SpecSuite.as'), :collision => :force
      m.template '../../suite/templates/SpecSuiteXML.as', File.join(model.spec_dir, 'SpecSuiteXML.as'), :collision => :force
    end
  end

end