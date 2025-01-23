import SwiftUI

struct FoodDetailView: View {
    @EnvironmentObject var vm: FoodViewModel
    @EnvironmentObject var ovm: OrderViewModel
    let food: Food
    
    @State private var showPopup = false // State for popup visibility
    
    var body: some View {
        VStack {
            // Main Image with matchedGeometryEffect
            AsyncImage(url: URL(string: food.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(maxWidth: .infinity)
                case .failure:
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 215)
            
            // Food Details
            VStack {
                Text(food.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(food.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                HStack(spacing: 40) {
                    NutritionInfo(title: "Calories", value: "\(food.calories)")
                    NutritionInfo(title: "Carbs", value: "\(food.carbs) g")
                    NutritionInfo(title: "Protein", value: "\(food.protein) g")
                }
            }
            
            // Order Button
            Button {
                ovm.addOrder(food: food)
                showPopup = true // Show popup
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showPopup = false // Hide popup after 2 seconds
                }
            } label: {
                let Foodvalue = food.price
                let roundedString = String(format: "%.2f", Foodvalue)
                
                Text("Order $\(roundedString)")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Color.blue, Color.purple]),
                        startPoint: .leading,
                        endPoint: .trailing
                    ))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
            }
        }
        .frame(width: 320, height: 520)
        .background(Material.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 40)
        .overlay(
            Button {
                withAnimation(.spring()) {
                    vm.willShowDetail = false
                }
            } label: {
                ZStack {
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.black.opacity(0.2))
                        .opacity(0.6)
                    
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .foregroundStyle(.black)
                        .frame(width: 44, height: 44)
                }
            }, alignment: .topTrailing
        )
        .overlay(
            // Popup Notification
            Group {
                if showPopup {
                    VStack {
                        Text("✅ Added to Order")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                    }
                    .transition(.opacity.combined(with: .scale))
                }
            }
                .animation(.easeInOut, value: showPopup),
                alignment: .bottom // Align the popup to the bottom
        )
    }
}

// MARK: - NutritionInfo View
struct NutritionInfo: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .bold()
                .font(.caption)
            
            Text(value)
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
                .italic()
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create instances of FoodViewModel and OrderViewModel
        let vm = FoodViewModel()
        let ovm = OrderViewModel()
        
        // Ensure the FoodViewModel and OrderViewModel are provided to the FoodDetailView
        FoodDetailView(food: vm.sample_food)
            .environmentObject(vm)  // Pass the FoodViewModel to the environment
            .environmentObject(ovm) // Pass the OrderViewModel to the environment
            
    }
}
