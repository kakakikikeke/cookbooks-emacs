# frozen_string_literal: true

emacs_binary = '/usr/local/bin/emacs'

control 'emacs-install' do
  impact 1.0
  title 'Check Emacs installation'

  describe file(emacs_binary) do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{emacs_binary} --version") do
    its('exit_status') { should eq 0 }
    expect = /GNU Emacs/
    its('stdout') { should match expect }
  end
end
