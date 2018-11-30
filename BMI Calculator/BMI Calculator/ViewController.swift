//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Thomas Guillaume on 20/11/2018.
//  Copyright © 2018 Thomas Guillaume. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var WeightUnit: UILabel!
    @IBOutlet weak var HeightUnit: UILabel!
    @IBOutlet weak var WeightValue: UITextField!
    @IBOutlet weak var HeightValue: UITextField!
    @IBOutlet weak var bmiValue: UILabel!
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func switchUnits(sender: UISwitch) {
        if switchButton.isOn {
            WeightUnit.text = "lb"
            HeightUnit.text = "in"
        } else {
            WeightUnit.text = "kg"
            HeightUnit.text = "cm"
        }
    }
    
    @IBAction func calculateBMI(sender: UIButton) {
        // Get the values from the text fields
        if !(WeightValue.text?.isEmpty)! && !(HeightValue.text?.isEmpty)! {
            let weightValue: Float? = Float(self.WeightValue.text!)
            let heightValue: Float? = Float(self.HeightValue.text!)
            
            if weightValue == nil || heightValue == nil {
                // Display an alert
                let alertController = UIAlertController(title: "Input error !", message: "Please enter a number.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(alertController, animated: true, completion: nil)
            } else if weightValue! <= 0 || heightValue! <= 0 {
                // Display an alert
                let alertController = UIAlertController(title: "Input error !", message: "Please enter a positive number.", preferredStyle: .alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                present(alertController, animated: true, completion: nil)            }
            else {
                // Calculate the BMI according to the units of weight and height selected by the user
                var bmi: Float
                bmi = 0
                
                do {
                    if switchButton.isOn {
                        bmi = try bmiImperial(weight: weightValue!, height: heightValue!)
                    } else {
                        bmi = try bmiSI(weight: weightValue!, height: heightValue!/100)
                    }
                    // Round the result to the tenths
                    bmi = round(bmi*10)/10
                } catch {
                    print("Error")
                }
                
                
                // Print the result of the BMI
                bmiValue.text = String(bmi)
                
                if bmi > 0 && bmi <= 18.4 {
                    result.text = "Under Weight"
                } else if bmi > 18.4 && bmi <= 25.0 {
                    result.text = "Normal Weight"
                } else if bmi > 25.0 && bmi <= 30.0 {
                    result.text = "Over Weight"
                } else if bmi > 30.0 {
                    result.text = "Obese"
                }
            }
        }
    }
    
    // Calculate the BMI with the SI units
    func bmiSI(weight: Float, height: Float) throws -> Float {
        return weight/(height*height)
    }
    
    // Calculate the BMI with the Imperial units
    func bmiImperial(weight: Float, height: Float) throws -> Float {
        return (weight/(height*height))*703
    }
}

