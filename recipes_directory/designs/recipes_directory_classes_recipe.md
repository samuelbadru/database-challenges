# {{recipes}} Model and Repository Classes Design Recipe

## 1. Design and create the Table

```
Table: recipes

Columns:
id | name | avg_cooking_time | rating
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- (file: schema/recipes_seeds.sql)

TRUNCATE TABLE recipes RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO recipes (name, avg_cooking_time, rating) VALUES 
('Jollof rice', 120, 5),
('Brownies', 60, 4),
('Bubble tea', 10, 2);

```

```bash
psql -h 127.0.0.1 recipes_directory < schema/recipes_seeds.sql
psql -h 127.0.0.1 recipes_directory_test < schema/recipes_seeds.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)
class Recipe
end

# Repository class
# (in lib/recipe_repository.rb)
class RecipeRepository
end
```

## 4. Implement the Model class

```ruby
# EXAMPLE
# Table name: recipes

# Model class
# (in lib/recipe.rb)

class Recipe
  attr_accessor :id, :name, :avg_cooking_time, :rating
end
```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: recipes

# Repository class
# (in lib/recipe_repository.rb)

class RecipeRepository
  # Selecting all records
  # No arguments
  def list_all_recipes
    # Executes the SQL query:
    # SELECT * FROM recipes;

    # Returns an array of Recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (interger)
  def find_a_recipe(id)
    # Executes the SQL query:
    # SELECT * FROM recipes WHERE id = $1;

    # Returns a single Recipe object.
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.


```ruby
# EXAMPLES

# Before hook
@repo = RecipeRepository.new



# 1
# Gets the correct number of recipes
recipes = @repo.list_all_recipes
recipes.length # => 3


# 2
# Gets the correct recipes
recipes = @repo.list_all_recipes

recipes[0].id # =>  1
recipes[0].name # =>  'Jollof rice'
recipes[0].avg_cooking_time # =>  120
recipes[0].rating # =>  5

recipes[-1].id # =>  3
recipes[-1].name # =>  'Bubble tea'
recipes[-1].avg_cooking_time # =>  10
recipes[-1].rating # =>  2

# 3
# Gets specified recipe
recipe2 = @repo.find_a_recipe(2)

recipe2.id # =>  2
recipe2.name # =>  'Brownies'
recipe2.avg_cooking_time # =>  60
recipe2.rating # =>  4

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/recipe_repository_spec.rb

def reset_recipes_table
  seed_sql = File.read('schema/recipes_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory_test' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before do 
    reset_recipes_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._