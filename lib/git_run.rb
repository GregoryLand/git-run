require 'rugged'

class GitRun
  def self.run(revision, command)
    Rugged::Repository.new('.').checkout_tree(revision, strategy: :force)
    `#{command}`
  end
end
