//
//  Product.swift
//  CashFloat
//
//  Created by Manpreet Gulati on 09/10/24.
//

import Foundation

class Product {
    
    var id: String = ""
    var name: String = ""
    var price: Double = 0
    var quantity: Int = 0
    
    init(id: String, name: String, price: Double, quantity: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

class ProductManager {
    
    public static var shared: ProductManager = .init()
    
    var products: [Product] = [
        Product(id: "P001", name: "Pants", price: 40.99, quantity: 20),
        Product(id: "P002", name: "Shoes", price: 119.00, quantity: 50),
        Product(id: "P003", name: "Hats", price: 50.99, quantity: 10),
        Product(id: "P004", name: "Dresses", price: 89.00, quantity: 24)
    ]
    
    func addProduct(_ product: Product) {
        self.products.append(product)
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll(where: { $0.id == product.id })
    }
}
