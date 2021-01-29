//
//  ViewController.swift
//  PreWork
//
//  Created by My Mac on 1/28/21.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    // variables connecting to views in the main storyboard
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var splitAmount: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var splitAmountLabel: UILabel!
    
    //SplitView
    @IBOutlet weak var addSplit: UIButton!
    @IBOutlet weak var splitLabel: UITextField!
    @IBOutlet weak var subSplit: UIButton!
    
    //Currency Button
    @IBOutlet weak var currencyBtn: UIButton!
    
    
    var b = Bill()
    
    //variables
    let tipPercent = [0.1,0.15,0.2,0.25]
    var onShow = false
    var amt : Int = 0
    var totalPerson : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmount.delegate = self
        billAmount.placeholder = "0.00"
        splitLabel.text = "0"
        
    }
    
    //function inside UITextFieldDelegate
    //On changing the value in the Textfield which is billAmount
    //The function tracks the changes in the billAmount textfield
    //and calculates the tip with the coressponding tip percentage
    //and adds it with bill to
    //produce the total bill
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //converts the string coming from textField to Integer
        if let digit = Int(string){
            amt = amt * 10 + digit
            let tPercent = tipPercent[tipControl.selectedSegmentIndex]
            b.setDatas(amt: amt, tipPercent: Double(tPercent))
            let bills = b.calculate()
            
            tipAmount.text = String(format: "$%.2f", bills[0])
            splitAmount.text = String(format: "$%.2f", bills[1])
            billAmount.text = b.getValue()
        }
        
        //backspace to delete the last number in the textField
        if string == ""{
            amt = amt/10
            let value = b.updateAmt(amt: amt)
            
            //updating textField bill Amount
            billAmount.text = value
            
            //recalculating the tip and total bill
            let bills = b.calculate()
            tipAmount.text = String(format: "$%.2f", bills[0])
            splitAmount.text = String(format: "$%.2f", bills[1])
            
        }
        return false
    }
   
    
    //caluclate the tip
    @IBAction func calculateTip(_ sender: Any) {
        let tPercent = tipPercent[tipControl.selectedSegmentIndex]
        
        b.setDatas(amt: amt, tipPercent: tPercent)
        let bills = b.calculate()
        
        tipAmount.text = String(format: "$%.2f", bills[0])
        splitAmount.text = String(format: "$%.2f", bills[1])
        
    }
    
    //to show numpad when app opens
    override func viewDidAppear(_ animated: Bool) {
        billAmount.becomeFirstResponder()
    }
   
    
    //to split bill
    //add a person
    @IBAction func addPerson(_ sender: Any) {
        totalPerson += 1;
        splitLabel.text = String(totalPerson)
        let bills = b.setPersonsAndCalc(person: totalPerson)
        splitAmountLabel.text = "Each Pay"
        
        tipAmount.text = String(format: "$%.2f", bills[0])
        splitAmount.text = String(format: "$%.2f", bills[1])
        
    }
    
    //remove a person
    @IBAction func removePerson(_ sender: Any) {
        if(totalPerson > 0){
            totalPerson -= 1;
            splitLabel.text = String(totalPerson)
            let bills = b.setPersonsAndCalc(person: totalPerson)
            tipAmount.text = String(format: "$%.2f", bills[0])
            splitAmount.text = String(format: "$%.2f", bills[1])

            if(totalPerson == 0){
                splitAmountLabel.text = "Total Bill"
                #imageLiteral(resourceName: "simulator_screenshot_70A84449-3A36-4B89-9C75-DACAA9F81B8F.png")
            }
        }
      
    }
    
}// end of viewController
