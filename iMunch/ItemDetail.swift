//
//  ItemDetail.swift
//  iMunch
//
//  Created by DEEPALI MAHESHWARI on 20/07/20.
//  Copyright © 2020 DEEPALI MAHESHWARI. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    var item : MenuItem
    @EnvironmentObject var order: Order
    @EnvironmentObject var favourite: Favourite
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .offset(x: -5, y: -5)
            }
            Text(item.description).padding()
            Button("Order This") {
                self.order.add(item: self.item)
            }.font(.headline)
            Spacer()
        }
        .navigationBarTitle(Text(item.name), displayMode: .inline)
//        .navigationBarItems(trailing: Button(action: {}, label: {
//            Image(systemName: "star")
//        }))
        
        
    }
    
}

struct ItemDetail_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        NavigationView {
            ItemDetail(item: MenuItem.example).environmentObject(order)
        }
        
    }
}
