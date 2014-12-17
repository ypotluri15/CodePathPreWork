//
//  SettingsViewController.swift
//  tips
//
//  Created by Jasdev Singh on 12/14/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate {
  
  @IBOutlet weak var customTipPicker: UIPickerView!
  @IBOutlet weak var darkThemeToggle: UISwitch!
  @IBOutlet weak var customTipTextLabel: UILabel!
  @IBOutlet weak var darkThemeTextLabel: UILabel!
  
  let defaults = NSUserDefaults.standardUserDefaults()
  let darkBlue = UIColor(red: 21 / 255.0, green: 146 / 255.0, blue: 204 / 255.0, alpha: 1)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let customTip = defaults.integerForKey("custom_tip")
    
    if customTip != 0 {
      customTipPicker.selectRow(customTip - 1, inComponent: 0, animated: false)
    }
    
    darkThemeToggle.setOn(defaults.boolForKey("dark_theme"), animated: true)
  }
  
  override func viewWillAppear(animated: Bool) { toggleTheme() }
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return 100 }
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! { return "\(row + 1)%" }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    defaults.setInteger(row + 1, forKey: "custom_tip")
    defaults.synchronize()
  }
  
  @IBAction func switchTheme(sender: UISwitch) {
    defaults.setBool(!defaults.boolForKey("dark_theme"), forKey: "dark_theme")
    defaults.synchronize()
    
    toggleTheme()
  }
  
  func toggleTheme() {
    var primaryColor, secondaryColor: UIColor
    
    if defaults.boolForKey("dark_theme") {
      primaryColor = darkBlue
      secondaryColor = UIColor.whiteColor()
    } else {
      primaryColor = UIColor.whiteColor()
      secondaryColor = darkBlue
    }
    
    self.view.backgroundColor = primaryColor
    customTipTextLabel.textColor = secondaryColor
    darkThemeTextLabel.textColor = secondaryColor
  }
}
