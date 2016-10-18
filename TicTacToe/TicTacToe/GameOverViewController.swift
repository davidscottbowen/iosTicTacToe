//
//  GameOverViewController.swift
//  TicTacToe
//
//  Created by David  Bowen on 10/17/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var xWinLabel: UILabel!
    
    @IBOutlet weak var oWinLabel: UILabel!
    
    @IBOutlet weak var drawLabel: UILabel!
    
    
    
    
    
    var winner = Player.none

    override func viewDidLoad() {
        super.viewDidLoad()

       print("winner: \(winner)")
//        if winner == .Draw {
//            winerLabel.text = "Draw!"
//        }else{
//            winnerLabel.text = "\(winner) wins!"
//        }
//    }
        
        winnerLabel.text = "\(winner)\(winner != .draw ? " wins!" : "!")"
        
        let defaults = UserDefaults.standard
        var xWins = defaults.integer(forKey: "xWins")
        var oWins = defaults.integer(forKey: "oWins")
        var draws = defaults.integer(forKey: "draws")
        
        switch winner{
            
        case .x:
            xWins += 1
            defaults.set(xWins, forKey: "xWins")
        case .o:
            oWins += 1
            defaults.set(oWins, forKey: "oWins")
        case .draw:
            draws += 1
            defaults.set(draws, forKey: "draws")
        case .none:
            break
        }
        
        xWinLabel.text = "\(xWins)"
        oWinLabel.text = "\(oWins)"
        drawLabel.text = "\(draws)"
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

}
