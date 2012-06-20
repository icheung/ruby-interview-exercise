=begin

MenuParser is a class which parses a CSV file of restaurant menus.

The parsing occurs in the 'read_in_csv' function, where the CSV file is read 
in line-by-line and the data is stored in a hash of the following format:

{
  "restaurant_ID1"=>
    {
      "item1_name" => [item1_price, item1_combo_meal_ID],
      "item2_name" => [item2_price, item2_combo_meal_ID]
    },
  
  "restaurant_ID2"=>
    {
      "item3_name" => [item3_price, item3_combo_meal_ID],
      "item4_name" => [item4_price, item4_combo_meal_ID]
    }
}

The combo meal ID is an integer value used for identifying a line in a menu
that defines a combo meal.  I decided to assign combo menu ID's according to
the actual line number (zero-indexed) within the CSV file which the combo 
meal line is on. For example, given:
  0) fake_menu.csv
  ------------
  1, 1.00, sausage_biscuit hash_brown
  2, 3.29, big_mac
The items sausage_biscuit and hash_brown are assigned a combo meal ID of 0,
because they are on line number 0 in the file fake_menu.csv. The item big_mac
is assigned a combo meal ID of nil because it is not part of a combo meal.

Example: 
Given 
1) menus1.csv
------------
1, 4.00, ham_sandwich
1, 8.00, burrito
2, 5.00, ham_sandwich
2, 6.50, burrito

The hash generated would look like:
{
  "1"=>
    {
      "ham_sandwich" => [4.0, nil],
      "burrito" => [8.0, nil]
    },
  
  "2"=>
    {
      "ham_sandwich" => [5.0, nil],
      "burrito" => [6.5, nil]
    }
}

=end

require 'csv'

class MenuParser
  attr_reader :menu_hash
  
  def initialize
    @menu_hash = Hash.new()
  end
  
  def read_in_csv(csv_file_name)
    # initalize line number counter
    line_no = 0
    
    # read CSV file line by line
    CSV.foreach(csv_file_name) do |row|
      restaurant_id = row[0].strip()
      price = row[1].strip()
      food_items = row.drop(2)
      
      # set combo meal ID
      if food_items.length == 1
        combo_meal_id = nil
      else
        combo_meal_id = line_no
      end
      
      # create menu hash
      food_items.each{ |food_item|
        food_item = food_item.strip() 
        if @menu_hash[restaurant_id] == nil
          @menu_hash[restaurant_id] = { food_item => [price.to_f, combo_meal_id] }
        else
          @menu_hash[restaurant_id][food_item] = [price.to_f, combo_meal_id]
        end
      }
      
      # increment line number counter
      line_no+=1
    end
  end

end
  