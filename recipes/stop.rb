node[:deploy].each do |application, deploy|
  ruby_block 'stop resque' do
    block do
      true
    end
    notifies :stop, 'eye_service[resque]', :immediately
    notifies :stop, 'eye_service[resque-scheduler]', :immediately
  end
end
