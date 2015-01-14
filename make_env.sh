SECRETS="secrets.ejson"

# POSTGRES_PASSWORD is used by the official PostgreSQL image
# This is needed to start the database.
secret=`ejson decrypt $SECRETS |jq '.db_password_postgres'`
secret=`echo $secret|sed 's/"//g'`
export POSTGRES_PASSWORD=$secret

# DB_PASSWORD_OMERO is used by pg_omero/import_and_update_omero_db.sh.
# This is the password that is given to user 'omero' in the database.
secret=`ejson decrypt $SECRETS |jq '.db_password_omero'`
secret=`echo $secret|sed 's/"//g'`
export DB_PASSWORD_OMERO=$secret

# OMERO_TRUSTSTORE_PASSWORD is used by OMERO server to access a Keystore file
# that is used to store the LDAP server certificate chain.
secret=`ejson decrypt $SECRETS |jq '.omero_truststore_password'`
secret=`echo $secret|sed 's/"//g'`
export OMERO_TRUSTSTORE_PASSWORD=$secret

# OMERO_ROOT_PASSWORD is password for 'root' to login to OMERO server.
secret=`ejson decrypt $SECRETS |jq '.omero_root_password'`
secret=`echo $secret|sed 's/"//g'`
export OMERO_ROOT_PASSWORD=$secret

