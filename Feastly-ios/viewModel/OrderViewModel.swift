//
//  OrderViewModel.swift
//  Feastly-ios
//
//  Created by Pranav on 24/01/25.
//

import Foundation

class OrderViewModel : ObservableObject {
    @Published var allOrders:[Order] = []
    
    func addOrder(food:Food){
        let order:Order = Order(id: food.id, price: food.price, name: food.name, imageURL: food.imageURL)
        allOrders.append(order)
    }
}
