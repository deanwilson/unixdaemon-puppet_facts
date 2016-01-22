# Fact: ansible_facts
#
# Purpose:
#   Returns a hash containing all the ansible facts from the
#   localhost.
#
# Resolution:
#   Runs the Ansible command with the setup module.
#   /etc/yum/pluginconf.d/*.conf file
#
# Caveats:
#   Filters the results to only include ansible native facts. Otherwise you
#   can end up with ohai and facter facts also present in facter.
require 'json'

Facter.add('ansible_facts') do
  setcode do
    output_dir = '/tmp/ansible-facts'

    # this is a little slow. Add a cache if you run puppet a lot.
    command = "ansible localhost -m setup -a 'filter=ansible_*' -t #{output_dir}"

    if Facter::Core::Execution.exec(command)
      fact_file = "#{output_dir}/localhost"
      ansible_facts = JSON.load(File.read(fact_file))['ansible_facts']
    end

    ansible_facts
  end
end
