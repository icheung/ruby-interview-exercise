The files included in iris_solution.zip include:
	- cheapest_meal.rb (main program script)
	- menu_parser.rb (helper class for parsing CSV file)
	- menus1.csv
	- menus2.csv
	- menus3.csv
	- menus4_iris.csv
	- menus5_iris.csv
	- README.txt (this file)
	
System requirements:
	- This ruby script was tested on ruby 1.9.2

How to run the script:
> ruby cheapest_meal.rb <MENU.csv> <FOOD_ITEM1> <FOOD_ITEM2> ... (any number of food items)

Assumptions I made in my implementation:
- cheapest_meal.rb takes exactly 1 menu
- cheapest_meal.rb takes 1 or more food_items
- cheapest_meal.rb returns the first restaurant found with cheapest meal value in the event of a tie
- cheapest_meal.rb does not check for formatting correctness of the CSV file

-------------------------------------------------------------------------------
Results of testing the script on the provided example menus and inputs:

1) menus1.csv
------------
1, 4.00, ham_sandwich
1, 8.00, burrito
2, 5.00, ham_sandwich
2, 6.50, burrito

input
> ruby cheapest_meal.rb menus1.csv ham_sandwich burrito

expected output
=> 2, 11.5
---------------------------


2) menus2.csv
------------
3, 4.00, blt_sandwich
3, 8.00, chicken_wings
4, 5.00, chicken_wings
4, 2.50, coffee

input
> ruby cheapest_meal.rb menus2.csv blt_sandwich coffee

expected output
=> nil
---------------------------


3) menus3.csv
------------
5, 4.00, fish_sandwich
5, 8.00, milkshake
6, 5.00, milkshake
6, 6.00, fish_sandwich, blue_berry_muffin, chocolate_milk

input
> ruby cheapest_meal.rb menus3.csv milkshake fish_sandwich

expected output
=> 6, 11.0
---------------------------

4) menus4_iris.csv: Testing the expected output in the event of a tie.
My implementation assumes that the expected output is to return whichever
restaurant occurs earliest in the CSV file with the cheapest meal is returned.
In this case, restaurant 5 is returned.
------------
5, 4.00, fish_sandwich
5, 8.00, milkshake
5, 2.00, blue_berry_muffin
6, 5.00, milkshake
6, 6.00, fish_sandwich, blue_berry_muffin, chocolate_milk

input
> ruby cheapest_meal.rb menus4_iris.csv fish_sandwich blue_berry_muffin

expected output
=> 5, 6.0
---------------------------

5) menus5_iris.csv: Testing the expected output when restaurant IDs are not "in order".
My implementation does not rely on restaurant ID menu items to be ordered consecutively
or contiguously in the CSV file.  Thus, this case (which is the same case as case 3
above except the lines are changed to be out-of-order), restaurant 6 is returned.

------------
6, 6.00, fish_sandwich, blue_berry_muffin, chocolate_milk
5, 4.00, fish_sandwich
6, 5.00, milkshake
5, 8.00, milkshake

input
> ruby cheapest_meal.rb menus5_iris.csv milkshake fish_sandwich

expected output
=> 6, 11.0
---------------------------
