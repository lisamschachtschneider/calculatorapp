//
//  ViewController.swift
//  Calculator
//
//  Created by Lisa Marie Schachtschneider on 4/11/16.
//  Copyright © 2016 LMS. All rights reserved.
//  CS193p 2015 (c) Stanford University - iTunes U Podcast

import UIKit

class ViewController: UIViewController
{
    
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    
    @IBAction func appendDigitToTitleAndDisplay(sender: UIButton) {
        // ! makes it NOT an optional,
        // By declaring the ! you unwrap the string in the optional and makes it revealed, otherwise if you printed digit when let digit=sender.currentTitle it would return digit=Optional("2") so by declaring it as a string with the symbolic ! it will only return the value of the string
        //  sender is the UIButton, so the currentTitle of the UIButton object which inherits from the UIButton class.
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            // ! makes it NOT an optional(string or double, or digit or boolean, an optional can be multiple things), 'by declaring the ! you unwrap the string in the optional and makes it revealed, otherwise if you printed display.text when display.text=display.text+digit it would return display.text= Optional("2") so by declaring it as a string with the symbolic ! it will only return the text'
            //  you only have to declare the ! when you haven't set a type
            display.text = display.text! + digit
        } else {
            // meaning whenAUserFirstTypesANumber
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    // initializing the operandStack (as a function) that will be an array that will be composed of doubles
    var operandStack = Array<Double>()
    
    // checks whichOperation is used
    @IBAction func whichOperation(sender: UIButton) {
        // we are always checking the currentTitle for the operation
        let whichOperation = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingANumber {
            // append the displayValue to the operandStack when enter is pressed
            enter()
        }
        
        switch whichOperation {
        case "✖️": performTheSelectedOperation { $0 * $1 }
        case "➗": performTheSelectedOperation { $1 / $0 }
        case "➕": performTheSelectedOperation { $0 + $1 }
        case "➖": performTheSelectedOperation { $1 - $0 }
        // case "√": performOperation{ sqrt($0)}
        default: break
        }
    }
    
    @IBAction func enter() {
        
        // nope userIsNotInTheMiddleOfTypingANumber
        userIsInTheMiddleOfTypingANumber = false
        
        // add the displayValue to the operandStack
        operandStack.append(displayValue)
        
        // print("operandStack = \(operandStack)")
    }
    
    func performTheSelectedOperation(operation:(Double, Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    var displayValue: Double {
        get {
            // ! unwraps the string and makes it revealed
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            // newValue is a built in method of swift it autoupdates the button value
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
        
    }
}

