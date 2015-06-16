Model.new(:hourly_backup, 'PostgreSQL Hourly (24)') do
  database PostgreSQL
  compress_with Gzip
  notify_by Mail

  store_with Local do |local|
    local.keep  = 24
    local.path  = "/pg_dump/hourly/"
  end
end

Model.new(:daily_backup, 'PostgreSQL Daily (7)') do
  database PostgreSQL     
  compress_with Gzip
  notify_by Mail

  store_with Local do |local|
    local.keep     = 7
    local.path     = "/pg_dump/daily/"
  end
end
