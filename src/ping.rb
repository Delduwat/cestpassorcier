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

#attachments ⇒ Array<Attachment> readonly
#author ⇒ Member, User (also: #user, #writer) readonly
#channel ⇒ Channel readonly
#content ⇒ String (also: #text, #to_s) readonly
#edited ⇒ true, false (also: #edited?) readonly
#edited_timestamp ⇒ Time (also: #edit_timestamp) readonly
#embeds ⇒ Array<Embed> readonly
#mention_everyone ⇒ true, false (also: #mention_everyone?, #mentions_everyone?) readonly
#mentions ⇒ Array<User> readonly
#nonce ⇒ String readonly
#pinned ⇒ true, false (also: #pinned?) readonly
#reactions ⇒ Hash<String => Reaction> readonly
#role_mentions ⇒ Array<Role> readonly
#timestamp ⇒ Time readonly
#tts ⇒ true, false (also: #tts?) readonly
#webhook_id ⇒ Integer? r
list_of_element = ["attachments","author","channel","content","edited","edit_timestamp","embeds","mention_everyone","mentions","nonce","pinned","reactions","role_mentions","timestamp","tts","webhook_id"]
## main
TOKEN = get_token_from_config_file("../discord.conf")
begin
bot = Discordrb::Bot.new token: TOKEN
rescue
	say_error("discord bot object could not be created")
else
	bot.message() do |event|
	  #event.respond 'Pong!'
	  puts ">>%s just said %s<<"%[event.author.username,event.content]
	  #puts JSON.pretty_generate(event.to_json())

	end
	bot.run
end
