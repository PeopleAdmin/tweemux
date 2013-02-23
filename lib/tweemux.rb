class Tweemux
  class << self
    def understand args
      true
    end

    def explained_run cmd
    end

    def run args
      explained_run %w(tmux -S /tmp/tweemux.sock start-server)
      explained_run %w(tmux -S /tmp/tweemux.sock new-session)
    end
  end
end
