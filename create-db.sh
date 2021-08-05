POSTGRESUSER=$1
POSTGRESPASS=$2
FAVERSION=$3

export PGPASSWORD="$POSTGRESPASS"; 

psql -h 'localhost' -U $POSTGRESUSER -c 'create database fusionauth;'
curl -o scripts.zip https://files.fusionauth.io/products/fusionauth/1.29.0/fusionauth-database-schema-$FAVERSION.zip; 
unzip scripts.zip
cat postgresql.sql | psql -h 'localhost' -U $POSTGRESUSER

echo "database created"
