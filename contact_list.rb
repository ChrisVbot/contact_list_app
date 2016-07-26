require_relative 'contact'

puts "Here is a list of available commands:
  new - Create a new contact
  list - list all contacts
  show - show a contact
  search - search all contacts"

@input = ARGV.first
# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList
  def initialize(input)
    @input = input
    input = gets.strip
    case input
      when 'new'
        #do something
      when 'list'
        #do something
      when 'show'
        #do something
      when 'search'
      else 
          'Command not found'
        end
        #do something
  end

    
  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end
