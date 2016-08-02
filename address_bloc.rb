require_relative "controllers/menu_controller"

# Create a brand spankin' new MenuController when AddressBloc starts
menu = MenuController.new

# Use system clear to clear the command line
# never would have guessed that one
system "clear"
puts "Welcome to AddressBloc!"

# Call ya main man (main_menu) to display aforementioned food stuffs
menu.main_menu
