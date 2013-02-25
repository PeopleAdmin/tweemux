class Tweemux
  class Action
    def initialize args
      @args = args
    end

    def call
      raise 'Unimplemented'
    end
  end
end

dir = __FILE__.sub /\.rb$/, ''
Dir[dir + '/*.rb'].each do |e|
  require e.sub /.*(tweemux\/.+)\.rb$/, '\1'
end