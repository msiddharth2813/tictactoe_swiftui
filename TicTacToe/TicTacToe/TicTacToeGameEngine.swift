//
//  TicTacToeGameEngine.swift
//  TicTacToe
//
//  Created by Siddharth on 2/18/24.
//

import Foundation
import UIKit

class TicTacToeGameEngine  {

    ///
    /// [0, 0], [0, 1], [0, 2]
    /// [1, 0], [1, 1], [1, 2]
    /// [2, 0], [2, 1], [2, 2]
    ///
    var positions: [[TicTacToeImage]] = [
        [TicTacToeImage.unnamed1, TicTacToeImage.unnamed2, TicTacToeImage.unnamed3],
        [TicTacToeImage.unnamed4, TicTacToeImage.unnamed5, TicTacToeImage.unnamed6],
        [TicTacToeImage.unnamed7, TicTacToeImage.unnamed8, TicTacToeImage.unnamed9]
    ]
    
    func reset() {
        positions = [
            [.unnamed1, .unnamed2, .unnamed3],
            [.unnamed4, .unnamed5, .unnamed6],
            [.unnamed7, .unnamed8, .unnamed9]
        ]
    }
    
    func fillImage(buttonPos: Int, image: TicTacToeImage) {
        let index = convertButtonPosToArrayIndex(position: buttonPos)
        positions[index.0][index.1] = image
    }
    
    func hasWon(image: TicTacToeImage) -> (win:Bool ,draw:Bool){
        if positions[0][0] == positions[0][1] &&  positions[0][1] == positions[0][2] && positions[0][0] == image {
            return (true, false)
        } else if positions[1][0] == positions[1][1] &&  positions[1][1] == positions[1][2] && positions[1][0] == image {
            return (true, false)
        } else if positions[2][0] == positions[2][1] &&  positions[2][1] == positions[2][2] && positions[2][0] == image {
            return (true, false)
        } else if positions[0][0] == positions[1][0] &&  positions[1][0] == positions[2][0] && positions[0][0] == image {
            return (true, false)
        } else if positions[0][1] == positions[1][1] &&  positions[1][1] == positions[2][1] && positions[0][1] == image {
            return (true, false)
        } else if positions[0][2] == positions[1][2] &&  positions[1][2] == positions[2][2] && positions[0][2] == image {
            return (true, false)
        } else if positions[0][2] == positions[1][1] &&  positions[1][1] == positions[2][0] && positions[2][0] == image {
            return (true, false)
        } else if positions[0][0] == positions[1][1] &&  positions[1][1] == positions[2][2] && positions[2][2] == image {
            return (true, false)
        } else {
            //checking for draw
            if positions[0][0] != .unnamed1 && positions[0][1] != TicTacToeImage.unnamed2 && positions[0][2] != TicTacToeImage.unnamed3 && positions[1][0] != .unnamed4 && positions[1][1] != TicTacToeImage.unnamed5 && positions[1][2] != TicTacToeImage.unnamed6 && positions[2][0] != .unnamed7 && positions[2][1] != TicTacToeImage.unnamed8 &&
                positions[2][2] != .unnamed9 {
                return (false, true)
            }
        }
        return (false, false)
    }

    
    
    func convertButtonPosToArrayIndex(position: Int) -> (Int, Int) {
        if position == 1 {
            return (0,0)
        } else if position == 2 {
            return (0,1)
        }  else if position == 3 {
            return (0,2)
        }  else if position == 4 {
            return (1,0)
        }  else if position == 5 {
            return (1,1)
        }  else if position == 6 {
            return (1,2)
        }  else if position == 7 {
            return (2,0)
        }  else if position == 8 {
            return (2,1)
        }  else if position == 9 {
            return (2,2)
        } else {
            return (0,0)
        }
    }
    
    func convertArrayIndexToButtonPosition(_ tuple: (Int, Int)) -> Int {
        if tuple.0 == 0 && tuple.1 == 0 {
            return 1
        } else if tuple.0 == 0 && tuple.1 == 1 {
            return 2
        }  else if tuple.0 == 0 && tuple.1 == 2 {
            return 3
        }  else if tuple.0 == 1 && tuple.1 == 0 {
            return 4
        }  else if tuple.0 == 1 && tuple.1 == 1 {
            return 5
        }  else if tuple.0 == 1 && tuple.1 == 2 {
            return 6
        }  else if tuple.0 == 2 && tuple.1 == 0 {
            return 7
        }  else if tuple.0 == 2 && tuple.1 == 1 {
            return 8
        }  else if tuple.0 == 2 && tuple.1 == 2 {
            return 9
        }
        return 1
    }
    
    func nextMove(buttonPosition: Int, image: TicTacToeImage) -> Int {
        // left to right
        if positions[0][0] == positions[0][1] && positions[0][0] == image {
            if positions[0][2] == TicTacToeImage.unnamed3 {
                return convertArrayIndexToButtonPosition((0, 2))
            }
        } else if positions[1][0] == positions[1][1] && positions[1][0] == image {
            if positions[1][2] == TicTacToeImage.unnamed6 {
                return convertArrayIndexToButtonPosition((1, 2))
            }
        } else if positions[2][0] == positions[2][1] && positions[2][0] == image {
            if positions[2][2] == TicTacToeImage.unnamed9 {
                return convertArrayIndexToButtonPosition((2, 2))
            }
        }
            
        // right to left
        
        if positions[0][2] == positions[0][1] && positions[0][2] == image {
            if positions[0][0] == TicTacToeImage.unnamed1 {
                return convertArrayIndexToButtonPosition((0, 0))
            }
        } else if positions[1][2] == positions[1][1] && positions[1][2] == image {
            if positions[1][0] == TicTacToeImage.unnamed4 {
                return convertArrayIndexToButtonPosition((1, 0))
            }
        }  else if positions[2][2] == positions[2][1] && positions[2][2] == image {
            if positions[2][0] == TicTacToeImage.unnamed7 {
                return convertArrayIndexToButtonPosition((2, 0))
            }
        }
        
        // top to bottom
        
        if positions[0][0] == positions[1][0] && positions[0][0] == image {
            if positions[2][0] == TicTacToeImage.unnamed7 {
                return convertArrayIndexToButtonPosition((2, 0))
            }
        } else if positions[0][1] == positions[1][1] && positions[0][1] == image {
            if positions[2][1] == TicTacToeImage.unnamed8 {
                return convertArrayIndexToButtonPosition((2, 1))
            }
        }  else if positions[0][2] == positions[1][2] && positions[0][2] == image {
            if positions[2][2] == TicTacToeImage.unnamed9 {
                return convertArrayIndexToButtonPosition((2, 2))
            }
        }
            
        // bottom to top

        if positions[2][0] == positions[1][0] && positions[2][0] == image {
            if positions[0][0] == TicTacToeImage.unnamed1 {
                return convertArrayIndexToButtonPosition((0, 0))
            }
        } else if positions[2][1] == positions[1][1] && positions[2][1] == image {
            if positions[0][1] == TicTacToeImage.unnamed2 {
                return convertArrayIndexToButtonPosition((0, 1))
            }
        }  else if positions[2][2] == positions[1][2] && positions[2][2] == image {
            if positions[0][2] == TicTacToeImage.unnamed3 {
                return convertArrayIndexToButtonPosition((0, 2))
            }
        }
        
        // diagonal top to bottom
            
        if positions[0][0] == positions[1][1] && positions[0][0] == image {
            if positions[2][2] == TicTacToeImage.unnamed9 {
                return convertArrayIndexToButtonPosition((2, 2))
            }
        } else if positions[0][2] == positions[1][1] && positions[0][2] == image {
            if positions[2][0] == TicTacToeImage.unnamed7 {
                return convertArrayIndexToButtonPosition((2, 0))
            }
        }
        
        // diagonal bottom to top

        if positions[2][0] == positions[1][1] && positions[2][0] == image {
            if positions[0][2] == TicTacToeImage.unnamed3 {
                return convertArrayIndexToButtonPosition((0, 2))
            }
        } else if positions[2][2] == positions[1][1] && positions[2][2] == image {
            if positions[0][0] == TicTacToeImage.unnamed1 {
                return convertArrayIndexToButtonPosition((0, 0))
            }
        }
        
        //middle cases
        if positions[0][0] == positions[0][2] && positions[0][0] == image {
            if positions[0][1] == TicTacToeImage.unnamed2 {
                return convertArrayIndexToButtonPosition((0, 1))
            }
        } else if positions[1][0] == positions[1][2] && positions[1][0] == image {
            if positions[1][1] == TicTacToeImage.unnamed5 {
                return convertArrayIndexToButtonPosition((1, 1))
            }
        } else if positions[2][0] == positions[2][2] && positions[2][0] == image {
            if positions[2][1] == TicTacToeImage.unnamed8 {
                return convertArrayIndexToButtonPosition((2, 1))
            }
        } else if positions[0][0] == positions[2][0] && positions[0][0] == image {
            if positions[1][0] == TicTacToeImage.unnamed4 {
                return convertArrayIndexToButtonPosition((1, 0))
            }
        } else if positions[0][1] == positions[2][1] && positions[0][1] == image {
            if positions[1][1] == TicTacToeImage.unnamed5 {
                return convertArrayIndexToButtonPosition((1, 1))
            }
        } else if positions[0][2] == positions[2][2] && positions[0][2] == image {
            if positions[1][2] == TicTacToeImage.unnamed6 {
                return convertArrayIndexToButtonPosition((1, 2))
            }
        }
        
        return -1
    }
    
    func nextFreeMove(buttonPos: Int) -> Int {
        var availablePos = [Int]()
        if positions[0][0] == TicTacToeImage.unnamed1 {
            availablePos.append(1)
        }
        if positions[0][1] == TicTacToeImage.unnamed2 {
            availablePos.append(2)
        }
        if positions[0][2] == TicTacToeImage.unnamed3 {
            availablePos.append(3)
        }
        if positions[1][0] == TicTacToeImage.unnamed4 {
            availablePos.append(4)
        }
        if positions[1][1] == TicTacToeImage.unnamed5 {
            availablePos.append(5)
        }
        if positions[1][2] == TicTacToeImage.unnamed6 {
            availablePos.append(6)
        }
        if positions[2][0] == TicTacToeImage.unnamed7 {
            availablePos.append(7)
        }
        if positions[2][1] == TicTacToeImage.unnamed8 {
            availablePos.append(8)
        }
        if positions[2][2] == TicTacToeImage.unnamed9 {
            availablePos.append(9)
        }
        return availablePos.randomElement() ?? 1
    }
}
