require 'pg'

class ResetDatabase
  def self.reset
    db_config = {
      host: 'postgres-proj',
      user: 'admin',
      password: 'password',
      dbname: 'admin'
    }

    reset_database(db_config)
  end

  def self.reset_database(db_config)
    db = PG.connect(db_config)

    db.exec("DELETE FROM tests;")
    db.exec("DELETE FROM exams;")
    db.exec("DELETE FROM doctors;")
    db.exec("DELETE FROM patients;")

    db.close
  end
end
