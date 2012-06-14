# ==============================
# Set your db credentials below:
# ==============================
db = ENV['DATABASE_URL']

# you should not need to change anything below this line
# ======================================================
require 'pg'
require 'active_record'

def establish_active_record_connection(url)
  regex = /(.*):\/\/(.*):(.*)@(.*):([\d]{3,5})\/(.*)/
  matchdata = regex.match(url)

  if matchdata.length == 7
    ActiveRecord::Base.establish_connection(
      :adapter => "postgresql",
      :username => matchdata[2],
      :password => matchdata[3],
      :host => matchdata[4],
      :port => Integer(matchdata[5]),
      :database => matchdata[6],
      :pool => 5,
      :wait_timeout => 60
    )
  end
end

begin
  establish_active_record_connection(db)
  ActiveRecord::Base.connection
  puts "Connection to SpacialDB established."
rescue => e
  abort "Failed to connect to database: #{e.message}"
end