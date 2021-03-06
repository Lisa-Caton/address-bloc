require_relative '../models/address_book'

RSpec.describe AddressBook do

  let(:book) {AddressBook.new}
  #we create new instance of the AddressBook model and assign it to the variable named "book"
  #using the "let" syntax provided by RSpec.
  #This lets us use "book" in all our tests,
  #removing the duplication of having to instantiate a new "AddressBook" for each test.
  #commented out all "book = AddressBook.new"
  #let means the code runs only when called! -- over the instiante it method "before do"
  #video example in the classwork ass.
  #why let is the appropriate way to remove code duplication


  #we create a helper method named check_entry which consolidates the redundant code.
  #We can now pass in the particular name, number, and email address we want into 
  #this reusable helper method.
  def check_entry(entry, expected_name, expected_number, expected_email)
    expect(entry.name).to eq expected_name
    expect(entry.phone_number).to eq expected_number
    expect(entry.email).to eq expected_email
  end


  context "attributes" do
    it "responds to entries" do
      # book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "intitializes entries as an array" do
      # book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "intitializes entries as empty" do
      # book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end
  end

  context "#add_entry" do
    it "adds only one entry to the address book" do
      # book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      expect(book.entries.size).to eq(1)
    end

    it "adds the correct information to entries" do
      # book = AddressBook.new
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      new_entry = book.entries[0]

      expect(new_entry.name).to eq('Ada Lovelace')
      expect(new_entry.phone_number).to eq('010.012.1815')
      expect(new_entry.email).to eq('augusta.king@lovelace.com')
    end
  end

  context "#remove_entry" do
    it "removes an entry using an name, phone_number, and email address" do
      #create a new instance
      # book = AddressBook.new
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

  context "#demolish" do
    it "should removes all entries" do

      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
      book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

      book.demolish
      expect(book.entries.size).to eq(0)
    end 
  end

  context "#import_from_csv" do
    it "imports the correct number of entries" do

      book.import_from_csv("entries.csv")
      book_size = book.entries.size
      #remember "book" is saving as AddressBook.new
      #so we are referencing "AddressBook.entries" variable to get its size!
      #this varriable will be an array
      expect(book_size).to eq(5)
    end

    it "imports the 1st entry" do
    #we access the 1st entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries.csv")
      entry_one = book.entries[0]
    end

    it "imports the 2nd entry" do
    #we access the 2nd entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries.csv")
      entry_two = book.entries[1]
    end

    it "imports the 3rd entry" do
    #we access the 3nd entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries.csv")
      entry_three = book.entries[2]
    end

    it "imports the 4th entry" do
    #we access the 4th entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries.csv")
      entry_four = book.entries[3]
    end

    it "imports the 5th entry" do
    #we access the 5th entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries.csv")
      entry_five = book.entries[3]
    end
  end

  context "importing from entries_2.csv " do
    it "imports the correct number of entries" do

      book.import_from_csv("entries_2.csv")
      book_size = book.entries.size
      #remember "book" is saving as AddressBook.new
      #so we are referencing "AddressBook.entries" variable to get its size!
      #this varriable will be an array
      expect(book_size).to eq(3)
    end

    it "imports the 1st entry" do
    #we access the 1st entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries_2.csv")
      entry_one = book.entries[0]
    end

    it "imports the 2nd entry" do
    #we access the 2nd entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries_2.csv")
      entry_one = book.entries[1]
    end

    it "imports the 3rd entry" do
    #we access the 3rd entry in the array of entries that our "AddressBook" stores.

      book.import_from_csv("entries_2.csv")
      entry_one = book.entries[2]
    end
  end

  context "#binary_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.binary_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end
 
     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end
 
     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end
 
     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.binary_search("Billy")
       expect(entry).to be_nil
     end
  end

  context "#iterative_search" do
    it "searches AddressBook for a non-existent entry" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Dan")
      expect(entry).to be_nil
    end

    it "searches AddressBook for Bill" do
      book.import_from_csv("entries.csv")
      entry = book.iterative_search("Bill")
      expect(entry).to be_a Entry
      check_entry(entry, "Bill", "555-555-4854", "bill@blocmail.com")
    end

    it "searches AddressBook for Bob" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Bob")
       expect(entry).to be_a Entry
       check_entry(entry, "Bob", "555-555-5415", "bob@blocmail.com")
     end
 
     it "searches AddressBook for Joe" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Joe")
       expect(entry).to be_a Entry
       check_entry(entry, "Joe", "555-555-3660", "joe@blocmail.com")
     end
 
     it "searches AddressBook for Sally" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sally")
       expect(entry).to be_a Entry
       check_entry(entry, "Sally", "555-555-4646", "sally@blocmail.com")
     end
 
     it "searches AddressBook for Sussie" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Sussie")
       expect(entry).to be_a Entry
       check_entry(entry, "Sussie", "555-555-2036", "sussie@blocmail.com")
     end

     it "searches AddressBook for Billy" do
       book.import_from_csv("entries.csv")
       entry = book.iterative_search("Billy")
       expect(entry).to be_nil
     end
  end

end