require 'active_record'
require_relative 'contact'


class ContactList
  
  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    host: 'localhost',
    dbname: 'contacts',
    user: 'development',
    password: 'development'
    )

  def initialize(input)
    @input = input
    case input     
      #runs the 'create' method in Contact class to add to contacts database'
      when 'new'
        puts 'Enter name: '
        name = STDIN.gets.chomp
        puts 'Enter email: '
        email = STDIN.gets.chomp
        new_contact = Contact.create(name: name, email: email)
        puts "#{name} has been added to the database."
    
      #runs the 'all' method in Contact class
      when 'list'
        puts Contact.all
     
      #runs the find method in Contact class.
      when 'show'   
        show = ARGV[1]
        if show
          contact = Contact.find(show)
          puts contact ? contact : "User #{show} was not found"
          # if contact
          #   puts contact
          # else
          #   puts "User #{show} was not found"
          # end
        else
          puts "You must enter an ID"
        end
      #runs the search method in Contact class
      when 'search'
        input = ARGV[1]
        if !input
          puts "You must enter a name to search for"
        else
          puts Contact.where("name like?", "%#{input}%")
        end  

      #Finds contact based on ID, then allows user to update name and email  
      when 'update'
        input = ARGV[1]
        if !input
          puts "You must enter an ID to update"
        else
          puts "Entry to update: "
          the_contact = Contact.find(input)
          if the_contact
            puts the_contact
            puts "Enter new first and last name"
            the_contact.name = STDIN.gets.chomp
            puts "Enter new email"
            the_contact.email = STDIN.gets.chomp
            # the_contact = Contact.find(input)
            # the_contact.name = new_name
            # the_contact.email = new_email
            puts "#{the_contact.name} has been updated"
            the_contact.save
          else
            puts "No such contact with ID: " + input.to_s
          end
        end

      #Finds contact based on ID, then allows user to delete contact from database via #destroy method. 
      when 'destroy'
        input = ARGV[1]
        if !input
         puts "You must enter an ID to destroy"
        else 
          the_contact = Contact.find(input)
          puts "Entry to destroy: " 
          puts the_contact
          puts "Are you sure? y/n"
          confirmation = STDIN.gets.chomp
            case confirmation
              when 'y' 
                puts "#{the_contact} has been deleted."
                the_contact.destroy
              else
              end
        end
      
      else puts 'Command not found'
    end
  end

#Shows available commands if user does not enter ARGV direction.
  unless ARGV[0]
  puts "Here is a list of available commands:
    new - Create a new contact
    list - list all contacts
    show - show a contact
    search - search all contacts"
    exit
  end


end

ContactList.new(ARGV[0])