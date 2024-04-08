//
//  AlertInfo.swift
//  TicTacToe
//
//  Created by Siddharth on 4/5/24.
//

import SwiftUI

struct AlertInfo: Identifiable {
    enum AlertType {
        case winLose
        case howToPlay
    }

    let id: AlertType
    let title: String
    let message: String
}

