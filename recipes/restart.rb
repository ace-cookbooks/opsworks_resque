node[:deploy].each do |application, deploy|
  ruby_block 'restart resque and scheduler later' do
    block do
      true
    end
    notifies :restart, 'eye_service[resque]', :delayed
    notifies :restart, 'eye_service[resque-scheduler]', :delayed
  end
end
