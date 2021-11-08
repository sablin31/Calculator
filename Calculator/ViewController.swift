//
//  ViewController.swift
//  Calculator
//
//  Created by Алексей Саблин on 26.10.2021.
//  Controller

import UIKit

class ViewController: UIViewController {
    
    var userIsInTheMiddleOfTyping = false
    
    var displayValue: Double? {
        get {
            if let text = display.text, let value = Double(text){
                return value
            }
            return nil
        }
        set {
            if let value = newValue {
                display.text = formatter.string(from: NSNumber(value: value))
            }
            if let discription = brain.description {
                history.text = discription + (brain.resultIsPending ? " ..." : " =")
            }
        }
    }
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    @IBOutlet weak var decimalSeparatorButton: UIButton!{
        didSet {
            decimalSeparatorButton.setTitle(decimalSeparator, for: UIControl.State())
        }
    }
    
    let decimalSeparator = formatter.decimalSeparator ?? "."
    
    @IBAction func touchDigit(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            if userIsInTheMiddleOfTyping {
                let currentDisplayDigit = display.text!
                if (digit != ".") || !(currentDisplayDigit.contains(".")) {
                    display.text = currentDisplayDigit + digit
                }
            }
            else {
                display.text = digit
                userIsInTheMiddleOfTyping = true
            }
        }
    }
    
    private var brain = CalculatorBrain()
    
    @IBAction func periformOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            if let value = displayValue {
                brain.setOperand(value)
            }
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        if let description = brain.description {
            history.text = description + (brain.resultIsPending ? " ..." : " =")
        }
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        brain.clear()
        displayValue = 0
        history.text = " "
    }
    
    @IBAction func backspace(_ sender: UIButton) {
        guard userIsInTheMiddleOfTyping && !display.text!.isEmpty else {return}
        display.text = String (display.text!.dropLast())
        if display.text!.isEmpty{
            displayValue = 0
        }
    }
}

