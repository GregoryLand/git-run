require 'rugged'

class GitRun
  def self.run(revision, command)
    raise GitRun::DirtyRepositoryError if repository.changes.any?
    return repository.in_revision(revision) { `#{command}` }
  end

  def self.repository
    Repository.new('.')
  end

  class DirtyRepositoryError < StandardError
  end

  class Repository < Rugged::Repository
    def changes
      changes = {}
      status { |file, status| changes[file] = status}
      changes
    end

    def in_revision(revision)
      checkout_tree(revision, strategy: :force)
      output = yield
      reset('master', :hard)
      output
    end
  end
end
