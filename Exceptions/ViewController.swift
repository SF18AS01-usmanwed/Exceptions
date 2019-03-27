//
//  ViewController.swift
//  Exceptions
//
//  Created by Ousmane Ouedraogo on 3/27/19.
//  Copyright © 2019 Ousmane Ouedraogo. All rights reserved.
//

import UIKit

enum SsError: Error {   //Error is a protocol.
    case missing;       //.text property of UITextField was nil
    case tooShort;      //less than 9 digits
    case tooLong;       //more than 9 digits
    case badCharacter;  //only digits are allowed
    case badNumber;     //unable to store the number in an Int
}

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func updateUI(_ string: String?) {
        do {
            let ss: Int = try convertStringToSS(string);
            label.text = String(format: "Thank you for ss %09d.", ss);
            textField.resignFirstResponder();
        }
            
        catch SsError.tooShort {
            label.text = "Too short, try again.";
        }
            
        catch SsError.tooLong {
            label.text = "Too long, try again.";
        }
            
        catch SsError.badCharacter {
            label.text = "Only digits are allowed, try again.";
        }
            
        catch SsError.missing {
            label.text = "The UITextField malfunctioned.";
        }
            
        catch SsError.badNumber {
            label.text = "Can't store \(string!) in an Int.";
        }
            
        catch {
            label.text = "Unexpected \(error)";
        }
    }
    
    func convertStringToSS(_ string: String?) throws -> Int {   //no longer returns an optional
        guard let string: String = string else {
            throw SsError.missing;
        }
        
        if string.count < 9 {
            throw SsError.tooShort;
        }
        
        if string.count > 9 {
            throw SsError.tooLong;
        }
        
        let digits: CharacterSet = .decimalDigits;
        let nonDigits: CharacterSet = digits.inverted;
        
        if string.rangeOfCharacter(from: nonDigits) != nil {
            //The string contains a character that is not a digit.
            throw SsError.badCharacter;
        }
        
        guard let ss: Int = Int(string) else {
            throw SsError.badNumber;
        }
        
        return ss;
    }


    @IBAction func editingChanged(_ sender: UITextField) {
        label.text = "";
    }
    
    
    @IBAction func returnKeyPressed(_ sender: UITextField) {
         updateUI(sender.text);
    }
}

