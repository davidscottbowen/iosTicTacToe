//
//  GameBoardViewController.swift
//  TicTacToe
//
//  Created by David  Bowen on 10/17/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        performSegue(withIdentifier: "GameOver", sender: self)
        setupBoard()
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
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
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
