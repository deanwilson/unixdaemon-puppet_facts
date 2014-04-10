# Fact: ulimit
#
# Purpose:
#   Returns a hash containing ulimit values for the currently
#   running process.
#
#   Each limit entry contains keys representing the unit, soft limit and
#   hard limit.
#
# Resolution:
#   Reads the contents of /proc/$pid/limits
#
# Caveats:
#   Uses $::kernel to filter to only run on Linux. May work on other *nix
#   Requires facter 2 for structured facts.

Facter.add('ulimit') do
  confine :kernel => 'Linux'

  setcode do
    proc_file = '/proc/self/limits'

    limits = File.readlines(proc_file)
    limits.shift
 
    # priority ulimits don't have a unit so normalise them.
    limits.grep(/priority/).map { |limit| limit.gsub!(/\n/, 'niceness') }

    process_limits = {}
    limits.each do |limit|
      limit = limit.split

      desc_length = (limit.length - 4)

      desc = limit[0..desc_length].join('_').downcase

      process_limits[desc] = {
                               'soft' => limit[-3],
                               'hard' => limit[-2],
                               'unit' => limit[-1]
                             }
    end

    process_limits
  end
end
