require 'csv'
require_relative '../models/recipe'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = File.join(__dir__, csv_file_path)
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_csv
  end

  def remove_recipe(index)
    @recipes.delete_at(index)
    save_csv
  end

  def mark_as_done(index)
    @recipes[index].done = true
    save_csv
  end

  private

  def load_csv
    puts @csv_file_path
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      puts "helo"
      @recipes << Recipe.new(row)
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ["name", "description", "prep_time", "difficulty", "done"]
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.done]
      end
    end
  end
end
