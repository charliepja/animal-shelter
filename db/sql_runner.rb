require('pg')
require_relative('../models/animal.rb')
class SqlRunner

	def self.run(sql, values=[])
		begin
			db = PG.connect({dbname: 'dbr8vksif30q3k', host: 'ec2-107-20-185-16.compute-1.amazonaws.com', port: '5432', user: 'dzzdjgztpnthvy', password: '413d2bd824bfcc294ad7d4ad6e799600e5a33d8c5a253f47d4bab66ac1990c78'})
			db.prepare('query', sql)
			result = db.exec_prepared('query', values)
		ensure
			db.close() if db != nil
		end
		return result
	end

end
