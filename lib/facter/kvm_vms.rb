# Fact: kvm_vms
#
# Purpose:
#   Returns a comma separated string containing the hostname
#   of each virtual machine on this host.
#
# Fact: kvm_vms_array
#
# Purpose:
#   Returns an array of hashes. Each hash contains the `name`, `domain id`
#   and `state` of a virtual machine on this host.
#
# Fact: kvm_vms_hash
#
# Purpose:
#   Returns a hash. Each key is the hostname of a virtual machine on
#   this host. Each value is a hash containing the `name`, `domain id`
#   and `state` of that virtual machine.
#
# Resolution:
#   These facts use the `virsh list --all` command.
#   They do not use the `ruby-libvirt` gem as this requires more
#   dependencies when being installed under the puppet agent.
#
# Caveats:
#   Uses `$::kernel` to filter to only run on Linux.
#   Requires facter 2 for structured facts.
#   Requires the `virsh` command
#

def get_vms
  return [] unless File.executable? '/usr/bin/virsh'

  cmd_out = Facter::Core::Execution.exec('/usr/bin/virsh list --all ').split("\n")

  cmd_out.shift(2) # remove the outputs headers

  return [] if cmd_out.empty?

  cmd_out.map! { |line| line.chomp }
end

# only get the data once per run
kvm_vms = get_vms

Facter.add('kvm_vms_hash') do
  confine kernel: 'Linux'

  setcode do
    vms = {}

    kvm_vms.each do |line|
      fields = line.chomp.split
      vms[fields[1]] = { domain_id: fields[0].to_i, state: fields[2] }
    end

    vms
  end
end

Facter.add('kvm_vms_array') do
  confine kernel: 'Linux'

  setcode do
    vms = []

    kvm_vms.each do |line|
      fields = line.chomp.split
      vms << { domain_id: fields[0].to_i, name: fields[1], state: fields[2] }
    end

    vms
  end
end


Facter.add('kvm_vms') do
  confine kernel: 'Linux'

  setcode do
    kvm_vms.collect { |vm| vm.split[1] }.sort.join(',')
  end
end

