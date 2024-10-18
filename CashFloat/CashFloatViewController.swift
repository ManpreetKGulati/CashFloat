//
//  CashFloatViewController.swift
//  CashFloat
//
//  Created by Manpreet Gulati on 09/10/24.
//

import UIKit

class CashFloatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalLabel: UILabel!
        
        @IBOutlet weak var tableView: UITableView!
        
        @IBOutlet weak var quantityLabel: UILabel!
        
        @IBOutlet weak var productLabel: UILabel!
        
        @IBOutlet weak var buyButton: UIButton!
        
        // Store products and stock quantities
    var selectedProduct: Product?
       var selectedQuantity: Int = 0
     
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
                tableView.dataSource = self
                tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            tableView.reloadData()
    }
  
    @IBAction func digitButtonPressed(_ sender: UIButton) {
           
           if let digit = sender.titleLabel?.text, let number = Int(digit) {
                      selectedQuantity = selectedQuantity * 10 + number
                      quantityLabel.text = "\(selectedQuantity)"
                      updateTotal()
                  }
       }
       
       @IBAction func buyButtonPressed(_ sender: UIButton) {
           
           guard let product = selectedProduct else { return }
                   
                   if selectedQuantity > product.quantity {
                       showAlert(message: "Not enough stock available")
                   } else {
                       // Update stock for the selected product
                       
                       let total = Double(selectedQuantity) * product.price
                               
                               // Add the transaction to history
                               let newHistory = History(name: product.name, price: total, quantity: "\(selectedQuantity)")
                               HistoryTable.shared.addHistory(newHistory)
                       product.quantity -= selectedQuantity
                  
                                
                       resetUI()
                       
                   }
       }
       
       // Update the total price label
           func updateTotal() {
               if let product = selectedProduct {
                           let total = Double(selectedQuantity) * product.price
                   totalLabel.text = String(format: "%.2f$", total)
                       }
           }
           
       // Reset the UI after a purchase
           func resetUI() {
               productLabel.text = "Type"
               quantityLabel.text = "0"
               totalLabel.text = "0$"
               selectedQuantity = 0
               selectedProduct = nil
               tableView.reloadData() // Update table in case stock changed
           }
       
       // Show an alert for invalid actions
           func showAlert(message: String) {
               let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default))
               present(alert, animated: true)
           }
           
           // TableView methods to show product list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return ProductManager.shared.products.count
           }
           
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
            
            // Clear any old subviews (if reusing)
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            // Get the product for the current row
            let product = ProductManager.shared.products[indexPath.row]
            
            // Product Name and Price Label (left-aligned)
            let productLabel = UILabel(frame: CGRect(x: 15, y: 0, width: cell.frame.width / 2, height: cell.frame.height))
        productLabel.text = "\(product.name) - $\(String(format: "%.2f", product.price))"
            productLabel.textColor = UIColor.black
            
            // Quantity Label (right-aligned)
            let quantityLabel = UILabel(frame: CGRect(x: cell.frame.width - 60, y: 0, width: 50, height: cell.frame.height))
            quantityLabel.text = "\(product.quantity)"
            quantityLabel.textAlignment = .right
            quantityLabel.textColor = UIColor.systemTeal
            
            // Add labels to the content view
            cell.contentView.addSubview(productLabel)
            cell.contentView.addSubview(quantityLabel)
            
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Set selected product based on the row
            selectedProduct = ProductManager.shared.products[indexPath.row]
            productLabel.text = selectedProduct?.name
            updateTotal()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


