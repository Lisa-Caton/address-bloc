require_relative '../models/address_book'
#1 include AddressBook using require_relative.

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  #2 display the main menu options to the command line
  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - View Entry Number"
    puts "3 - Create an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Exit"
    print "Enter your selection: "

    #3 retrieve user input from the command line using "gets"
    # "gets" reads the next line from standard input 
    selection = gets.to_i

    #use a case statement operator to determine the proper response
    #to the user's input.
    case selection
      when 1
        #use "system 'clear'" to clear the command line
        system "clear"
        view_all_entries
        main_menu
      when 2
        #use "system 'clear'" to clear the command line
        system "clear"
        view_entry_by_number
        main_menu
      when 3
        system "clear"
        create_entry
        main_menu
      when 4
        system "clear"
        search_entries
        main_menu
      when 5
        system "clear"
        read_csv
        main_menu
      when 6
        puts "Good-bye!"
        exit(0)
        #terminate the program using "exit(0)"
        #0 signals the program is exiting without an error

      #use an "else" to catch invalid user input
      #and prompt the user to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  #stub the rest of the methods called in "main_menu"
  def view_all_entries
    #iterate through all entries in AddressBook using "each"
    address_book.entries.each do |entry|
      #clear the screen for before displaying the create entry prompts
      system "clear"
      puts entry.to_s
      #we call "entry_submenu" to display a submenu for each entry
      #Let's add this method at the bottom of MenuController
      entry_submenu(entry)
    end
    system "clear"
    puts "End of entries"
  end

  def view_entry_by_number
    print "Please type an entry number, or 0 to return to main menu "
    selection = gets.chomp.to_i
    if selection == 0
      main_menu
    elsif selection < @address_book.entries.count
      #difference btw 'count' and 'length'
    p @address_book.entries[selection]
    else
      p "#{selection} is not a valid input"
      view_entry_by_number
    end
  end

  def create_entry
    #clear the screen for before displaying the create entry prompts
    system "clear"
    puts "New AddressBloc Entry"

    #use  "print" to prompt the user for each "Entry" attribute
    #"print" works just like "puts", except that it doesn't add a newline.
    #NAME
    print "Name: "
    name = gets.chomp
    #PHONE
    print "Phone number: "
    phone = gets.chomp
    #EMAIL
    print "Email: "
    email = gets.chomp

    #add a new entry to address_book using "add_entry"
    #to ensure that the new entry is added in the proper order.
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New Entry Created"
  end

  def search_entries
  end

  def read_csv
  end

  #display the submenu options
  def entry_submenu(entry)
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp
    #chomp removes any trailing whitespace from the string "gets" returns
    #This is necessary because "m " or "m\n" won't match  "m"

    case selection
      #when the user asks to see the *next entry*, aka "n"
      #we can do nothing and control will be returned to "view_all_entries"
      when "n"

      #we'll handle deleting and editing in another checkpoint,
      #for now the user will be shown the next entry
      when "d"
      when "e"

      #we return the user to the main menu.
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end


end

