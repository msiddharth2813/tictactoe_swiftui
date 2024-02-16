//
//  Turn.swift
//  TicTaccToe
//
//  Created by siddharth on 2/12/24.
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
    func imageName(theme: Theme) -> String {
        switch self {
        case .cross:
            switch theme {
            case .avengers:
                return "IronMan"
            case .spiderMan:
                return "SpiderMan"
            case .fireWater:
                return "Fire"
            case .harryPotter:
                return "harryPotter"
            case .standard:
                return "X"
            }
     
        case .circle:
            switch theme {
            case .avengers:
                return "Thanos"
            case .spiderMan:
                return "Venom"
            case .fireWater:
                return "Water"
            case .harryPotter:
                return "Wand"
            case .standard:
                return "O"
            }
        }
    }
}
