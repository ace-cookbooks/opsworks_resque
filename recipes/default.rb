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

  ruby_block 'ensure resque started' do
    block do
      true
    end
    notifies :start, 'eye_service[resque]', :immediately
  end

  # Opsworks specific hack
  # Setting a node attribute to disable the restart recipe that will be run as part of the deploy.
  # On opsworks this only sticks for the current chef run.
  ruby_block 'block resque restart' do
    block do
      node.set['opsworks_resque']['disable_restart'] = true
    end
  end

  eye_app 'resque-scheduler' do
    template 'eye-resque-sched.conf.erb'
    cookbook 'opsworks_resque'
    variables({
      env: deploy[:environment],
      dir: deploy[:current_path],
      uid: deploy[:user],
      gid: deploy[:group],
      workers: node[:resque][:workers]
    })
  end

  ruby_block 'ensure resque scheduler started' do
    block do
      true
    end
    notifies :start, 'eye_service[resque-scheduler]', :immediately
  end
end
