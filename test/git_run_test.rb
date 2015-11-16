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

  it "runs a command in a specific revision" do
    assert_equal "This is the first revision of example.md\n",
      GitRun.run('8e65d39fcf691f3c020c3bfbe1ac4a90cb13237d', 'cat example.md')
  end

  it "returns to the original revision after running" do
    GitRun.run('8e65d39fcf691f3c020c3bfbe1ac4a90cb13237d', 'cat example.md')
    assert `git status`.include?('working directory clean')
  end
end
