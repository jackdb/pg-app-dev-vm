APP_DB_USER=vagrant
APP_DB_PASS=vagrant

# Edit the following to change the name of the database that is created (defaults to the user name)
APP_DB_NAME=$APP_DB_USER

sudo -u postgres dropdb vagrant
sudo -u postgres dropdb staging

cat << EOF | su - postgres -c psql
-- Create the database user:
CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';

-- Create the database:
CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;
EOF

cat << EOF | su - postgres -c psql
-- Create a staging database:
CREATE DATABASE staging WITH OWNER=$APP_DB_USER
                                  LC_COLLATE='en_US.utf8'
                                  LC_CTYPE='en_US.utf8'
                                  ENCODING='UTF8'
                                  TEMPLATE=template0;
EOF

# Enable postgis for staging db
#alter schema permissions to allow filegdb import
sudo -u postgres psql -d staging -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d staging -c "CREATE EXTENSION postgis_topology;"
sudo -u postgres psql -d staging -c "ALTER SCHEMA public OWNER TO vagrant;"

# Enable postgis for db
sudo -u postgres psql -d $APP_DB_NAME -c "CREATE EXTENSION postgis;"
sudo -u postgres psql -d $APP_DB_NAME -c "CREATE EXTENSION postgis_topology;"
