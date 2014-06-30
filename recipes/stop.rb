node[:deploy].each do |application, deploy|
  include_recipe 'opsworks_resque::service'

  ruby_block 'stop resque and scheduler' do
    block do
      true
    end
    notifies :safe_stop, 'eye_service[resque]', :immediately
    notifies :safe_stop, 'eye_service[resque-scheduler]', :immediately
  end
end
