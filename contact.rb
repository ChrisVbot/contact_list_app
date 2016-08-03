require 'pg'

# Represents a person in an address book.

class Contact < ActiveRecord::Base

  # attr_accessor :name, :email
  # attr_reader :id
  
  # #id=nil because we allow the database to create one for us when creating new contact. Otherwise ID is used to check if DB entry exists for that individual. 
  # def initialize(name, email, id=nil) 
  #   @name = name
  #   @email = email
  #   @id = id
  # end

  #Overrides default Ruby to_s method to display output as strings instead of SQL objects. 
  def to_s
    "#{id}: #{name} (#{email})"
  end

  # #Saves instanced contact into 'contacts' database. If contact already exists (verified by id), instead updates that contact's information. 
  # def save
  #   if id 
  #     Contact.connection.exec_params('UPDATE contacts SET name = $1, email = $2 WHERE id = $3;', [name, email, id])
  #   else
  #     Contact.connection.exec_params('INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id, name, email;',[name, email])
  #   end
  # end

  # #Deletes the contact from 'contacts' database
  # def destroy
  #   Contact.connection.exec_params('DELETE FROM contacts WHERE id = $1;', [id])
  # end

  # #Everything below this line is a class method. 
  # class << self
    
  #   def connection
  #     #|| will say 'only run if doesn't exist'
  #     @@conn ||= PG.connect(
  #       host: 'localhost',
  #       dbname: 'contacts',
  #       user: 'development',
  #       password: 'development'
  #       )
  #     #This does not need to be here:
  #     @@conn
  #   end


  #   #Dispays list of all contacts in the 'contacts' database. 
  #   def all
  #     results = self.connection.exec_params('SELECT * FROM contacts ORDER BY id')
  #     results.map{|row|  self.new(row['name'], row['email'], row['id'])}
  #   end
      
  #   # Creates a new contact then adds it to the 'contacts' database via the save instance method on line 25.
  #   # def create(name, email)
  #   #   contact = Contact.new(name, email)
  #   #   contact.save
  #   #   contact
  #   # end
    
  #   # Find the Contact in the 'contacts' database with the matching id and displays results via the result.ntuples function. This will allow only one row to popular in the output. 
  #   def find(id)    
  #     results = self.connection.exec_params('SELECT * FROM contacts WHERE id = $1',[id])
  #     if results.ntuples > 0
  #       row = results[0]
  #       self.new(row['name'], row['email'], row['id'])
  #     end
  #     #Note: the code below works but is not what the question intended as it allows for multiple rows. 
  #     # results = results.map{|row| self.new(row['name'], row['email'], row['id'])}
  #   end
    
  #   #Finds the contact in the 'contacts' database with matching name. If multiple matches, returns multiples (hence why not using results.ntuples method as on find(id) method).
  #   def search(name)
  #     results = self.connection.exec_params('SELECT * FROM contacts WHERE name LIKE $1 ORDER BY id',["%#{name}%"])
  #     results = results.map{|row| self.new(row['name'], row['email'], row['id'])}
  #   end

  # end
end
