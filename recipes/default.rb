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
    # user_srv true
    # user_srv_uid deploy[:user]
    # user_srv gid deploy[:group]
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
    notifies :start, 'eye_service[resque]'
  end
end
