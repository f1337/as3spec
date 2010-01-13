class ClassGenerator < Sprout::Generator::NamedBase  # :nodoc:

  def manifest
    record do |m|
      if (!user_requested_test)
        m.directory full_class_dir
        m.template 'Class.as', full_class_path
      end
 
      m.directory full_test_dir
      m.template '../../spec/templates/Spec.as', full_test_case_path
      m.template '../../suite/templates/SpecSuite.as', File.join(model.spec_dir, 'SpecSuite.as'), :collision => :force
    end
  end

  # Name of possible spec for this class_name
  def test_case_name
    @test_case_name ||= class_name + 'Spec'
  end

  # Filesystem path to the folder that contains the Spec file
  def full_test_dir
    @full_test_dir ||= full_class_dir.gsub(src_dir, model.spec_dir)
  end
end