require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

DatabaseConnection.connect('recipes_directory')

repo = RecipeRepository.new
all_recipes = repo.list_all_recipes

all_recipes.each do |recipe|
  puts "#{recipe.id} - #{recipe.name} - #{recipe.avg_cooking_time} mins - #{recipe.rating} rating (1-5 scale)"
end