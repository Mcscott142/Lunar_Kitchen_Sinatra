class Recipe
  attr_reader :id, :name, :description, :instructions, :ingredients
  def initialize(recipe)
    @id = recipe['id']
    @name = recipe['name']
    @description = recipe['description']
    @instructions = recipe['instructions']
    @ingredients = ingredients
  end

  def self.all
    connection = PG.connect(dbname: 'recipes')
    results = connection.exec('SELECT * FROM recipes')
    connection.close

    recipes = []
    results.each do |recipe|
      recipes << Recipe.new(recipe)
    end
    recipes
  end

  def self.find(id)
    connection = PG.connect(dbname: 'recipes')
    results = connection.exec_params('SELECT * FROM recipes WHERE id = $1 LIMIT 1', [id])
    connection.close

    Recipe.new(results.first)
  end

  def ingredients
    @ingredients ||= Ingredient.for_recipe(id)
  end
end



  # @ingredients = []

    # Ingredient.all.each do |ingredient|
    #   if self.id == ingredient.recipe_id
    #     @ingredients << ingredient
    #   end
    # end

    # @ingredients

    # if @ingredients.nil?
    #   @ingredients = Ingredient.for_recipe(id)
    # else
    #   @ingredients
    # end
# recipe = Recipe.find(109)
# recipe.ingredients {asdasdasd}




# recipe.ingredients
