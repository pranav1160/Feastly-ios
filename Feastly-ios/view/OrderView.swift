import SwiftUI

struct OrderView: View {
    @EnvironmentObject var ovm: OrderViewModel
    
    var body: some View {
            NavigationStack {
                List(ovm.allOrders) { order in
                    HStack(alignment: .top, spacing: 16) {
                        AsyncImage(url: URL(string: order.imageURL)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            ProgressView()
                                .frame(width: 60, height: 60)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(order.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text("$\(order.price, specifier: "%.2f")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Order View 📝")
            }
        }
    }


struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        // Providing the OrderViewModel to the preview
        OrderView()
            .environmentObject(OrderViewModel())
    }
}
