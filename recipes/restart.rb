node[:deploy].each do |application, deploy|
  bash 'restart resque' do
    code <<-EOH
    sleep 1
    /usr/local/bin/eye restart workers
    EOH
    user 'root'
    action :nothing
  end

  ruby_block 'restart resque later' do
    block do
      true
    end
    notifies :run, 'bash[restart resque]', :delayed
  end
end
