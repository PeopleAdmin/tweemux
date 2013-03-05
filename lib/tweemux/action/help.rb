class Tweemux::Action::Help < Tweemux::Action
  def run _
    five_dirs_up = (['..']*5).join '/'
    readme_path =
      File.expand_path 'lib/tweemux/action/help.rb'+five_dirs_up+'/README.md'
    contents = File.read readme_path
    contents.sub! /^.+(?=## Guest Usage)/m, ''
    contents.sub! /## Going Further.*/m, ''
    contents.sub! /For starters.+?gem install tweemux\n\n/mi, ''
    contents.gsub! /^## (.+)/ do |m| m.color :heading end
    contents.gsub! /^    .+/ do |m| m.color :command end
    warn contents
  end
end
