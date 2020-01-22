require('pg')
require_relative('../models/animal.rb')
class SqlRunner

	def self.run(sql, values=[])
		begin
			db = PG.connect({dbname: 'shelter', host: ENV['DATABASE_HOST']})
			db.prepare('query', sql)
			result = db.exec_prepared('query', values)
		ensure
			db.close() if db != nil
		end
		return result
	end

end
