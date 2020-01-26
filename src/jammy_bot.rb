require 'discordrb'
require 'json'

load("wiki.rb")

# get_definition

def say_error(error_content)
	puts("[!] %s"%error_content.to_s)
end
# read from ../discord.conf to get token
def get_token_from_config_file(file_name)
	begin
		data = JSON.parse(open(file_name).read())
	rescue Errno::ENOENT
		say_error("File not found : %s"%file_name)
	rescue JSON::ParseError
		say_error("Not able to parse the file %s"%file_name)
	else
		return data["bot_token"]
	end
end


TOKEN = get_token_from_config_file("../discord.conf")
begin
bot = Discordrb::Bot.new token: TOKEN
rescue
	say_error("discord bot object could not be created")
else
	bot.message do |event|
		puts ">>%s just said %s<<"%[event.author.username,event.content]
		## jammy time
		if event.content.start_with?("!jammy")
			begin
			  	puts("get get_definition...")
			  	question = event.content.split(" ")[1]
			  	event.respond get_definition(question)
			  rescue
			end
		end
		## simple ping
		if event.content.start_with?("!hop")
			begin
			  	event.respond "I'm alive :)"
			  rescue
			end
		end
		## kill the bot
		if event.content ==="!kill"
			begin
			  	event.respond "ok, bye :)"
			  	exit(0)
			  rescue
			end
		end
	  
	end
	
	bot.run
end
