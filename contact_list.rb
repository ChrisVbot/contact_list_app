require_relative 'contact'


#Shows available commands if user does not enter ARGV direction.
unless ARGV[0]
puts "Here is a list of available commands:
  new - Create a new contact
  list - list all contacts
  show - show a contact
  search - search all contacts"
  exit
end

class ContactList
  def initialize(input)
    @input = input
    case input     
      #runs the 'create' method in Contact class to add to contacts.csv
      when 'new'
        puts 'Enter name: '
        name = STDIN.gets.chomp
        puts 'Enter email: '
        email = STDIN.gets.chomp
        puts Contact.create(name, email)
        puts "#{name} has been added to the database."
    
      #runs the all method in Contact class
      when 'list'
        puts Contact.all
     
      #runs the find method in Contact class
      when 'show'   
        show = ARGV[1]
        if !show
          puts "You must enter an ID"
        elsif 
         !Contact.find(show) 
          puts "User #{show} was not found"
        else
          puts Contact.find(show) 
        end
     
      #runs the search method in Contact class
      when 'search'
        search = ARGV[1]
        if !search
          puts "You must enter a search term"
        else
        puts Contact.search(search)
      end  
    end
  end
end

ContactList.new(ARGV[0])