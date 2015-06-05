# Database connection and utility

def db
  connection_settings = { dbname: ENV["DATABASE_NAME"] || 'munchwins' }
  
  connection_settings[:host] = ENV["DATABASE_HOST"] if ENV["DATABASE_HOST"]
  
  connection_settings[:user] = ENV["DATABASE_USER"] if ENV["DATABASE_USER"]

  connection_settings[:password] = ENV["DATABASE_PASS"] if ENV["DATABASE_PASS"]

  begin
    connection = PG.connect(connection_settings)
    yield(connection)
  ensure
    connection.close
  end
end

def exec(sql)
  db {|conn| conn.exec(sql)}
end

def exec_params(sql, params)
  db {|conn| conn.exec_params(sql, params)}
end

def sanitize(params)
  params.each {|k, v| params[k].gsub!(/<|>/, '') if v.class == String}
end