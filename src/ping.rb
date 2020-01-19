require 'discordrb'
require 'json'

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



## main
TOKEN = get_token_from_config_file("../discord.conf")
begin
bot = Discordrb::Bot.new token: TOKEN
rescue
	say_error("discord bot object could not be created")
else
	bot.message(with_text: 'Ping!') do |event|
	  event.respond 'Pong!'
	  puts event
	end
	bot.run
end
