class Tweemux::Action::Share < Tweemux::Action
  def run _
    chmod_a_rw = %w(chmod a+rw) + [Tweemux::SOCK]
    explained_run chmod_a_rw, 'makes the shared socket shareable'
    explained_run [ENV['SHELL']], 'only here to prevent the session from ending'
  end
end
