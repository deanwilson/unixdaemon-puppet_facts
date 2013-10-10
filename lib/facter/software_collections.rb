# Fact: software_collections
#
# Purpose: 
#   Facts to expose the software collections available on the host
#   and the scl puppet/facter is running under.
#

Facter.add('scl_available') do
  confine :kernel => :linux

  setcode do
    scl_list = '/usr/bin/scl --list'

    enabled = Facter::Util::Resolution.exec(scl_list).to_a
    enabled.to_s.gsub(/\n/, ',')
  end
end


Facter.add('scl_enabled') do
  confine :kernel => :linux

  if ENV.key?('X_SCLS')
    setcode do
      ENV['X_SCLS']
    end
  end
end
