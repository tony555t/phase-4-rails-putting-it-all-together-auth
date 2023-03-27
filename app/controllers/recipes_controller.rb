class RecipesController < ApplicationController
    before_action :authorize

    # render all recipes with its user
      def index
        recipes = Recipe.all
        render json: recipes, include: { user: { except: [:created_at, :updated_at] } }
      end

    #   create a new recipe 
    def create
        recipe = Recipe.new(recipe_params)
        recipe.user_id = session[:user_id]
        if recipe.save
          render json: recipe, status: :created, include: { user: { except: [:created_at, :updated_at] } }
        else
          render json: { errors: ["not created"] }, status: :unprocessable_entity
        end
    end
      

    private
    
    def authorize
        return render json: { errors: ["Not authorized"] }, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
       params.permit(:title, :instructions, :minutes_to_complete)
    end
end