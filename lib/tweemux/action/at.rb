class Tweemux::Action::At < Tweemux::Action
  def run args
    host, port, *rest = args
    cmd = 'ssh', host
    if port
      cmd.push '-p'+port
      port_parens = " (on port #{port})"
    end
    desc = ["Connect to #{host}#{port_parens}"]
    forced_path_for_osx_people = 'PATH=/usr/local/bin:/usr/bin'
    cmd.concat [ '-t', forced_path_for_osx_people ]
    desc.push 'demand a pty'
    cmd.concat [ 'tmux', '-2uS', Tweemux::SOCK ]
    desc.push 'Run tmux (with 256 colors, UTF-8, on the shared socket'
    if rest.empty?
      cmd.push 'attach'
      desc.push 'attach to existing session'
    else
      cmd.concat rest
      desc.push rest.join ' '
    end
    description = desc.join ', '
    explained_run cmd, description
  end
end
