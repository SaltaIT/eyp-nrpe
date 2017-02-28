require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'nrpe class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'nrpe':
        allowed_hosts => [],
        dont_blame_nrpe => true,
      }

      nrpe::command { 'check_test':
        command => 'echo $ARG1$$ARG2$'
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe file("/etc/nagios/nrpe.cfg") do
      it { should be_file }
      its(:content) { should match 'dont_blame_nrpe=1' }
      its(:content) { should include('command[check_test]=echo $ARG1$$ARG2$') }
    end

    describe port(5666) do
      it { is_expected.to be_listening }
    end

    it "check nrpe return code" do
      expect(shell($exec_nrpe + " -H 127.0.0.1 -c check_test -a O K").exit_code).to be_zero
    end

    it "check nrpe string OK" do
      expect(shell($exec_nrpe + " -H 127.0.0.1 -c check_test -a O K | grep OK").exit_code).to be_zero
    end

  end
end
