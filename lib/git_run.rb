require 'rugged'

class GitRun
  def self.run(revision, command)
    repository.checkout_tree(revision, strategy: :force)
    output = `#{command}`
    repository.reset('master', :hard)
    output
  end

  def self.repository
    Rugged::Repository.new('.')
  end
end
