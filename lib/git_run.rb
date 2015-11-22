require 'rugged'

class GitRun

  def self.run(revision, command)
    raise DirtyRepositoryError.new(Dir.pwd) if repository.changes.any?

    return repository.in_revision(revision) { `#{command}` }
  end

  def self.repository
    begin
      Repository.new('.')
    rescue Rugged::RepositoryError
      raise NoRepositoryError.new(Dir.pwd)
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
        raise RevisionNotFoundError.new(revision)
      end
      output
    end
  end

  class Error < StandardError
    def initialize(subject)
      @subject = subject
    end
  end

  class NoRepositoryError < Error
    def message
      "#{@subject} is not a git repository."
    end
  end

  class RevisionNotFoundError < Error
    def message
      "'#{@subject}' is not a revision in this repository."
    end
  end

  class DirtyRepositoryError < Error
    def message
      "The repository at #{@subject} is in a dirty state."
    end
  end
end
