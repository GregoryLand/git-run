require 'minitest/autorun'
require_relative '../lib/git_run'

examples_path = File.expand_path(File.dirname(__FILE__) + '/../examples')

describe GitRun do
  before do
    Dir.chdir(examples_path)
  end

  it "runs a command" do
    assert_equal ".....\n",
      GitRun.run('master', 'ruby test.rb')
  end

  it "runs a command in a specific revision" do
    assert_equal "...FF\n",
      GitRun.run('ad1211752236b46c1399ccd8d46133eaef3384c1', 'ruby test.rb')
  end

  it "returns to the original revision after running" do
    GitRun.run('ad1211752236b46c1399ccd8d46133eaef3384c1', 'ruby test.rb')
    assert `git status`.include?('working directory clean')
  end
end
