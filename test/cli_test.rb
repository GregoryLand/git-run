require 'minitest/autorun'
examples_path = File.expand_path(File.dirname(__FILE__) + '/../examples')

describe "git run" do
  before do
    Dir.chdir(examples_path)
  end

  it "runs a command in a specific revision" do
    assert_equal "This is the first revision of example.md\n",
      `../bin/git-run 8e65d3 cat example.md`
  end
end
