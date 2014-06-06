node[:deploy].each do |application, deploy|
  ruby_block 'restart resque later' do
    block do
      true
    end
    notifies :restart, 'eye_service[resque]', :delayed
  end
end
