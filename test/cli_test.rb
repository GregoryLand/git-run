require 'minitest/autorun'
examples_path = File.expand_path(File.dirname(__FILE__) + '/../examples')
bin_path = File.expand_path(File.dirname(__FILE__) + '/../bin/git-run')

describe "git run" do
  describe "when not in a git repository" do
    before do
      @path = Dir.tmpdir
      Dir.chdir(@path)
    end

    it "returns an error" do
      assert_equal "/private#{@path} is not a git repository.\n",
        `#{bin_path} master ls 2>&1`
    end
  end

  describe "in a git repository" do
    before do
      Dir.chdir(examples_path)
    end

    it "runs a command in a specific revision" do
      assert_equal "...FF\n",
        `#{bin_path} ad1211 ruby test.rb`
    end

    it "returns an error when the revision does not exist" do
      assert_equal "'nope' is not a revision in this repository.\n",
        `#{bin_path} nope ls 2>&1`
    end

    describe "when the repository is in a dirty state" do
      before do
        File.delete('test.rb')
      end

      after do
        `git checkout test.rb`
      end

      it "returns an error" do
        assert_equal "The repository at #{examples_path} is in a dirty state.\n",
          `#{bin_path} ad1211 ls 2>&1`
      end
    end
  end

  describe "command line options" do
    it "shows the help message" do
      assert_equal [
        "Usage: git run [options] <revision> <command>\n",
        "    -h, --help                       Show this message\n"
      ].join, `#{bin_path}`
    end

    it "shows the help message when passing the -h flag" do
      assert_equal [
        "Usage: git run [options] <revision> <command>\n",
        "    -h, --help                       Show this message\n"
      ].join, `#{bin_path} -h`
    end
  end
end
