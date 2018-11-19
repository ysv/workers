# Instead of loading all of Rails, load the
# particular Rails dependencies we need
require 'mysql2'
require 'activerecord'

# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)