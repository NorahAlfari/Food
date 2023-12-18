//
//  CartView.swift
//  Food
//
//  Created by Norah Alfari on 03/06/1445 AH.
//

import SwiftUI

struct CartView: View {
    @StateObject var vm = MealViewModel()
    @State var isClicked: Bool = true
    var restaurantId: UUID
    @State private var refreshToggle = false
    @State var  isPresed: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    var filter: [MealModel] {
        
        return vm.meal.filter { $0.isOrder == true }
    }
    
    var totalPrice: Int {
        return filter.reduce(0) { $0 + $1.price }
    }
    
    @StateObject var vm1 = OrderViewModel()
    
    func formatDateToString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.orange)
                    }
                    
                    Text("Cart")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        self.refreshToggle.toggle()
                        vm.fetch(restaurantId: restaurantId)
                        
                    } label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .foregroundStyle(Color.orange)
                    }
                    
                }
                ScrollView{
                    ForEach(filter){ m in
                        HStack{
                            if m.restaurant == restaurantId{
                                AsyncImage(url: m.mealImage) { reselt in
                                    
                                    if let image = reselt.image{
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 8 * 12 , height: 8 * 12)
                                    }else{
                                        ProgressView()
                                            .frame(width: 8 * 12 , height: 8 * 12)
                                            .background(Circle())
                                            .tint(.white)
                                    }
                                }
                                VStack(alignment: .leading){
                                    Text(m.mealname)
                                        .foregroundStyle(Color.black)
                                        .font(.title)
                                    Text("\(m.price) SR")
                                        .font(.caption)
                                        .foregroundStyle(Color.green)
                                }
                                Spacer()
                                
                                Button {
                                    isClicked.toggle()
                                    vm.updateData(id: m.id, isorder: isClicked)
                                    
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(Color.orange)
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    Divider()
                    
                    HStack{
                        Text("Total: \(totalPrice) SR")
                            .foregroundStyle(Color.orange)
                        
                        Spacer()
                        
                        
                            Button {
                                isPresed = true
                                vm1.addOrder(totalPrice: totalPrice, createdAt: formatDateToString(Date()))
                                
                            } label: {
                                Text("Order")
                                    .bold()
                                    .font(.title2)
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal)
                                    .background(
                                        RoundedRectangle(cornerRadius: 15)
                                            .foregroundStyle(Color.orange)
                                    )
                            } .fullScreenCover(isPresented: $isPresed) {
                                ContentView()
                            }
                        }
                }.onAppear {
                    vm.fetch(restaurantId: restaurantId)
                }
            }.padding()
            
        }
    }
}

#Preview {
    CartView(restaurantId: UUID())
}
