//
//  Food.swift
//  Feastly-ios
//
//  Created by Pranav on 22/01/25.
//

import Foundation

struct Food : Identifiable,Codable {
    let id: Int
    let calories: Int
    let protein: Int
    let price: Double
    let carbs: Int
    let imageURL: String
    let description: String
    let name: String
}
