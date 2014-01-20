module RatingAverage
  def average_rating
    if ratings.nil? or ratings.empty?
      return nil
    end
    return ratings.inject(0){ |sum, rating| sum+rating.score }.to_f/ratings.count
  end
end