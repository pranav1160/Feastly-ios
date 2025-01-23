import SwiftUI

struct ListView: View {
    @EnvironmentObject var vm: FoodViewModel
    @EnvironmentObject var ovm:OrderViewModel
  
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    ForEach(vm.foods) { food in
                        FoodRow(food: food)
                            .onTapGesture {
                                withAnimation(.smooth) {
                                    vm.selectedFood = food
                                    vm.willShowDetail = true
                                }
                            }
                    }
                    .disabled(vm.willShowDetail)
                }
                .navigationTitle("🍕Feastly")
                .onAppear {
                    Task {
                        await vm.fetchData()
                    }
                }
                .blur(radius: vm.willShowDetail ? 20 : 0)
            }
            
            if vm.willShowDetail {
                FoodDetailView(food: vm.selectedFood!)
                    .environmentObject(ovm)
                // Pass namespace here
//                    .padding(.bottom, 100)
            }
        }
    }
}


struct FoodRow: View {
    let food: Food
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: food.imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(width: 100, height: 100) // Set image dimensions
                         // Clip image to avoid overflow
                case .failure:
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.red)
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(food.name)
                    .font(.headline)
                Text(food.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}


#Preview {
    ListView()
        .environmentObject(FoodViewModel())
        .environmentObject(OrderViewModel())
}
