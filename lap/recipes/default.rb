
require_recipe 'python'
require_recipe 'mysql::server'
require_recipe 'postgresql::server'
require_recipe 'postgresqldev'

package 'libmysqlclient-dev'
package 'sqlite3'

python_pip 'Flask' do
  action :install
end

python_pip 'Flask-Compass' do
  action :install
end

python_pip 'Flask-Coffee' do
  action :install
end

python_pip 'MySQL-python' do
  action :install
end

python_pip 'psycopg2' do
  action :install
end

python_pip 'SQLAlchemy' do
  action :install
end

python_pip 'Flask-SQLAlchemy' do
  action :install
end

python_pip 'Flask-Testing' do
  action :install
end

python_pip 'blinker' do
  action :install
end

template '/tmp/create_lap_db.sql' do
  source 'create_lap_db.sql.erb'
  action :create
end

execute 'create-lap-db' do
  command "mysql -hlocalhost -uroot -p#{node.mysql.server_root_password} mysql < /tmp/create_lap_db.sql"
  action :run
end

