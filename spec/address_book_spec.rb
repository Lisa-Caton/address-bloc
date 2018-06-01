require_relative '../models/address_book'

RSpec.describe AddressBook do
  describe "attributes" do
    it "responds to entries" do
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "intitializes entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "intitializes entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end
  end

  describe "#add_entry" do
    it "adds only one entry to the address book" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  describe "#remove_entry" do
    it "removes an entry using an name, phone_number, and email address" do
      #create a new instance
      book = AddressBook.new
      #add a single new entry into the address book using add_entry method, passing in the 3 values
      book.add_entry("Lee Smith", "411", "smith@gmail.com")
      
      #We want to add a second entry so that we have an entry to look for to delete
      #keep track of name, phone_number, and email address,
      #so we can pass those into the remove entry method
      name = 'Ada Lovelace'
      phone_number = '010.012.1815'
      email = 'augusta.king@lovelace.com'
      book.add_entry(name, phone_number, email)
      #add this into our address book using the add entry method
      #passing in the 3 variables


      #Expect:
      # 1. book is the new instance of an entry,
      # 2. entries is the array,
      # 3. size (alias for length) returns the # of elements in self*.
      expect(book.entries.size).to eq(2)
      # #1-expect to see that the entry size is 2, bc we have 2 entries in our address book
      # #2-expect to see 1 entry left in our book
      # #3-Final-expect looking at the item in our entry, and making sure that its name is the new name
      #this confirms the correct entry has been removed

      #then remove an entry, passing in the 3 variables
      #we will remove "Ada Lovelace"
      book.remove_entry(name, phone_number, email)
      expect(book.entries.size).to eq(1)

      #This confirms the correct entry has been removed
      expect(book.entries.first.name).to eq("Lee Smith")
      #Expect:
      # 1. book is the new instance of an entry,
      # 2. entries is the array,
      # 3. returns the first element of the array
      # 4. to equal, the new 

    end
  end
end