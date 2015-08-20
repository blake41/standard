require 'rest-client'
require 'pry'
require 'pry-nav'
require_relative "check_price"
require_relative "mailer"
require 'dotenv'
Dotenv.load
URL = "https://standardaltproduction.tripcraft.com/api/general_availability.json?condense=1&user_email=blake41%40gmail.com&user_token="
TOKEN = "9cijXJ1dLfU_ahQrXd7a"
SUBJECT = "the standard prices on #{Date.today}"
class Runner

  def run
    price = CheckPrice.new(URL, TOKEN)
    price.get_data
    Mailer.new.send_to_distro(price.hotel_prices, SUBJECT)
  end

end

runner = Runner.new
runner.run




