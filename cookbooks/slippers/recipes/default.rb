apt_repository 'brightbox' do
  uri 'ppa:brightbox/ruby-ng'
  components %w[main stable]
end

include_recipe 'apt' # this will execute an `apt-get update`

package [
  'fish',
  'git',
  'libmysqlclient-dev',
  'libpq-dev',
  'mysql-client',
  'mysql-server',
  'ruby2.4',
  'ruby2.4-dev',
] do
  action :upgrade
end

include_recipe 'ruby_build'

node.default['rbenv']['user_installs'] = [
  {
    'user'    => 'vagrant',
    'rubies'  => ['2.4.1', '1.9.3-p0'],
    'global'  => '2.4.1',
    'gems'    =>
    {
      '2.4.1' => [
        { 'name' => 'bundler' },
        { 'name' => 'rubocop' },
        { 'name' => 'sequel' },
        { 'name' => 'mysql2' },
      ],
      '1.9.3-p0' => [
        {
          'name' => 'bundler',
          'version' => '1.1.rc.5',
        },
        { 'name' => 'rake' },
      ],
    },
  },
]

# Install rbenv and makes it avilable to the selected user
version = '2.4.1'

# Keeps the rbenv install upto date
rbenv_user_install 'vagrant'

rbenv_plugin 'ruby-build' do
  git_url 'https://github.com/rbenv/ruby-build.git'
  user 'vagrant'
end

rbenv_ruby '2.4.1' do
  user 'vagrant'
end

rbenv_global version do
  user 'vagrant'
end

#include_recipe 'ruby_rbenv::user'

ssh_known_hosts_entry 'github.com'

# these will end up in the system ruby
gem_package 'bundler'
gem_package 'mysql2'
gem_package 'pry'
gem_package 'rake'
gem_package 'rubocop'
gem_package 'sequel'

directory '/usr/local/git_checkout' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end
