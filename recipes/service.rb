service_list = [resources('eye_service[resque]')].flatten
if service_list.size != 1
  eye_service 'resque' do
    supports [:start, :stop, :safe_stop, :restart, :safe_restart, :enable, :load]
    user_srv_uid 'root'
    user_srv_gid 'root'
    action :nothing
  end
end

service_list = [resources('eye_service[resque-scheduler]')].flatten
if service_list.size != 1
  eye_service 'resque-scheduler' do
    supports [:start, :stop, :safe_stop, :restart, :safe_restart, :enable, :load]
    user_srv_uid 'root'
    user_srv_gid 'root'
    action :nothing
  end
end
