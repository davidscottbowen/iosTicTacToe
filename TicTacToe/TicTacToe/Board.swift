//
//  Board.swift
//  TicTacToe
//
//  Created by David  Bowen on 10/17/16.
//  Copyright © 2016 Interapt. All rights reserved.
//

import UIKit

class Board: NSObject {
   fileprivate var board = [[Player.none, Player.none, Player.none],
                 [Player.none, Player.none, Player.none],
                 [Player.none, Player.none, Player.none]]
    
    var turns = 0
    let noMoreTurns = 9
    
    subscript(index: Int) -> Player? {
        get{
            if index < 9 {
                let indices = getIndices(index)
                return board[indices.row][indices.col]
            }
            return nil
        }
        set{
            if index < 9 {
                let indices = getIndices(index)
                board[indices.row][indices.col] = newValue!
                
                turns += 1
                
            }
        }
    }
    
    fileprivate func getIndices(_ index: Int) -> (row: Int, col: Int){
        return (row: index / 3, col: index % 3)
    }
    
    func resetBoard(){
        board = [[Player.none, Player.none, Player.none],
                 [Player.none, Player.none, Player.none],
                 [Player.none, Player.none, Player.none]]
        turns = 0
    }
    
    func checkWin(_ index: Int) -> Player {
        if index >= 9 {
            return .none
        }
        
        let indices = getIndices(index)
        
        // check row
        if board[indices.row][0] == board[indices.row][1] &&
            board[indices.row][0] == board[indices.row][2] {
            return self[index]!
        }
        
        // check column
        
        if board[0][indices.col] == board[1][indices.col] &&
            board[0][indices.col] == board[2][indices.col]{
            return self[index]!
        }
        
        // check diagonal if necessary∫
        
        if (indices.row + indices.col) % 2 == 0 {
            if board[1][1] != .none &&
            ((board[0][0] == board[1][1] && board[0][0] == board[2][2]) ||
                (board[0][2] == board[1][1] && board[0][2] == board[2][0])){
                return self[index]!
            }
            
        }
        
        // check if board is full
        
        if turns == noMoreTurns{
            return .draw
        }
        
        
        return .none
        
    }
}
