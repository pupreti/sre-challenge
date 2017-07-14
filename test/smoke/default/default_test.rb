# # encoding: utf-8

# Inspec test for recipe sre-challenge::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

describe package('apache2') do
  it { should be_installed }
end

describe command("curl -k localhost:443/index.html | grep 'SRE CHALLENGE'") do
  its('exit_status') { should eq 0 }
end

describe command("curl localhost/index.html | grep 'SRE CHALLENGE'") do
  its('exit_status') { should eq 0 }
end
