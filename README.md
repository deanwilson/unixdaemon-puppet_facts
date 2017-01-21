UnixDaemon Puppet Facts
=======================

A collection of my facter facts that don't fit better in more specific repos

ansible_facts :: Returns a data structure containing all the Ansible facts
from the localhost. Very basic implementation.


yumplugins :: Returns a data structure detailing the yum plugins present, enabled and disabled on the system. Requires facter2 and uses the structured fact support.

ulimit :: Returns a data structure containing ulimit values for the currently running process.

scl_enabled :: Returns a csv list of software collections available on this host

scl_available :: the software collection puppet/facter is running under

yum_enabled_plugins :: Return a csv list of enabled yum plugins 

### kvm_vms

Returns three facts, each representing the KVM instances running on the host, in
a different structure.

 * kvm_vms - Returns a comma separated string containing the hostname
  of each virtual machine on this host.

 * kvm_vms_array - Returns an array of hashes. Each hash contains the `name`, `domain id`
  and `state` of a virtual machine on this host.

 * kvm_vms_hash Returns a hash. Each key is the hostname of a virtual machine on
  this host. Each value is a hash containing the `name`, `domain id`
  and `state` of that virtual machine.
