#
# Cookbook Name:: opsworks_resque
# Recipe:: default
#
node[:deploy].each do |application, deploy|
  execute 'bundle binstubs rake' do
    user deploy[:user]
    group deploy[:group]
    environment(deploy[:environment])
    cwd deploy[:current_path]
    command "#{deploy[:bundler_binary]} binstubs rake"
  end

  eye_app 'resque' do
    template 'eye-resque.conf.erb'
    cookbook 'opsworks_resque'
    variables({
      env: deploy[:environment],
      dir: deploy[:current_path],
      uid: deploy[:user],
      gid: deploy[:group],
      workers: node[:resque][:workers]
    })
  end

  ruby_block 'restart resque on deploy' do
    block do
      true
    end
    notifies :restart, 'eye_service[resque]', :delayed
    not_if { node[:opsworks][:activity] == 'setup' }
  end

  eye_app 'resque-scheduler' do
    template 'eye-resque-sched.conf.erb'
    cookbook 'opsworks_resque'
    variables({
      env: deploy[:environment],
      dir: deploy[:current_path],
      uid: deploy[:user],
      gid: deploy[:group]
    })
  end

  ruby_block 'restart resque-scheduler on deploy' do
    block do
      true
    end
    notifies :restart, 'eye_service[resque-scheduler]', :delayed
    not_if { node[:opsworks][:activity] == 'setup' }
  end
end
