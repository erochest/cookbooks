
require_recipe 'build-essential'

execute 'apt-get-update' do
  command 'apt-get update'
  user 'root'
  action :run
end

DEPENDS = %w{zlib1g-dev
             libgmp3-dev
             libglu1-mesa-dev
             freeglut3-dev}
DEPENDS.each do |pkg|
  package pkg do
    action :install
  end
end

remote_file '/tmp/haskell-7.0.3.tar.bz2' do
  source node[:haskell][:bootstrap_url]
  mode '0644'
end

script 'install-haskell-7.0.3' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOS
  tar xfj haskell-7.0.3.tar.bz2
  cd /tmp/ghc-7.0.3
  ./configure
  make install
  EOS
end

remote_file '/tmp/haskell-platform.tar.gz' do
  source node[:haskell][:url]
  mode '0644'
end

script 'install-haskell-platform' do
  interpreter 'bash'
  user 'root'
  cwd '/tmp'
  code <<-EOS
  tar xfz haskell-platform.tar.gz
  cd haskell-platform-*
  ./configure
  make
  make install
  EOS
end

script 'cleanup-haskell-install' do
  interpreter 'bash'
  user 'root'
  code <<-EOS
  rm -rf /tmp/ghc-7.0.3
  rm -rf /tmp/haskell-7.0.3.tar.bz2
  rm -rf /tmp/haskell-platform.tar.gz
  EOS
end

execute 'cabal-update' do
  command 'cabal update'
  user 'root'
end

node[:haskell][:cabal].each do |cabalpkg|
  execute "cabal-#{cabalpkg}" do
    command "cabal install --global #{cabalpkg}"
    user 'root'
    action :run
  end
end

