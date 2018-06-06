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
    puts "6 - Demolish all entries!"
    puts "7 - Exit"
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
        system "clear"
        demolish
        main_menu
      when 7
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
    #get the name that the user wants to search for and store it in name
    print "Search by name: "
    name = gets.chomp

    #search on address_book which will either return a match or nil,
    #it will never return an empty string since import_from_csv
    #will fail if an entry does not have a name.
    match = address_book.binary_search(name)
    system "clear"

    #we check if search returned a match.
    #expression evaluates to false if  search returns nil since nil evaluates to false in Ruby
    if match
    #If search finds a match then we call a helper method called search_submenu
      puts match.to_s
      search_submenu(match)
      #search_submenu displays a list of operations that can be performed on an Entry
      #which will give the user the ability to delete or edit an entry and return to the main menu
    else
      puts "No match found for #{name}"
    end
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

      when "d"
        delete_entry(entry)
        #when a user is viewing the submenu and they press d, we call delete_entry
        #After the entry is deleted, control will return to view_all_entries and
        #the next entry will be displayed.

      when "e"
        edit_entry(entry)
        entry_submenu(entry)
        #we call edit_entry when a user presses e. We then display a sub-menu with
        #entry_submenu for the entry under edit.

      when "m"
        system "clear"
        main_menu
        #we return the user to the main menu

      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
    end
  end

  def read_csv
    #enter a name of a CSV file to import
    print "Enter CSV file to import: "
    file_name = gets.chomp
    #chomp method removes newlines

    if file_name.empty?
      #check to see if the file name is empty.
      #If it is then we return the user back to the main menu by calling main_menu.

      #clear the screen for before displaying the create entry prompts
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    #import the specified file with import_from_csv on address_book
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
      #clears the screen, and prints the # of entries that were read from the file
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
    read_csv
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
    #We remove entry from address_book and
    #print out a message to the user that says  entry has been removed
  end

  def edit_entry(entry)
    #perform a series of print statements
    print "Updated name: "
    name = gets.chomp
    #Each gets.chomp statement gathers user input and
    #assigns it to an appropriately named variable.

    print "Updated phone number: "
    phone_number =  gets.chomp

    print "Updated email: "
    email =  gets.chomp

    #use !attribute.empty? to set attributes on entry
    #only if a valid attribute was read from user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry: "
    puts entry
    #print out entry with the updated attributes
  end

  def search_submenu(entry)
    #print out the submenu for an entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m- return to main menu"

    selection = gets.chomp
    #save the user input to selection

    #use a case statement and take a specific action based on user input
    case selection

      #If input is d we call delete_entry and after it returns we call main_menu
      when "d"
        system "clear"
        delete_entry(entry)

      #If the input is e we call edit_entry
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu

      #m will return the user to the main menu
      when "m"
        system "clear"
        main_menu

      #does not match anything (see the else statement)
      #then we clear the screen
      #and ask for their input again by calling search_submenu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end


end

