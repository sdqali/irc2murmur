require File.dirname(__FILE__) + '/lib/irc_bot'
bot= IrcBot.new "irc.freenode.net", "6667"
puts "Successfully created the bot......."
bot.set_nick "foobot"
bot.set_user "foobot", "Foo Bot"
bot.join_channel "#lisp"
obs = IrcObserver.new
obs.register bot
puts "irc2murmur now listening to the conversations....."
bot.run
