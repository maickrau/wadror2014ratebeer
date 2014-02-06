module RatingAverage
  def average_rating
    if ratings.nil? or ratings.empty?
      return nil
    end
    return average_of_list(ratings)
  end
  def average_of_list(list)
    list.inject(0){ |sum, rating| sum+rating.score }.to_f/list.count
  end
end