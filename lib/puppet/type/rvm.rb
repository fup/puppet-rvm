### Used from blt04
### https://github.com/blt04/puppet-rvm/

Puppet::Type.newtype(:rvm) do
  @doc = "Manage RVM Ruby installations."

  ensurable

  newparam(:name) do
    desc "The name of the Ruby to be managed."
    isnamevar
  end

  newproperty(:default) do
    desc "The default system Ruby"
    defaultto false
  end
end