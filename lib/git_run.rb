class GitRun
  def self.run(revision, command)
    `#{command}`
  end
end
