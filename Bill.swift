//
//  Bill.swift
//  PreWork
//
//  Created by My Mac on 1/29/21.
//

import Foundation

//Bill class
class Bill {
    private var tipPercent : Double = 0.0;
    private var amt : Int = 0;
    private var bills : [Double]  = [0.0,0.0]
    private var value : String = ""
    private var person : Int = 0
    
    //initializers
    //default
    init() {
        
    }
    
    //paramterized
    init(tipPercent : Double) {
        self.tipPercent = tipPercent
    }
    
  
    //calculation of the tip and bill
    func calculate() -> [Double]{
        let value = updateAmount()
        
        let dValue = Double(value) ?? 0.00
        let tip = dValue * tipPercent
        var splitBill = 0.0
        
        //divides by the number of people
        if(person >= 0){
            splitBill = (dValue + tip)/Double(person+1)

        }
        
       //let totalBill = (dValue + tip)
        
        bills[0] = tip
        //bills[1] = totalBill
        bills[1] = splitBill

        return bills
    }
    
    //calculates the
    private func updateAmount() -> String{
        print("inAmount",amt)
        let amount = Double(amt/100) + Double(amt%100)/100

        value = String(amount)
        return String(amount)
    }
    
    // setters and getters
    func setPersonsAndCalc(person : Int) -> [Double]{
        self.person = person
        return calculate()
    }
    
    func updateAmt(amt : Int) -> String{
        self.amt = amt
        return updateAmount()
    }
    
    func setDatas(amt : Int, tipPercent : Double){
        self.tipPercent = tipPercent
        self.amt = amt
    }
    
    func getAmt() -> Int{
        return amt
    }
    
    func getValue() -> String{
        return value
    }
    
    func getBills () -> [Double]{
        return bills
    }
    
} //end of Bill class
