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


