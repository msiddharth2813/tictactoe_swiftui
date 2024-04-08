//
//  View Extension.swift
//  TicTacToe
//
//  Created by Mani on 4/7/24.
//

import SwiftUI

extension View {
  
  func withConfetti(isVisible: Binding<Bool>) -> some View {
    ZStack {
      self
      ConfettiView(isVisible: isVisible)
      // Without this, you won't be able to interact with the underlying
      // view as the invisible ConfettiView will be covering it.
        .allowsHitTesting(false)
    }
  }
}
