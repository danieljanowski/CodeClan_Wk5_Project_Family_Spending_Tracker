require( 'pg' )
require('uri')

class SqlRunner

  def self.run( sql, values = [] )
    uri = URI.parse(ENV["DATABASE_URL"])
    begin
      # db = PG.connect({ dbname: 'pocket_money', host: 'localhost' })
      db = PG.connect({
        host:uri.host,
        dbname: uri.path[1..-1],
        user: uri.user,
        password: uri.password
        })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
