MAN_OPTIONS = ["mv", "cp", "mkdir", "ls", "rm", "cd", "pwd", "sudo", "open", "pico", "clear"]
SBL_SHORTCUTS = {
	"Duplicate a line" => "Cmd-Shift-D",
	"Indent a line Left or Right" => "Cmd-] or Cmd-[",
	"Move an entire line up or down" => "Cmd-Ctrl-Up or Cmd-Ctrl-Down",
	"Move cursor to the end of line" => "Cmd-ArrowLeft or Cmd-ArrowRight",
	"Comment out line (regardless of filetype)" => "Cmd-Slash( / )",
	"Enter a new line after current line" => "Cmd-Enter",
	"Enter a new line before current line" => "Cmd-Shift-Enter",
	"Select text with arrow keys" => "Hold Shift and use arrow keys",
	"Delete entire row where the cursor is" => "Ctrl-Shft-k",
	"Multiple Cursors" => "Hold Cmd and click in different spots",
	"Save as" => "Cmd-Shift-s",
	"Vertical Selection" => "hold down the alt key and drag for your vertical selection",
	"Same Word Selection" => "select a word, hold down cmd, press the ‘d’ key as many times as you want to select"
}

menu_options = ["1 Command Line", "2 Search", "3 View Sublime Shortcuts",
	  					  "4 Search Sublime Shortcuts", "5 Exit"]

@print_menu = -> {puts menu_options}

def menu
	puts "****CHEATSHEET****"
	@print_menu.call
	user_input = gets.chomp
	exit(0) if user_input == "5"
	user_input.to_i
end

def select_man(man_array)
	puts "****Type the number of the below item you would you like to see the man pages for"
	x = 1
	man_array.each do |option|
	  puts "#{x} #{option}"
	  x += 1
	end
	print ">"
	user_input = (gets.chomp.to_i - 1)
	if user_input >= 0
		MAN_OPTIONS.index(man_array[user_input])
	else
		puts "ERROR: I told you to type a number!!"
		main
	end
end

def search_man_options
	puts "****Type command you are looking for (beginning only searches accepted)"
	print ">"
	MAN_OPTIONS.grep(/^#{gets.chomp}/)
end

def display_page(command_index)
	puts "********This is the man page for #{MAN_OPTIONS[command_index]}********"
	puts `man #{MAN_OPTIONS[command_index]}`
	puts "********End of man page for #{MAN_OPTIONS[command_index]}********"
end

def select_shortcut
	puts "****Type the number of the action would you like to learn the shortcut for"
	x = 1
	SBL_SHORTCUTS.each do |key, value|
		puts "#{x} #{key}"
		x += 1
	end
	print ">"
	user_input = gets.chomp.to_i
	if user_input > 0
		user_input - 1
	else
		puts "ERROR: I told you to type a number!!"
		main
	end
end

def main
	while true
		case menu
			when 1
				selection = select_man(MAN_OPTIONS)
				display_page(selection)
			when 2
				search_results = search_man_options
				if search_results.length > 1
					puts "****Your search returned multiple results"
					puts "****Please select from the below list"
					selection = select_man(search_results)
				else
					selection = MAN_OPTIONS.index(search_results.join)
				end
				display_page(selection)
			when 3
				user_input = select_shortcut
				key_selection = SBL_SHORTCUTS.keys[user_input]
				value_selection = SBL_SHORTCUTS.values[user_input]
				puts "\nThe shortcut for '#{key_selection}' is:"
				puts value_selection, "\n"
			when 4
				puts "****Type action you are looking for (beginning only searches accepted)"
				search_results = SBL_SHORTCUTS.keys.grep(/^#{gets.chomp}/)
				x = 1
				if search_results.empty?
					puts "\n****No results found. Did you capitalize the first letter?", "\n"
				elsif search_results.length > 1
					puts "****Your search returned multiple results"
					puts "****Please select from the below list"
					search_results.each do |key|
						puts "#{x} #{key}"
						x += 1
					end
					user_input = gets.chomp.to_i - 1
					if user_input >= 0 
						selection = search_results[user_input]
					else
						puts "ERROR: I told you to type a number!"
						main
					end
				else
					selection = search_results.join
				end
				puts "\n****The shortcut for '#{selection}' is:"
				puts SBL_SHORTCUTS[selection], "\n"
			else
				puts "I don't recognize that command, please try again"
		end
	end
end

main
