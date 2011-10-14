
require_recipe 'python'
require_recipe 'mysql::server'
require_recipe 'postgresql::server'
require_recipe 'postgresqldev'

package 'libmysqlclient-dev'
package 'sqlite3'

python_pip 'Flask' do
  action :install
end

EXTENSIONS = ['Flask-Assets',
              'Flask-Compass',
              'Flask-Coffee',
              'flask-csrf',
              'Flask-DebugToolbar',
              # 'Flask-Login',
              'MySQL-python',
              'psycopg2',
              'SQLAlchemy',
              'Flask-SQLAlchemy',
              'Flask-Testing',
              'blinker']

EXTENSIONS.each do |ext|
  python_pip ext do
    action :install
  end
end

template '/tmp/create_lap_db.sql' do
  source 'create_lap_db.sql.erb'
  action :create
end

execute 'create-lap-db' do
  command "mysql -hlocalhost -uroot -p#{node.mysql.server_root_password} mysql < /tmp/create_lap_db.sql"
  action :run
end

