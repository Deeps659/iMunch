//
//  Favourite.swift
//  iMunch
//
//  Created by DEEPALI MAHESHWARI on 21/07/20.
//  Copyright © 2020 DEEPALI MAHESHWARI. All rights reserved.
//

import SwiftUI

class Favourite: ObservableObject {
    @Published var favourites = [MenuItem]()
    var isSelected = false
    
    func add(_ item: MenuItem) {
        favourites.append(item)
    }
    
    func remove(_ item: MenuItem) {
        if let index = favourites.firstIndex(of: item) {
            favourites.remove(at: index)
        }
    }
    
}
