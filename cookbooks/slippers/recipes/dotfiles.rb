package [
  'fish',
  'autojump',
] do
  action :upgrade
end

# TODO derp home directory
git '/home/vagrant/dotfiles' do
  repository 'https://github.com/davemenninger/dotfiles.git'
  revision 'master'
  user 'vagrant'
  group 'vagrant'
  action :checkout
end

# NOTE: this doesn't exit 0 usually, so for now it's not good to provision with
# execute 'symlink dotfiles' do
#   command 'bash /home/vagrant/dotfiles/makesymlinks.sh'
#   user 'vagrant'
#   environment ({'HOME' => '/home/vagrant', 'USER' => 'vagrant'})
# end
