node[:deploy].each do |application, deploy|
  include_recipe 'opsworks_resque::service'

  ruby_block 'restart resque and scheduler later' do
    block do
      true
    end
    notifies :restart, 'eye_service[resque]', :delayed
    notifies :restart, 'eye_service[resque-scheduler]', :delayed
  end
end
