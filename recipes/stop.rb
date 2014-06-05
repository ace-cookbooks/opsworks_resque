node[:deploy].each do |application, deploy|
  bash 'stop resque' do
    code <<-EOH
    sleep 1
    /usr/local/bin/eye stop workers
    EOH
    user 'root'
    action :run
  end
end
