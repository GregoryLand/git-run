require 'minitest/autorun'
require_relative '../lib/git_run'

examples_path = File.expand_path(File.dirname(__FILE__) + '/../examples')

describe GitRun do
  before do
    Dir.chdir(examples_path)
  end

  it "runs a command" do
    assert_equal "This is the second revision of example.md\n",
      GitRun.run('master', 'cat example.md')
  end
end
