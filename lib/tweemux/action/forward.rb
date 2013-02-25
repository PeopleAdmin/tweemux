class Tweemux::Action::Forward < Tweemux::Action
  def run args
    usage_fail 'wrong number of thingies' unless 5 == args.size
    host, hostport, from_, remote_host, port = args
    usage_fail 'third thingy has to be numeric port' unless is_int? hostport
    usage_fail 'fourth thingy has to be "from"' unless 'from' == from_
    usage_fail 'fith thingy has to be numeric port' unless is_int? port
    host = 'localhost' if 'local' == host
    explained_run %W(ssh -fNR #{port}:#{host}:#{hostport} #{remote_host}),
      '-f = background, -N = no remote command, -R = remote forward'
  end

  def usage_fail what_happened
    raise FunkyUsage,
      (what_happened+". Expected usage:\n  ").color(:error_explanation) + 
      'tweemux '.color(:keyword) + colored_sample_command
  end

  def colored_sample_command
    [
      'forward'.color(:keyword),
      'local'.color(:host),
      '22'.color(:number),
      'from'.color(:keyword),
      'sharpsaw.org'.color(:host),
      '3322'.color(:number),
    ].join ' '
  end

  def is_int? str
    str.to_i.to_s == str
  end
end
