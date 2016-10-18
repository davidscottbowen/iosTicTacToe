//
//  SettingsViewController.swift
//  TicTacToe
//
//  Created by David  Bowen on 10/18/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
   
    @IBOutlet weak var xRedSlider: UISlider!
    
    @IBOutlet weak var xGreenSlider: UISlider!
    
    @IBOutlet weak var xBlueSlider: UISlider!
    @IBOutlet weak var oRedSlider: UISlider!
    
    @IBOutlet weak var oBlueSlider: UISlider!
    
    @IBOutlet weak var oGreenSlider: UISlider!
    
    @IBOutlet weak var xColorView: UIView!
    
    @IBOutlet weak var oColorView: UIView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var colorData = defaults.data(forKey: xColorKey)
        if let colorData = colorData {
            xColorView.backgroundColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        } else {
            xColorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        colorData = defaults.data(forKey: oColorKey)
        if let colorData = colorData {
            oColorView.backgroundColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        } else {
            oColorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        let xColor = CIColor(color: xColorView.backgroundColor!)
        xRedSlider.value = Float(xColor.red)
        xGreenSlider.value = Float(xColor.green)
        xBlueSlider.value = Float(xColor.blue)
        
        let oColor = CIColor(color: oColorView.backgroundColor!)
        oRedSlider.value = Float(oColor.red)
        oGreenSlider.value = Float(oColor.green)
        oBlueSlider.value = Float(oColor.blue)
        
        xColorView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        xColorView.layer.borderWidth = 2
        xColorView.layer.cornerRadius = 4
        
        oColorView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        oColorView.layer.borderWidth = 2
        oColorView.layer.cornerRadius = 4
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        var colorData = NSKeyedArchiver.archivedData(withRootObject: xColorView.backgroundColor!)
        defaults.set(colorData, forKey: xColorKey)
        colorData = NSKeyedArchiver.archivedData(withRootObject: oColorView.backgroundColor!)
        defaults.set(colorData, forKey: oColorKey)
        defaults.synchronize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: IBActions
    
    @IBAction func xColorChanged(_ sender: AnyObject) {
               xColorView.backgroundColor = UIColor(red: CGFloat(xRedSlider.value), green: CGFloat(xGreenSlider.value), blue: CGFloat(xBlueSlider.value), alpha: 1.0)
 
    }
    
    
    @IBAction func oColorChanged(_ sender: AnyObject) {
         oColorView.backgroundColor = UIColor(red: CGFloat(oRedSlider.value), green: CGFloat(oGreenSlider.value), blue: CGFloat(oBlueSlider.value), alpha: 1.0)
    }
    
    
    @IBAction func resetGameStats(_ sender: AnyObject) {
        defaults.set(0, forKey: "xWins")
        defaults.set(0, forKey: "oWins")
        defaults.set(0, forKey: "draws")
        
    }
    
    
    

}
