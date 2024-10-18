//
//  History.swift
//  CashFloat
//
//  Created by Manpreet Gulati on 17/10/24.
//

import Foundation
class History {
    
    var name: String = ""
    var price: Double = 0
    var quantity: String = ""
    
    init(name: String, price: Double, quantity: String) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

class HistoryTable {
    
    public static var shared: HistoryTable = .init()
    
    var history: [History] = []
    private init() {}
    func addHistory (_ history: History) {
        self.history.append(history)
    }
    
}
