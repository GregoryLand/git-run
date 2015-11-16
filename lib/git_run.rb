require 'rugged'

class GitRun
  def self.run(revision, command)
    repository = Rugged::Repository.new('.')
    repository.checkout_tree(revision, strategy: :force)
    output = `#{command}`
    repository.reset('master', :hard)
    output
  end
end
