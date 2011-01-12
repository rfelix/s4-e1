require 'steak'

def tv_show_exec(args="")
  tv_show_exec_path = File.join(File.dirname(__FILE__), '..', '..', 'bin', 'tv_show')
  %x{#{tv_show_exec_path} #{args}}
end
