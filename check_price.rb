class CheckPrice
  HOTELS = [{:name => "East Village, NYC", :id => "21213"}, {:name => "High Line, NYC", :id => "27756"} ]

  attr_reader(:base_url, :json, :token)

  def initialize(base_url, token)
    @base_url = base_url
    @token = token
  end

  def get_data
    @json = JSON.parse(RestClient.get(url))
  end

  def hotel_prices
    HOTELS.collect do |hotel|
      {:name => hotel[:name], :price => hotel_price(hotel)}
    end.collect do |hotel|
      "the #{hotel[:name]} #{formatted_hotel_cost(hotel)}"
    end.join(" & ")
  end

private
  def price(hotel_id)
    json[hotel_id]["total_amount_after_tax"]
  end

  def hotel_price(hotel)
    hotel_unavailable?(hotel[:name]) ? "Sold Out" : price(hotel[:id])
  end

  def url
    "#{base_url}#{token}"
  end
  def formatted_hotel_cost(hotel)
    sold_out?(hotel) ? "is Sold Out" : formatted_cost(hotel)
  end

  def formatted_cost(hotel)
    "costs #{hotel[:price]} including taxes and fees\n"
  end

  def sold_out?(hotel)
    hotel[:price] == "Sold Out"
  end

  def hotel_unavailable?(hotel)
    !hotel_available?(hotel)
  end

  def hotel_available?(hotel)
    json["availability_summary"][hotel]["availability"]
  end

end