system('dropdb munchwins')
system('createdb munchwins')
system('psql munchwins < schema.sql')
system('psql munchwins < user.sql')
# system("heroku pg:psql #{DATABASE_URL} < schema.sql")