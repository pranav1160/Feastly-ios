import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                        
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }
            
            OrderView()
                .tabItem {
                    Label("Orders", systemImage: "cart.fill")
                }
        }
        .accentColor(.tabcolor) // Set accent color for tab icons
    }
}

#Preview {
    MainTabView()
        .environmentObject(FoodViewModel())
}
