# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'
require 'open-uri'

# url = 'http://tmdb.lewagon.com/movie/top_rated?&page=1'
# movies = URI.open(url).read
# movie = JSON.parse(movies)
# movie_results = movie['results']
# movie_poster = 'http://image.tmdb.org/t/p/w500'

# movie_results.each do |film|
#   new_movie = Movie.create(
#     title: film['title'],
#     overview: film['overview'],
#     poster_url: movie_poster + film['poster_path'],
#     rating: film['vote_average']
#   )
#   puts "#{new_movie.title} has been created!"
# end

page = 0
api_key = 'b70a4e66fa7ace306c6e6a5d9f312faf'

5.times do
  page += 1
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{api_key}&language=en-US&page=#{page}"
  movies = URI.open(url, &:read)
  movie = JSON.parse(movies)
  movie_results = movie['results']
  movie_poster = 'https://image.tmdb.org/t/p/w500'
  movie_results.each do |film|
    new_movie = Movie.create(
      title: film['title'],
      overview: film['overview'],
      poster_url: movie_poster + film['poster_path'],
      rating: film['vote_average']
    )
    puts "#{new_movie.title} has been created!"
  end
end

puts "It was added #{Movie.count} movies"
