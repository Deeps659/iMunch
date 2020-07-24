//
//  CheckoutView.swift
//  iMunch
//
//  Created by DEEPALI MAHESHWARI on 20/07/20.
//  Copyright © 2020 DEEPALI MAHESHWARI. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var order : Order
    static let paymentTypes = ["Cash", "Credit Card", "iMunch Points"]
    static let tipAmounts = [10, 15, 20, 25, 0]
    @State private var paymentType = 0
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 1
    @State private var showingPaymentAlert = false
    var totalPrice: Double {
        let total = Double(order.total)
        let tipValue = total / 100 * Double(Self.tipAmounts[tipAmount])
        return total + tipValue
    }
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) {
                    ForEach(Self.paymentTypes, id:\.self) {
                        Text($0)
                    }
                    
                }
                Toggle(isOn: $addLoyaltyDetails.animation()) {
                    Text("Add iDine loyalty card")
                }

                if addLoyaltyDetails {
                   TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
                
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(0 ..< Self.tipAmounts.count) {
                        Text("\(Self.tipAmounts[$0])%")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            Section(header:
                Text("TOTAL: $\(totalPrice, specifier:"%.2f")").font(.largeTitle)
            ) {
                Button("Confirm order") {
                    self.showingPaymentAlert.toggle()
                }
            }
        }.navigationBarTitle(Text("Payment"), displayMode: .inline)
        .navigationBarItems(leading: Button(action: {
          self.presentationMode.wrappedValue.dismiss()
        }, label: {
          HStack {
            Image(systemName: "square.and.pencil")
            Text("Order")
          }}
        ))
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was $\(totalPrice, specifier: "%.2f") – thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static let order = Order()
    static var previews: some View {
        CheckoutView().environmentObject(order)
    }
}

