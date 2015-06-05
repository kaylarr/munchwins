system('dropdb munchwins')
system('createdb munchwins')
system('psql munchwins < schema.sql')