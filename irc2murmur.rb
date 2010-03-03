require File.dirname(__FILE__) + '/lib/irc_bot'
bot= IrcBot.new "irc.freenode.net", "6667"
bot.set_nick "foobot"
bot.set_user "foobot", "Foo Bot"
bot.join_channel "#lisp"
obs = IrcObserver.new bot
bot.run
