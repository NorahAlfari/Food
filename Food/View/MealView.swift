//
//  MealView.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import SwiftUI

struct MealView: View {
   @StateObject var vm = MealViewModel()
   @State var isClicked: Bool = false
    var restaurantId: UUID
    @Environment(\.presentationMode) var presentationMode
   

    var body: some View {
        
        NavigationStack{
            VStack{
                Text("Meals")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView{
                    ForEach(vm.meal){ m in
                        if m.restaurant == restaurantId{
                            HStack{
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
                                        .font(.title2)
                                    Text("\(m.price) SR")
                                        .font(.caption)
                                        .foregroundStyle(Color.green)
                                }
                                
                                Spacer()
                                
                                  
                                Button {
                                    isClicked = true
                                    vm.updateData(id: m.id, isorder: isClicked)
                                   
                                } label: {
                                    Image(systemName: "cart.fill.badge.plus")
                                        .foregroundStyle(Color.orange)
                                }
                                .fullScreenCover(isPresented: $isClicked) {
                                    CartView(restaurantId: restaurantId)
                                }
                                
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                            Divider()
                        }
                           
                    }
                    .onAppear {
                              vm.fetch(restaurantId: restaurantId)
                          }
                }
            }.padding()
                
        }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Button(action: {
                // Handle back button action here
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.orange)
            })
            )
    }
}


#Preview {
   
    MealView(restaurantId: UUID())
}
