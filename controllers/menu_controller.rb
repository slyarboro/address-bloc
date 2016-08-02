# include AddressBook per usual
require_relative "../models/address_book"

class MenuController
  attr_accessor :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # Display the main menu options to command line
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - View Entry Number n"
    puts "3 - Create an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Exit"
    print "Enter your selection: "

    # Retrieve user input from command line with GETS
    selection = gets.to_i
    puts "You picked #{selection}"

    # Use case statement operator to determine proper response to user's input
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu

    when 2
      system "clear"
      view_entry_number
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
      # Terminate them termites (programs) using brexit(0)
      exit(0)
      # Use an else to catch invalid user input and prompt the user to retry their little hearts out
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  # Stub the rest of the methods called in main_menu
  # I don't want no stub, stub is a try in my repository
  def view_all_entries
    # Iterate through all entries in AddressBook using each
    @address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      # Call entry_submenu to display a submenu for each entry
      # submenu, each gets
      # subway(menu), eat fresh
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    # Clear the screen before displaying the create entry prompts
    system "clear"
    puts "New AddressBloc Entry"
    # Use print to prompt the user for each entry's attribute
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # Add a new entry to @address_book using add_entry
    @address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp

    match = @address_book.binary_search.name
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = @address_book.import_from_csv(file_name)
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def delete_entry(entry)
    @address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.empty = email if !email.empty?
    system "clear"

    puts "Updated entry: "
    puts entry
  end

  def entry_submenu(entry)
    # Display the submenu optionz
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # Chomp chomps (removes) any trailing whitespace from the gets-induced string-a-lings
    selection = gets.chomp

    case selection
      # When user asks to see next entry, our hands are tied
      # slash we can do nothing
      # henceforth, ze controller returns to view_all_entries
    when "n"
      # We will handle deleting and editing in another checkpoint... allegedly
    when "d"
      delete_entry(entry)
    when "e"
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entries_submenu(entry)
    end
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
    # when "n"
    #   system "clear"
    #   add_entry(entry)
    #   main_menu
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu
    when "e"
      edit_entry(entry)
      system "clear"
      main_menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end
end
