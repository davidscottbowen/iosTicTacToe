//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by David  Bowen on 10/17/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit

let xColorKey = "xColor"
let oColorKey = "oColor"

class GameBoardViewController: UIViewController {
    @IBOutlet weak var Button0: UIButton!
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var Button5: UIButton!
    @IBOutlet weak var Button6: UIButton!
    @IBOutlet weak var Button7: UIButton!
    @IBOutlet weak var Button8: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    
    var playerTurn = Player.x
    
    var board = Board()
    var xColor: UIColor!
    var oColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        performSegue(withIdentifier: "GameOver", sender: self)
        setupBoard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        var colorData = userDefaults.data(forKey: xColorKey)
        if let colorData = colorData {
            xColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else {
            xColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        colorData = userDefaults.data(forKey: oColorKey)
        if let colorData = colorData {
            oColor = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor ?? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }else {
            oColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        
        
        setButtonColor(Button0, Button1, Button2, Button3, Button4, Button5, Button6, Button7, Button8)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GameOver" {
            let destVC = segue.destination as! GameOverViewController
            if let button = sender as? UIButton {
                destVC.winner = board.checkWin(button.tag)
            }
            setupBoard()
        }
    }
    
    fileprivate func setButtonColor(_ buttons: UIButton...){
        for button in buttons {
            if button.title(for: .normal) == Player.x.rawValue{
                button.setTitleColor(xColor, for: .normal)
            } else if button.title(for: .normal) == Player.o.rawValue{
                button.setTitleColor(oColor, for: .normal)
            }
        }
    }
    
    fileprivate func setupBoard(){
        playerTurn = .x
        turnLabel.text = "X's turn"
        
        Button0.setTitle("", for: .normal)
        Button1.setTitle("", for: .normal)
        Button2.setTitle("", for: .normal)
        Button3.setTitle("", for: .normal)
        Button4.setTitle("", for: .normal)
        Button5.setTitle("", for: .normal)
        Button6.setTitle("", for: .normal)
        Button7.setTitle("", for: .normal)
        Button8.setTitle("", for: .normal)
        
        board.resetBoard()
    }
    
    // MARK: - IBActions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        print(sender.tag)
        
        if let buttonPlayer = board[sender.tag], buttonPlayer == .none {
            board[sender.tag] = playerTurn
            
            sender.setTitle(playerTurn.takeTurn(), for: .normal)
            turnLabel.text = "\(playerTurn)'s Turn"
            
            let winner = board.checkWin(sender.tag)
            if winner != .none{
                print(winner)
                performSegue(withIdentifier: "GameOver", sender: sender)
            }
            setButtonColor(sender)
        }

    }

}

enum Player: String {
    case x
    case o
    case none
    case draw
    
    mutating func takeTurn() -> String {
        let string = "\(self)"
        switch self{
        case .x:
            self = .o
        case .o:
            self = .x
        default:
            break
        }
        
        return string
    }
}
