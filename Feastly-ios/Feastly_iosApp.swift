//
//  Feastly_iosApp.swift
//  Feastly-ios
//
//  Created by Pranav on 22/01/25.
//

import SwiftUI

@main
struct Feastly_iosApp: App {
    @ObservedObject var foodViewModel:FoodViewModel = FoodViewModel()
    @ObservedObject var orderViewModel:OrderViewModel = OrderViewModel()
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(foodViewModel)
                .environmentObject(orderViewModel)
        }
    }
}
