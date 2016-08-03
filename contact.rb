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

  #Overrides default to_s method to display output as strings instead of 
  # SQL objects. 
  def to_s
    "#{id}: #{name} (#{email})"
  end

  #Saves instanced contact into 'contacts' database
  def save
    if id 
      Contact.connection.exec_params('UPDATE contacts SET name = $1, email = $2 WHERE id = $3;', [name, email, id])
    else
      Contact.connection.exec_params('INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id, name, email;',[@name, @email])
    end
  end

  #Deletes the instanced contact from 'contacts' database
  def destroy
    Contact.connection.exec_params('DELETE FROM contacts WHERE id = $1;', [id])
  end
  #Everything below this is a class method. 
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
      
    # Creates a new contact then adds it to the 'contacts' database via the save instance method on line 25.
    def create(name, email)
      Contact.new(name, email)
    end
    
    # Find the Contact in the 'contacts' database with the matching id.
    def find(id)    
      results = self.connection.exec_params('SELECT * FROM contacts WHERE id = $1',[id])
      if results.ntuples > 0
        row = results[0]
        self.new(row['name'], row['email'], row['id'])
      end
      #Note: the code below works but is not what the question intended. 
      # results = results.map{|row| self.new(row['name'], row['email'], row['id'])}
    end
    
    #Finds the contact in the 'contacts' database with matching name.
    def search(name)
      results = self.connection.exec_params('SELECT * FROM contacts WHERE name LIKE $1 ORDER BY id',["%#{name}%"])
      results = results.map{|row| self.new(row['name'], row['email'], row['id'])}
    end

  end
end
