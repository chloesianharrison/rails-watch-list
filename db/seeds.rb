# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'Faker'

# 50.times do
#   Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Quote.most_interesting_man_in_the_world,
#     poster_url: "",
#     rating: rand(1..10)
#   )
# end


require 'json'
require "open-uri"

Bookmark.destroy_all
Movie.destroy_all

url = "https://tmdb.lewagon.com/movie/top_rated"

10.times do |i|
  movie_serialized = URI.open(url).read
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)["results"]
  movies.each do |movie|
    puts movie["original_title"]
    poster_url = "https://image.tmdb.org/t/p/original"
    Movie.create(
      title: movie["title"],
      overview: movie["overview"],
      poster_url: "#{poster_url}#{movie["backdrop_path"]}",
      rating: movie["vote_average"]
    )
  end
end
