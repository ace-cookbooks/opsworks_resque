node[:deploy].each do |application, deploy|
  ruby_block 'restart resque later' do
    block do
      true
    end
    notifies :restart, 'eye_service[resque]', :delayed
    notifies :restart, 'eye_service[resque-scheduler]', :delayed
    not_if { node['opsworks_resque']['disable_restart'] == true }
  end
end
