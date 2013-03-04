class Tweemux::Action::Hubkey < Tweemux::Action
  attr_reader :github_user, :unix_user
  def run args
    @unix_user, @github_user = args
    @github_user ||= @unix_user
    run_with_both_usernames
  end

  def run_with_both_usernames
    ensure_ssh_dir_exists
    refuse_to_overwrite_authorized_keys_file
    install_github_keys
  end

  def ensure_ssh_dir_exists
    explained_run_as unix_user, %W(mkdir -p -m700 #{home_dir}/.ssh),
      "Make sure #{unix_user} has a ~/.ssh/ dir"
  end

  def refuse_to_overwrite_authorized_keys_file
    return unless File.exists? authorized_keys_path
    # TODO: some color
    raise NoRestartsException, <<-EOT
Refusing to overwrite #{authorized_keys_path}
Try: sudo cat #{authorized_keys_path}
Then maybe: sudo rm #{authorized_keys_path}
    EOT
  end

  def install_github_keys
    key_url = "https://github.com/#{github_user}.keys"
    explained_run_as unix_user, %W(curl #{key_url} -o #{authorized_keys_path}),
      "Download #{github_user}'s 'keyholes' from Github"
  end

  def home_dir
    begin
      their_dir = File.expand_path '~'+unix_user
    rescue ArgumentError
      raise NoSuchHomeDir
    end
  end

  def authorized_keys_path; home_dir+'/.ssh/authorized_keys' end
end
