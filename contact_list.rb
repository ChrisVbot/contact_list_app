require_relative 'contact'

unless ARGV[0] == true
puts "Here is a list of available commands:
  new - Create a new contact
  list - list all contacts
  show - show a contact
  search - search all contacts"
end

class ContactList
  def initialize(input)
    @input = input
    input = gets.strip
    case input
      when 'new'
        #runs the new method in Contact class to add to contacts.csv
        puts 'Enter name: '
        name = gets.chomp
        puts 'Enter email: '
        email = gets.chomp
        puts Contact.create(name, email)
        puts "#{name} has been added to the database."
      when 'list'
        #runs the all method in Contact class
        puts Contact.all
      when 'show'
        #runs the find method in Contact class
        puts 'Enter ID of contact to display: '
        id = gets.chomp.capitalize
        puts Contact.find(id)
      when 'search' 
        #runs the search method in Contact class
        puts "Enter search term: "
        s = gets.chomp
        puts Contact.search(s)
      else 
          'Command not found'
      end  
  end

    
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end
ContactList.new(ARGV.first)