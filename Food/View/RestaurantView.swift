//
//  RestaurantView.swift
//  Food
//
//  Created by Norah Alfari on 01/06/1445 AH.
//

import SwiftUI

struct RestaurantView: View {
    @StateObject var vm = RestaurantViewModel()
    @StateObject var vm1 = MealViewModel()
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Restaurant")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView {
                    ForEach(vm.restaurnt) { restaurant in
                        NavigationLink(destination: MealView(restaurantId: restaurant.id)) {
                            HStack {
                                AsyncImage(url: restaurant.restaurantImage) { result in
                                    if let image = result.image {
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 8 * 12, height: 8 * 12)
                                    } else {
                                        ProgressView()
                                            .frame(width: 8 * 12, height: 8 * 12)
                                            .background(Circle())
                                            .tint(.white)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text(restaurant.restaurantName)
                                        .foregroundStyle(Color.black)
                                        .font(.title)
                                    Text(restaurant.restaurantDescription)
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                    Text("Delivery Time 15m")
                                        .font(.caption2)
                                        .foregroundStyle(Color.gray)
                                }
                            }.frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Divider()
                    }
                }
                
            }.padding()
            
        } 
        
    }
}

#Preview {
    RestaurantView()
}
