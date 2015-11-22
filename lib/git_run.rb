require 'rugged'

class GitRun

  def self.run(revision, command)
    raise DirtyRepositoryError if repository.changes.any?

    return repository.in_revision(revision) { `#{command}` }
  end

  def self.repository
    begin
      Repository.new('.')
    rescue Rugged::RepositoryError
      raise NoRepositoryError
    end
  end

  class Repository < Rugged::Repository
    def changes
      changes = {}
      status { |file, status| changes[file] = status}
      changes
    end

    def in_revision(revision)
      begin
        checkout_tree(revision, strategy: :force)
        output = yield
        reset('master', :hard)
      rescue Rugged::ReferenceError
        raise RevisionNotFoundError
      end
      output
    end
  end

  class NoRepositoryError < StandardError
  end

  class RevisionNotFoundError < StandardError
  end

  class DirtyRepositoryError < StandardError
  end
end
