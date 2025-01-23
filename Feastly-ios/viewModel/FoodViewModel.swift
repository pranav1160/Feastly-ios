//
//  FoodViewModel.swift
//  Feastly-ios
//
//  Created by Pranav on 22/01/25.
//

import Foundation

class FoodViewModel : ObservableObject {
    @Published var foods:[Food] = []
    @Published var selectedFood:Food?
    @Published var willShowDetail:Bool = false
    
        func fetchData() async {
            guard let url = URL(string: "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/appetizers") else {
                print("Invalid URL")
                return
            }
            
            do {
                let (data,_) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode([String: [Food]].self, from: data)
                DispatchQueue.main.async{
                    self.foods = decodedData["request"] ?? []
                }
                
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    
    
    // Sample Food for Testing
    let sample_food: Food = Food(
        id: 100,
        calories: 415,
        protein: 2,
        price: 8.29,
        carbs: 29,
        imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/jumbo-tater-tot.jpg",
        description: "I'm getting soooo hungry building this app...",
        name: "Fried Cheese Ravioli"
    )
    
}
