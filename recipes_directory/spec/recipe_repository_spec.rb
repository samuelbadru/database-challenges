require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('schema/recipes_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before do 
    reset_recipes_table
    @repo = RecipeRepository.new
  end

  it 'Gets the correct number of recipes' do
  recipes = @repo.list_all_recipes
  expect(recipes.length).to eq 3
  end


  it 'Gets the correct recipes' do
  recipes = @repo.list_all_recipes

  expect(recipes[0].id).to eq '1'
  expect(recipes[0].name).to eq 'Jollof rice'
  expect(recipes[0].avg_cooking_time).to eq '120'
  expect(recipes[0].rating).to eq '5'

  expect(recipes[-1].id).to eq '3'
  expect(recipes[-1].name).to eq 'Bubble tea'
  expect(recipes[-1].avg_cooking_time).to eq '10'
  expect(recipes[-1].rating).to eq '2'
  end


  it 'Gets specified recipe' do
  recipe2 = @repo.find_a_recipe(2)

  expect(recipe2.id).to eq '2'
  expect(recipe2.name).to eq 'Brownies'
  expect(recipe2.avg_cooking_time).to eq '60'
  expect(recipe2.rating).to eq '4'
  end
end