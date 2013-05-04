# Fact: yum_enabled_plugins
#
# Purpose: Return a csv list of enabled yum plugins
#
# Resolution:
#   Looks for an uncommented out enabled= line in each
#   /etc/yum/pluginconf.d/*.conf file
#
# Caveats:
#   Uses osfamily to filter. Only runs on RedHat family hosts
#   Stops reading the file at the first enabled line.
#

Facter.add('yum_enabled_plugins') do
  confine :osfamily => 'RedHat'

  plugins_directory = '/etc/yum/pluginconf.d'
  enabled_plugins = []

  Dir[plugins_directory + '/*.conf'].each do | file | 
    plugin_name = File.basename( file, '.conf')

    if File.open(file).read.grep(/^(\s*enabled\s*=\s*1)/).any?
      enabled_plugins << plugin_name
    end

  end

  setcode { enabled_plugins.sort.uniq.join(',') }
end
