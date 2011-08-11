### Used from blt04
### https://github.com/blt04/puppet-rvm/

Puppet::Type.type(:rvm).provide(:rvm) do
  desc "Ruby RVM support."

  commands :rvmcmd => "/usr/local/rvm/bin/rvm"

  def create
    rvmcmd "install", resource[:name]
  end

  def destroy
    rvmcmd "uninstall", resource[:name]
  end

  def exists?
    begin
      rvmcmd("list", "strings").any? do |line|
        line =~ Regexp.new(Regexp.escape(resource[:name]))
      end
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list RVMs: #{detail}"
    end

  end

  def default
    begin
      rvmcmd("list", "default", "string").any? do |line|
        line =~ Regexp.new(Regexp.escape(resource[:name]))
      end
    rescue Puppet::ExecutionFailure => detail
      raise Puppet::Error, "Could not list default RVM: #{detail}"
    end
  end

  def default=(value)
    rvmcmd "--default", "use", resource[:name] if value
  end
end
