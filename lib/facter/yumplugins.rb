# Fact: yumplugins
#
# Purpose: 
#   Returns a hash of arrays detailing the yum plugins present,
#   enabled and disabled
#
# Resolution:
#   Looks for an uncommented out enabled= line in each
#   /etc/yum/pluginconf.d/*.conf file
#
# Caveats:
#   Uses osfamily to filter. Only runs on RedHat family hosts
#   Requires facter 2 for structured facts.

Facter.add("yumplugins") do
  confine :osfamily => "RedHat"

  setcode do
    plugin_directory = '/etc/yum/pluginconf.d'
 
    plugins = {}
    plugins['plugin']   = [] 
    plugins['enabled']  = [] 
    plugins['disabled'] = [] 

    Dir[plugin_directory + '/*.conf'].each do | file |
      plugin_name = File.basename( file, '.conf')
  
      plugins['plugin'] << plugin_name
  
      enabled = File.open(file).read.grep(/^(\s*enabled\s*=\s*[01])/).to_s.split('=')[1]
  
      if enabled.to_i.zero?
        plugins['disabled'] << plugin_name
      else
        plugins['enabled'] << plugin_name
      end
  
    end

    plugins.keys.each do |key|
      plugins[key].sort!
    end

    plugins
  end
end
