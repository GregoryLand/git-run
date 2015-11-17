require 'rugged'

class GitRun
  def self.run(revision, command)
    return repository.in_revision(revision) { `#{command}` }
  end

  def self.repository
    Repository.new('.')
  end

  class Repository < Rugged::Repository
    def in_revision(revision)
      checkout_tree(revision, strategy: :force)
      output = yield
      reset('master', :hard)
      output
    end
  end
end
