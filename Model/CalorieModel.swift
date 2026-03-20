import Foundation
import SwiftData


// 4. Helper Enum
enum MealType: String, CaseIterable, Codable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snack = "Snack"
}


// The parent: Day
@Model
class Day {
    var date: Date
    
    var meals: [Meal] = []
    
    init(date: Date) {
        self.date = date
    }
}


// The middleman: meal
@Model
class Meal {
    var name: String // e.g. "Breakfast", "Lunch", "2AM Fridge Raid"
    var mealType: String
    
    // A meal belongs to a Day
    var day: Day?
    
    // A meal has many foodItems. Use cascade rule so if a user deletes a meal it deletes a foodItems inside it
    @Relationship(deleteRule:.cascade)
    var foodItems: [FoodItem] = []
    
    init(name: String, mealType: String) {
        self.name = name
        self.mealType = mealType
    }
    
}


@Model
class FoodItem {
    var name: String
    var calorie: Double
    var protein: Double
    var carb: Double
    var fat: Double
    
    // A FoodItem belongs to a Meal
    var meal: Meal?
    
    init(name: String, calorie: Double, protein: Double, carb: Double, fat: Double) {
        self.name = name
        self.calorie = calorie
        self.protein = protein
        self.carb = carb
        self.fat = fat
    }
}
