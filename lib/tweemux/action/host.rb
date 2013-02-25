class Tweemux::Action::Host < Tweemux::Action
  def run _
    self.class.tmux_S %w'start-server',
      'brings up the tmux process'
    self.class.tmux_S ['new', 'tweemux share'],
      "starts sesssion '0', repermissionizes, then runs '#{ENV['SHELL']}'"
  end
end
