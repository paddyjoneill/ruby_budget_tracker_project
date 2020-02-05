require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: 'ddbrgmsbqm7114',
        host: 'ec2-54-197-34-207.compute-1.amazonaws.com',
        port: 5432,
        user: 'wpekypzxxkenpp',
        password: '84370ec1608601706f2e1289f196b7aef3aa905416fd7ecacc66a412c70be03e'
        })
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
