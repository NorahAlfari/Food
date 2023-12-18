//
//  OrderView.swift
//  Food
//
//  Created by Norah Alfari on 03/06/1445 AH.
//

import SwiftUI

struct OrderView: View {
    @StateObject var vm = OrderViewModel()
    @State var isClicked: Bool = false
    var body: some View {
        VStack{
            HStack{
//                Button {
//                    isClicked = true
//                    
//                } label: {
//                    Image(systemName: "chevron.left")
//                        .foregroundStyle(Color.orange)
//                }.fullScreenCover(isPresented: $isClicked) {
//                    ContentView()
//                }
                
                Text("Order")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView {
                ForEach(vm.order){order in
                    HStack{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 4, height: 120)
                            .foregroundStyle(Color.orange)
                        VStack(alignment: .leading){
                            Text("OrderNo:")
                                .bold()
                            Text("\(order.id)")
                            
                            Text("createdAt:")
                                .bold()
                            Text("\(order.createdAt)")
                            
                            Text("Total price:")
                                .bold()
                            Text("\(order.totalPrice)SR")
                                .foregroundStyle(Color.green)
                            
                            
                        }.font(.caption)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                }
            }
        }.padding()
    }
}

#Preview {
    OrderView()
}
