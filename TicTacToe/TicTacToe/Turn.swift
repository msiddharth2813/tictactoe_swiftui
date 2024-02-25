//
//  Turn.swift
//  TicTacToe
//
//  Created by Siddharth on 2/12/24.
//

import Foundation

enum Turn {
    case cross
    case circle
    
    var buttonText: String {
        switch self {
        case .cross:
            return "X"
        case .circle:
            return "O"
        }
    }
    func image(theme: Theme) -> TicTacToeImage {
        switch self {
        case .cross:
            switch theme {
            case .avengers:
                return .ironman
            case .spiderMan:
                return .spiderMan
            case .fireWater:
                return .fire
            case .harryPotter:
                return .harryPotter
            case .standard:
                return .X
            }
     
        case .circle:
            switch theme {
            case .avengers:
                return .thanos
            case .spiderMan:
                return .venom
            case .fireWater:
                return .water
            case .harryPotter:
                return .wand
            case .standard:
                return .O
            }
        }
    }
    func imageName(theme: Theme) -> String {
        switch self {
        case .cross:
            switch theme {
            case .avengers:
                return TicTacToeImage.ironman.rawValue
            case .spiderMan:
                return TicTacToeImage.spiderMan.rawValue
            case .fireWater:
                return TicTacToeImage.fire.rawValue
            case .harryPotter:
                return TicTacToeImage.harryPotter.rawValue
            case .standard:
                return TicTacToeImage.X.rawValue
            }
     
        case .circle:
            switch theme {
            case .avengers:
                return TicTacToeImage.thanos.rawValue
            case .spiderMan:
                return TicTacToeImage.venom.rawValue
            case .fireWater:
                return TicTacToeImage.water.rawValue
            case .harryPotter:
                return TicTacToeImage.wand.rawValue
            case .standard:
                return TicTacToeImage.O.rawValue
            }
        }
    }
}
