require 'csv'

# Represents a person in an address book.

class Contact

  attr_accessor :name, :email
  
  # Creates a new contact object

  def initialize(name, email) 
    @name = name
    @email = email

  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    #Dispays list of all contacts in the contacts.csv file. 
    def all 
      all = CSV.foreach("contacts.csv").with_index do |row, line|
        puts [line, row].flatten.inspect
      end
      return all
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    def create(name, email)
      contact = Contact.new(name, email)
      CSV.open('contacts.csv', 'ab') do | csv |
        csv << [name, email]
      end
      contact
    end
    
    # Find the Contact in the 'contacts.csv' file with the matching id.
    def find(id)  
      CSV.foreach('contacts.csv', 'r').with_index do | row, line |
        csv = [line, row].flatten.inspect
        if csv.include?(id)
          return csv
        end
      end    
      
    end
    
    # Search for contacts by either name or email.
    def search(term) 
      CSV.foreach('contacts.csv', 'r').with_index do | row, line|
        csv = [line, row].flatten.inspect
        if csv.include?(term)
          return csv
        end
      end
    end

  end

end
