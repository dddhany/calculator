//
//  ViewController.swift
//  Calculator
//
//  Created by Dhany Basuki on 8/2/16.
//  Copyright © 2016 Dhany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypyingANumber = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypyingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypyingANumber = true
        }
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypyingANumber {
            enter()
        }
        switch operation {
        case "✖️": performOperation {$0 * $1}
        case "➗": performOperation {$1 / $0}
        case "➕": performOperation {$0 + $1}
        case "➖": performOperation {$1 - $0}
        case "✔️": performOperation { sqrt($0) }
            
        default: break
        }
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypyingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypyingANumber = false
        }
    }
}

