require 'telegram/bot'
require 'dotenv/load'
require './load_files'



# Constants
TOKEN = ENV['TELEGRAM_TOKEN']
ADMIN_ID = ENV['ADMIN_ID']

# Start the bot
JanetBot.new.run
