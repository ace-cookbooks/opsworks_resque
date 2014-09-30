begin
  resources('eye_service[resque]')
rescue Chef::Exceptions::ResourceNotFound
  eye_service 'resque' do
    supports [:start, :stop, :safe_stop, :restart, :safe_restart, :enable, :load]
    user_srv_uid 'root'
    user_srv_gid 'root'
    action :nothing
  end
end
