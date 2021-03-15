class Movie < ActiveRecord::Base
  def self.all_ratings
        a = Array.new
        self.select("rating").uniq.each {|x| a.push(x.rating)}
        a.sort.uniq
  end
  def self.similar_movies id
    director = Movie.find(id).director
    return nil if director.nil?
    Movie.where(director: director)
  end
  def self.with_ratings(ratings_list)
    if ratings_list == nil
        self.all_ratings
    end
    self.where("rating": ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
    end
end
