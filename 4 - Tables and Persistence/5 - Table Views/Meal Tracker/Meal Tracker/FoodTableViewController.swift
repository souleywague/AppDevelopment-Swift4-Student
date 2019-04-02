//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Souley on 25/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {

    var meals: [Meal] {
        let breakfastFood = [Food(name: "Cereals", description: "Better to eat with milk."),
                            Food(name: "Eggs", description: "Excellent when well cooked."),
                            Food(name: "Orange juice", description: "Fills you with energy.")
                            ]
        let lunchFood = [Food(name: "Tuna sandwich", description: "Not very good and expensive."),
                         Food(name: "Water", description: "Good and free."),
                         Food(name: "Banana", description: "Excellent for the health.")]
        
        let dinnerFood = [Food(name: "Beafsteak", description: "Mmmmh meat!"),
                          Food(name: "Red wine", description: "Nothing better with meat."),
                          Food(name: "Cheese cake", description: "The cherry on top of the cake."),
                          Food(name: "Sex", description: "To spice the life.")]
        
        let breakfast = Meal(name: "Breakfast", food: breakfastFood)
        let lunch = Meal(name: "Lunch", food: lunchFood)
        let dinner = Meal(name: "Dinner", food: dinnerFood)
  
        return [breakfast, lunch, dinner]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meal = meals[section]
        return meal.food.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        
        let meal = meals[indexPath.section]
        let food = meal.food[indexPath.row]
        
        cell.textLabel?.text = "\(food.name)"
        cell.detailTextLabel?.text = "\(food.description)"

        return cell
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let meal = meals[section]
        return meal.name
    }
}
