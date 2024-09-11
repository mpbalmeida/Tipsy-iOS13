//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        switch sender.currentTitle {
        case "10%":
            tenPctButton.isSelected = true
            tip = 0.10
            break
        case "20%":
            twentyPctButton.isSelected = true
            tip = 0.20
            break
        default:
            zeroPctButton.isSelected = true
            tip = 0.0
            break
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberOfPeople = Int(sender.value)
        splitNumberLabel.text = String(numberOfPeople)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            let tipCalc = 1.0 + tip
            let bill = Float(billTextField.text ?? "0.0") ?? 0.0
            
            let totalPerPerson = bill / Float(numberOfPeople) * Float(tipCalc)
           
            // Better to pass values and the other view know how to render it
            destinationVC.billTotal = String(format: "%.2f", totalPerPerson)
            destinationVC.settings = "Split between \(numberOfPeople) people, with \(String(format: "%.0f", tip * 100))% tip."
        }
    }
}

