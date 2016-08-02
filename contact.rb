require 'pg'

# Represents a person in an address book.

class Contact

  attr_accessor :name, :email
  attr_reader :id
  
  # Creates a new contact object

  def initialize(name, email, id=nil) 
    @name = name
    @email = email
    @id = id
  end

  def to_s
    "#{id}: #{name} (#{email})"
  end

  def save
    results = Contact.connection.exec_params('INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id, name, email;', [@name, @email])
  end
  
  class << self
    
    def connection
      @@conn = PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
        )
      @@conn
    end


    #Dispays list of all contacts in the 'contacts' database. 
    def all
      results = self.connection.exec_params('SELECT * FROM contacts ORDER BY id')
      results = results.map{|row|  self.new(row['name'], row['email'], row['id'])}
    end
      
    # Creates a new contact, adding it to the 'contacts' database, via the save instance method.
    def create(name, email)
      Contact.new(name, email)
    end
    
    # Find the Contact in the 'contacts' database with the matching id.
    def find(id)    
      results = self.connection.exec_params('SELECT * FROM contacts WHERE id = $1',[id])
      results = results.map{|row| self.new(row['name'], row['email'], row['id'])}
    end
    
    def search(name)
      results = self.connection.exec_params('SELECT * FROM contacts WHERE name LIKE $1',["%#{name}%"])
     
    end
  
  end
end
