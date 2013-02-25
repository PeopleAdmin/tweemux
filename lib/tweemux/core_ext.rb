class String
  # Pallete viewable from:
  #   https://github.com/sharpsaw/tmux-dots/blob/master/bin/colortest
  COLORS = {
    :middle_blue => 69,
    :brighty_blue => 39,
    :gray245 => 245,
    :orange => 172,
    :pale_yellow => 180,
    :lemon => 228,

    :keypress => 157,
    :prompt => 35,

    :error => 160,
    :default => 7
  }
  def color this_color, end_on = :default
    [this_color, end_on].each{|e| fail "No color named #{e}" unless COLORS[e]}
    if $stderr.tty?
      "\e[38;5;#{COLORS[this_color]}m#{self}\e[38;5;#{COLORS[end_on]}m"
    else
      self
    end
  end
end
