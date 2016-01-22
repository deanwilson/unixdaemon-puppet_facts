require 'spec_helper'

describe 'ulimit', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  it 'should return a hash containing the "max_cpu_time" key' do

    limits = Facter.fact('ulimit').value

    expect(limits).to have_key('max_cpu_time')
  end

end
