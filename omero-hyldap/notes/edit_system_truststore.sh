# change default keystore password
keytool -storepasswd -keystore $OMERO_TRUSTSTORE<<-EOF
changeit
$OMERO_TRUSTSTORE_PASSWORD
$OMERO_TRUSTSTORE_PASSWORD
EOF


cd /tmp

# Add CA certificates to keystore.
wget http://www.terena.org/activities/tcs/repository/AddTrust_External_CA_Root.pem
wget http://www.terena.org/activities/tcs/repository/UTN-USERFirst-Hardware.pem
wget http://www.terena.org/activities/tcs/repository/TERENA_SSL_CA.pem
wget http://www.terena.org/activities/tcs/repository/TERENA_eScience_SSL_CA.pem

OPTS="-keystore $OMERO_TRUSTSTORE -import -trustcacerts"
keytool $OPTS -alias addtrustexternalcaroot -file AddTrust_External_CA_Root.pem <<-EOF
$OMERO_TRUSTSTORE_PASSWORD
no
EOF

keytool $OPTS -alias utnuserfirsthw -file UTN-USERFirst-Hardware.pem <<-EOF
$OMERO_TRUSTSTORE_PASSWORD
no
EOF

keytool $OPTS -alias terenasslca -file TERENA_SSL_CA.pem <<-EOF
$OMERO_TRUSTSTORE_PASSWORD
no
EOF

keytool $OPTS -alias terenaesciencesslca -file TERENA_eScience_SSL_CA.pem <<-EOF
$OMERO_TRUSTSTORE_PASSWORD
no
EOF

rm *.pem



