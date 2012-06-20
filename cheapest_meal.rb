=begin

CheapestMeal is a class which determines which restaurant offers the cheapest
meal given a CSV file of restaurant menus and a customers desired food items
as script arguments.

To test the CheapestMeal class you can run this file (note the "main" section
of this script at the bottom of the page) by running:

ruby cheapest_meal.rb menus1.csv ham_sandwich burrito

=end

require_relative 'menu_parser'

class CheapestMeal
  def initialize
    @menu_hash = parse_menu()
    @food_items = parse_food_input()
  end
  
  def parse_menu
    # read and process the csv file
    parser = MenuParser.new
    csv_file_name = ARGV[0]
    parser.read_in_csv(csv_file_name)
    return parser.menu_hash
  end
  
  def parse_food_input
    # desired food items
    return ARGV.drop(1)
  end
  
  def find_cheapest_meal
    # hold running total
    minimum_meal_restaurant = nil
    minimum_meal_cost = Float::MAX

    # for each restaurant in the hash
    @menu_hash.each{ |restaurant, food_hash|

      # initialize a few variables
      meal_cost = 0 # running total
      combo_meal_hash = Hash.new() # hash holding combo meals seen before

      # for each desired food
      @food_items.each{ |food_item|

        food_attributes = food_hash[food_item]
        # check if the restaurant offers the food item
        if food_attributes != nil
          food_price, combo_meal = food_attributes

          # check if this food does not belong to a combo meal
          if combo_meal == nil
            # it does not, so add the price of this food to the running total,
            # meal_cost, at this restaurant
            meal_cost += food_price
          # check if the food is part of a combo meal i've seen before
          elsif combo_meal_hash[combo_meal] == nil
            # it is not, so add the price of this food to the running total,
            # meal_cost, at this restaurant
            meal_cost += food_price
            # and update the combo_meal_hash
            combo_meal_hash[combo_meal] = true
          else
            # this food WAS part of a combo meal i've seen before
            # so there is no need to update meal cost,
            # or update the combo_meal_hash
          end
          
        else
          # the restaurant does not offer this food item
          # set the meal cost to prohibitively high
          meal_cost = Float::MAX
        end
      }

      # update the minimum meal cost
      if meal_cost < minimum_meal_cost
        minimum_meal_cost = meal_cost
        minimum_meal_restaurant = restaurant
      end 
    }

    if minimum_meal_restaurant == nil
      puts nil
    else
      puts "#{minimum_meal_restaurant}, #{minimum_meal_cost}"
    end
    
  end
  
end


# "main" section of this program
program = CheapestMeal.new
program.find_cheapest_meal


