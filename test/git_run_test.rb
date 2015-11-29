require 'minitest/autorun'
require_relative '../lib/git_run'

examples_path = File.expand_path(File.dirname(__FILE__) + '/../examples')

describe GitRun do
  describe "in a git repository" do
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

    it "raises an error when the requested revision doesn't exist" do
      assert_raises(GitRun::RevisionNotFoundError) do
        GitRun.run('nope', 'ruby test.rb')
      end
    end

    describe "in a different branch" do
      before do
        `git checkout develop`
      end

      after do
        `git checkout master`
      end

      it "returns to the original revision after running" do
        GitRun.run('master', 'ruby test.rb')
        assert `git status`.include?('working directory clean')
      end
    end

    describe "when the repository is in a dirty state" do
      before do
        File.delete('test.rb')
      end

      after do
        `git checkout test.rb`
      end

      it "raises an error" do
        assert_raises(GitRun::DirtyRepositoryError) do
          GitRun.run('master', 'ruby test.rb')
        end
      end
    end
  end

  describe "when not in a git repository" do
    before do
      @path = Dir.tmpdir
      Dir.chdir(@path)
    end

    it "raises an error" do
      assert_raises(GitRun::NoRepositoryError) do
        GitRun.run('master', 'ruby test.rb')
      end
    end
  end
end
