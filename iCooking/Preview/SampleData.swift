//
//  SampleRecipes.swift
//  iCooking
//
//  Created by 詹子昊 on 10/29/24.
//
import SwiftUI
import SwiftData

// Sample Data for Ingredient
let sampleIngredients: [Ingredient] = [
    Ingredient(name: "Tomato", image: "tomato"),
    Ingredient(name: "Onion", image: "onion"),
    Ingredient(name: "Garlic", image: "garlic"),
    Ingredient(name: "Basil", image: "basil"),
    Ingredient(name: "Olive Oil", image: "olive_oil")
]

// Sample Data for RecipeStep
let sampleSteps: [RecipeStep] = [
    RecipeStep(
        ingredients: [sampleIngredients[0], sampleIngredients[1]],
        description: "Chop tomatoes and onions",
        skills: ["Chopping"],
        tools: ["Knife", "Cutting Board"],
        duration: StepTime(value: 5, unit: .minute)
    ),
    RecipeStep(
        ingredients: [sampleIngredients[2], sampleIngredients[3]],
        description: "Crush garlic and basil",
        skills: ["Crushing"],
        tools: ["Mortar and Pestle"],
        duration: StepTime(value: 3, unit: .minute)
    )
]

// Sample Data for Recipe
let sampleRecipes: [Recipe] = [
    Recipe(
        name: "Tomato Basil Pasta",
        ingredients: sampleIngredients,
        steps: sampleSteps
    )
]

// Sample Data for FavoriteItem
let sampleFavoriteItems: [FavoriteItem] = [
    FavoriteItem(
        name: "My Favorite Recipes",
        recipes: sampleRecipes
    )
]
