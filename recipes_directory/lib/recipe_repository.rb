require_relative 'recipe'

class RecipeRepository
  def list_all_recipes
    query = 'SELECT * FROM recipes'
    recipes = DatabaseConnection.exec_params(query, [])

    recipe_objects = []

    recipes.each do |recipe|
      record = Recipe.new
      record.id = recipe['id']
      record.name = recipe['name']
      record.avg_cooking_time = recipe['avg_cooking_time']
      record.rating = recipe['rating']
      recipe_objects << record
    end

    recipe_objects
  end

  def find_a_recipe(id)
    query = 'SELECT * FROM recipes WHERE id = $1'
    params = [id]
    recipe = DatabaseConnection.exec_params(query, params)

    record = Recipe.new
    record.id = recipe[0]['id']
    record.name = recipe[0]['name']
    record.avg_cooking_time = recipe[0]['avg_cooking_time']
    record.rating = recipe[0]['rating']

    record
  end
end