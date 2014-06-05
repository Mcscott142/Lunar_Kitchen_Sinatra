class Ingredient
  attr_reader :id, :name, :recipe_id

  def initialize(ingredient)
    @id = ingredient['id']
    @name = ingredient['name']
    @recipe_id = ingredient['recipe_id']
  end

  def self.for_recipe(recipe_id)
    connection = PG.connect(dbname: 'recipes')
    results = connection.exec_params('SELECT * FROM ingredients WHERE recipe_id = $1', [recipe_id])
    connection.close

    ingredients =[]
    results.each do |ingredient|
      ingredients << Ingredient.new(ingredient)
    end

    ingredients
  end
end

# def self.all
  #   connection = PG.connect(dbname: 'recipes')
  #   results = connection.exec('SELECT * FROM ingredients ORDER BY recipe_id')
  #   connection.close
  # end
