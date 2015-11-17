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
      assert_equal "This is the first revision of example.md\n",
        `#{bin_path} 8e65d3 cat example.md`
    end
  end
end
