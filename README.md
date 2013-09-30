# dotfiles.chef cookbook

# Requirements

# Usage

- clones dotfiles from `github.com/#{node['user']}/dotfiles`
- Executes dotfiles/setup.sh 
- Also copies ssh keys from the local machine running vagrant

To use with Vagrant, put something like this in your `Vagrantfile`

    config.vm.provision :chef_solo do |chef|
    chef.json = { 
      "dotfiles" => {
        "user" => "vagrant",
        "group" => "vagrant",
        "public_key" => IO.read(File.expand_path("~/.ssh/id_rsa.pub")),
        "private_key" => IO.read(File.expand_path("~/.ssh/id_rsa"))
      },
      "user" => "#{ENV['USER']}"
    }
    ...

# Attributes

    node['user']
    node['dotfiles']['user']
    node['dotfiles']['group']

# Recipes

# Author

Author:: Arafat M (<github@arafatm.com>)
