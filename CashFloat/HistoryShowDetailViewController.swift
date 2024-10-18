//
//  HistoryShowDetailViewController.swift
//  CashFloat
//
//  Created by Manpreet Gulati on 09/10/24.
//

import UIKit

class HistoryShowDetailViewController: UIViewController {

    

    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var selectedIndex :  Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        
        nameLabel.text = HistoryTable.shared.history[selectedIndex].name
                quantityLabel.text = "Quantity: " + HistoryTable.shared.history[selectedIndex].quantity
                totalLabel.text = "Total: " + String(HistoryTable.shared.history[selectedIndex].price)
               
        // Do any additional setup after loading the view.
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
