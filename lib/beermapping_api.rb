class BeermappingApi
  def self.places_in(city)
    return [] if city.blank?
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week.from_now) { fetch_city(city) }
  end
  def self.fetch_city(city)
    url = "http://stark-oasis-9187.herokuapp.com/api/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end
end