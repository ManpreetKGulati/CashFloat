//
//  RestockViewController.swift
//  CashFloat
//
//  Created by Manpreet Gulati on 09/10/24.
//

import UIKit

class RestockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var quantityTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedProduct: Product?
    var selectedRow: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductManager.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        let product = ProductManager.shared.products[indexPath.row]
        cell.textLabel?.text = "\(product.name) - $\(String(format: "%.2f", product.price)) - Stock: \(product.quantity)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = ProductManager.shared.products[indexPath.row]
        // Optionally, show a message or highlight the selected product
    }
    
    @IBAction func restockButtonPressed(_ sender: UIButton) {
        guard let selectedProduct = selectedProduct,
              let newQuantityText = quantityTextField.text,
              let newQuantity = Int(newQuantityText) else {
            showAlert(message: "Please enter a valid quantity.")
            return
            
        }
        selectedProduct.quantity += newQuantity
        
        // Show success message
        showAlert(message: "Restocked \(newQuantity) of \(selectedProduct.name).")
        
        // Clear the text field after restocking
        quantityTextField.text = ""
        
        // Update the table view
        tableView.reloadData()
    }
        @IBAction func cancelButtonPressed(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
        }
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }

