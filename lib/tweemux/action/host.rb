class Tweemux::Action::Host < Tweemux::Action
  def run _
    tmux_S %w'start-server', 'brings up the tmux process'
    tmux_S ['new', 'tweemux share'],
      "starts sesssion '0', repermissionizes, then runs '#{ENV['SHELL']}'"
  end
end
