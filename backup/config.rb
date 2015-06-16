Backup::Database::PostgreSQL.defaults do |db|
  db.database           = "omero"
  db.username           = "omero"
  db.password           = ENV['DB_PASSWORD_OMERO']
  db.host               = ENV['DB_PORT_5432_TCP_ADDR']
  db.port               = ENV['DB_PORT_5432_TCP_PORT']
  # When dumping all databases, `skip_tables` and `only_tables` are ignored.
  #db.skip_tables        = ["skip", "these", "tables"]
  #db.only_tables        = ["only", "these", "tables"]
  db.additional_options = ["-Fc", "-E=utf8","--no-acl","--no-owner"]
end

