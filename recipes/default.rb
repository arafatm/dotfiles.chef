#
# Cookbook Name:: dotfiles.chef
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute

home_dir = "/home/#{node['dotfiles']['user']}"

# sync dotfiles
git "#{home_dir}/dotfiles" do
  repository "git://github.com/#{node['user']}/dotfiles.git"
  reference "master"
  enable_submodules true
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  action :sync
end

# setup dotfiles
bash "setup_dotfiles" do
  cwd "#{home_dir}/dotfiles"
  user node['dotfiles']['user']
  group node['dotfiles']['group']
  environment "HOME" => home_dir
  code "./setup.sh"
end


# setup ssh keys
file "#{home_dir}/.ssh/id_rsa" do
  owner node['dotfiles']['user']
  group node['dotfiles']['group']
  mode "0600"
  content node['dotfiles']['private_key']
  action :create
end

file "#{home_dir}/.ssh/id_rsa.pub" do
  owner node['dotfiles']['user']
  group node['dotfiles']['group']
  mode "0600"
  content node['dotfiles']['public_key']
  action :create
end


