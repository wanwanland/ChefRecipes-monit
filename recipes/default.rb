#
# Cookbook Name:: monit
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

filename = "rpmforge-release-0.5.1-1.el5.rf.i386.rpm"
checksum =  "3d388d6b1d707c237da06d1c1d27a0cc3bd78721c75b5a86518aead3321b0b41"
cookbook_file "/tmp/#{filename}" do
    source "#{filename}"
    checksum "#{checksum}"
    mode 0755
end

package "rpmforge-release" do
    action :install
    source "/tmp/rpmforge-release-0.5.1-1.el5.rf.i386.rpm"
    provider Chef::Provider::Package::Rpm

end
rpm_package "monit" do
  source "/tmp/rpmforge-release-0.5.1-1.el5.rf.i386.rpm"
  action :install
end
yum_package "monit" do
    action :install
end
template "/etc/monit.conf" do
	source "monit.conf.erb"
	owner "root"
	mode "0700"
end
service "monit" do
  supports :status => true, :restart => true, :reload => true
  action   [ :enable, :start ]
end