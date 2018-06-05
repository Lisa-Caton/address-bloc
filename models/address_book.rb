#tells Ruby to load the library named entry.rb 
#relative to  address_book.rb's file path using require_relative
require_relative 'entry'
require 'csv'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end


  def add_entry(name, phone_number, email)
    #we create a variable to store the insertion "index"
    index = 0
    @entries.each do |entry|
      #we compare "name" with the name of the current "entry".
      #If "name" lexicographically proceeds "entry.name", we've found the "index" to insert at.
      #Otherwise we increment index and continue comparing with the other entries.
      if name < entry.name
        break
      end
      index +=1
    end
    #we insert a new entry into "entries" using the calculated index
    @entries.insert(index, Entry.new(name, phone_number, email))
  end

  def import_from_csv(file_name)
    #We defined "import_from_csv".
    #The method starts by reading the file, using "File.read"
    #The file will be in a CSV format.
    #We use the CSV class to parse the file.
    #The result of "CSV.parse" is an object of type "CSV::Table".
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    #we iterate over the CSV::Table object's rows. On the next line we create a hash for each row.
    #We convert each row_hash to an Entry by using the add_entry method which will also add the 
    #Entry to the AddressBook's entries.
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end


  #We want to iterate over every address in the address book
  #if we find an entry whose name, phone_number, and email address,
  #match the entry that we've passed in, then we want to delete that enty!
  def remove_entry(name, phone_number, email)
    #create a variable to hold the entries that we want deleted
    delete_entry = nil
    #iterate over, then find matching!
    @entries.each do |entry|
      if name == entry.name && phone_number == entry.phone_number && email == entry.email
      delete_entry = entry
      #we will assign that entry to the entry thats going to be deleted
      end
    end
    #at the end of the method we will delete the entry, from our entries array
    @entries.delete(delete_entry)
  end

  def binary_search(name)
    #we save the index of the leftmost item in the array in a variable named "lower"
    #we save the index of rightmost item in the array in "upper"
    #the leftmost item is the zeroth index
    #the rightmost item is the entries.length-1 index
    lower = 0
    upper = entries.length - 1

    while lower <= upper
      mid = (lower + upper) / 2
      #we find the middle index by taking the sum of lower and upper and dividing it by two
      mid_name = entries[mid].name
      #Then we retrieve the name of the entry at the middle index and store it in mid_name

      if name === mid_name
        #If name is equal to mid_name 
        #we've found the name we are looking for
        #so we return the entry at index mid.
        return entries[mid]

      elsif name < mid_name
        #If name is alphabetically before mid_name,
        #then we set upper to mid - 1
        #because the name must be in the lower half of the array.
        upper = mid - 1

      elsif name > mid_name
        #If name is alphabetically after mid_name,
        #then we set lower to mid + 1 because the
        #name must be in the upper half of the array.
        lower = mid + 1
      end
    end
    return nil
  end


end