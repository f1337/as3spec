# Rebuild the spec suite.
# This generator can be executed as follows:
# 
#   script/generate suite
#
class SuiteGenerator < Sprout::Generator::NamedBase # :nodoc:

  def manifest
    record do |m|
      m.template 'SpecSuite.as', File.join(model.spec_dir, 'SpecSuite.as'), :collision => :force
      m.template 'SpecSuiteXML.as', File.join(model.spec_dir, 'SpecSuiteXML.as'), :collision => :force
    end
  end

  # Transform a file name in the source or test path
  # to a fully-qualified class name
  def actionscript_file_to_class_name(file)
    name = super(file)
		name.gsub!(/^#{model.spec_dir}\./, '')
    return name
  end

  # Filesystem path to the folder that contains the Spec file
  def full_test_dir
    @full_test_dir ||= full_class_dir.gsub(src_dir, model.spec_dir)
  end

  # Collection of all test case files either assigned or found
  # using the test_glob as provided.
  def test_cases
    @test_cases ||= Dir.glob(model.spec_dir + '**/**/?*Spec.as')
  end

  # Name of possible spec for this class_name
  def test_case_name
    @test_case_name ||= class_name + 'Spec'
  end
end
