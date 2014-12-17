//
//  ViewController.swift
//  tips
//
//  Created by Jasdev Singh on 12/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var billAmountField: UITextField!
  @IBOutlet weak var tipPercentage: UISegmentedControl!
  @IBOutlet weak var totalTextLabel: UILabel!
  @IBOutlet weak var tipTextLabel: UILabel!
  @IBOutlet weak var separator: UIView!

  let defaults = NSUserDefaults.standardUserDefaults()
  let darkBlue = UIColor(red: 21 / 255.0, green: 146 / 255.0, blue: 204 / 255.0, alpha: 1)
  var formatter: NSNumberFormatter? = nil
  var percentages: [Double?] = [0.18, 0.2, 0.22, nil]


  override func viewDidLoad() {
    super.viewDidLoad()
    billAmountField.becomeFirstResponder()

    formatter = initFormatter()
    billAmountField.placeholder = formatter!.currencySymbol
    tipLabel.text = "\(formatter!.stringFromNumber(NSNumber(double: 0.0))!)"
    totalLabel.text = "\(formatter!.stringFromNumber(NSNumber(double: 0.0))!)"
  }
  
  override func viewDidAppear(animated: Bool) {
    let customTip = defaults.integerForKey("custom_tip")
    
    if customTip != 0 {
      percentages.insert(Double(customTip) / 100, atIndex: 3)
      tipPercentage.setTitle("\(customTip)%", forSegmentAtIndex: 3)
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    var primaryColor, secondaryColor: UIColor
    
    if defaults.boolForKey("dark_theme") {
      primaryColor = darkBlue
      secondaryColor = UIColor.whiteColor()
    } else {
      primaryColor = UIColor.whiteColor()
      secondaryColor = darkBlue
    }
    
    self.view.backgroundColor = primaryColor
    tipLabel.textColor = secondaryColor
    totalLabel.textColor = secondaryColor
    tipTextLabel.textColor = secondaryColor
    totalTextLabel.textColor = secondaryColor
    tipPercentage.tintColor = secondaryColor
    billAmountField.textColor = secondaryColor
    separator.backgroundColor = secondaryColor
  }
  
  @IBAction func onEditingChanged(sender: AnyObject) { updateBillAndTotal() }
  @IBAction func tappedOutside(sender: UITapGestureRecognizer) { billAmountField.resignFirstResponder() }
  
  func updateBillAndTotal() {
    let billAmount = (billAmountField.text as NSString).doubleValue
    
    if let percentage = percentages[tipPercentage.selectedSegmentIndex] {
      let tip = billAmount * percentage
      
      tipLabel.text = "\(formatter!.stringFromNumber(NSNumber(double: tip))!)"
      totalLabel.text = "\(formatter!.stringFromNumber(NSNumber(double: billAmount + tip))!)"
    } else {
      self.performSegueWithIdentifier("settingsSegue", sender: self)
    }
  }
  
  func initFormatter() -> NSNumberFormatter {
    let formatter = NSNumberFormatter()
    
    formatter.groupingSize = 3
    formatter.decimalSeparator = "."
    formatter.groupingSeparator = ","
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .CurrencyStyle
    formatter.locale = NSLocale.currentLocale()
    
    return formatter
  }
}

