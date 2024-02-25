//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by Siddharth on 10/15/23.
//

import SwiftUI

struct TicTacToeView: View {
    
    
    let themes = [Theme.standard.rawValue, Theme.spiderMan.rawValue, Theme.avengers.rawValue, Theme.harryPotter.rawValue, Theme.fireWater.rawValue]
    @State private var themeName = Theme.standard.rawValue
    @State private var mode = GameMode.botVsPlayer.rawValue
    let modes = [GameMode.twoPlayer.rawValue, GameMode.botVsPlayer.rawValue]
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var button1ImageName = "" 
    @State private var button2ImageName = ""
    @State private var button3ImageName = ""
    @State private var button4ImageName = ""
    @State private var button5ImageName = ""
    @State private var button6ImageName = ""
    @State private var button7ImageName = ""
    @State private var button8ImageName = ""
    @State private var button9ImageName = ""
    @State private var scale = 0.5
    @State var showText = true
    @State var currentTurn: Turn = .cross
    @State var currentTheme: Theme = .standard
    @State var currentMode: GameMode = .botVsPlayer
    @State var currentBackground = "StandardBackground"
    var gameEngine = TicTacToeGameEngine()
    
    func themeChanged(to value: String) {
        guard let theme = Theme(rawValue: value) else {
            return
        }
        switch theme {
        case .standard:
            currentBackground = "StandardBackground"
            currentTheme = .standard
            reset()
        case .avengers:
            currentTheme = .avengers
            currentBackground = "IronManBackground"
            reset()
        case .spiderMan:
            currentTheme = .spiderMan
            currentBackground = "SpidermanBackground"
            reset()
        case .fireWater:
            currentTheme = .fireWater
            currentBackground = "FireWaterBackground"
            reset()
        case .harryPotter:
            currentTheme = .harryPotter
            currentBackground = "HarryPotterBackground"
            reset()
        }
    }
    
    func modeChanged(to value: String) {
        guard let mode = GameMode(rawValue: value) else {
            return
        }
        switch mode {
        case .twoPlayer:
            currentMode = .twoPlayer
            reset()
        case .botVsPlayer:
            currentMode = .botVsPlayer
            reset()
        }
    }
    
    
    func performNextMove(buttonPos: Int) {
        func fillImage(buttonPos: Int) {
            if buttonPos == 1 {
                button1ImageName = button1ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button1ImageName
            } else if buttonPos == 2 {
                button2ImageName = button2ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button2ImageName
            }  else if buttonPos == 3 {
                button3ImageName = button3ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button3ImageName
            }  else if buttonPos == 4 {
                button4ImageName = button4ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button4ImageName
            }  else if buttonPos == 5 {
                button5ImageName = button5ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button5ImageName
            }  else if buttonPos == 6 {
                button6ImageName = button6ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button6ImageName
            }  else if buttonPos == 7 {
                button7ImageName = button7ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button7ImageName
            }  else if buttonPos == 8 {
                button8ImageName = button8ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button8ImageName
            }  else if buttonPos == 9 {
                button9ImageName = button9ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button9ImageName
            }
        }
        switch currentMode {
        case .twoPlayer:
            fillImage(buttonPos: buttonPos)
            switch currentTurn {
            case .cross:
                currentTurn = .circle
            case .circle:
                currentTurn = .cross
            }
            let image = currentTurn.image(theme: currentTheme)
            fillImage(buttonPos: buttonPos)
            gameEngine.fillImage(buttonPos: buttonPos, image: image)
            
            let won = gameEngine.hasWon(image: image)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if won.win {
                    showAlert(buttonText: image.rawValue)
                } else if won.draw {
                    showAlert(buttonText: "")
                }
            }
            
        case .botVsPlayer:
            switch currentTurn {
            case .cross:
                let image = currentTurn.image(theme: currentTheme)
                fillImage(buttonPos: buttonPos)
                gameEngine.fillImage(buttonPos: buttonPos, image: image)
                
                let won = gameEngine.hasWon(image: image)
                if won.win {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showAlert(buttonText: image.rawValue)
                    }
                    return
                } else if won.draw {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showAlert(buttonText: "")
                    }
                    return
                }
                
                // determine bot's next move
                currentTurn = .circle
                let circleImage = Turn.circle.image(theme: currentTheme)
                // check if there is win move for circle
                var nextButtonPosition = gameEngine.nextMove(buttonPosition: buttonPos, image: circleImage)
                if nextButtonPosition == -1 {
                    // check if we need to block cross winning
                    let crossImage = Turn.cross.image(theme: currentTheme)
                    nextButtonPosition = gameEngine.nextMove(buttonPosition: buttonPos, image: crossImage)
                }
                // No position to block
                if nextButtonPosition == -1 {
                    // next free move.
                    nextButtonPosition = gameEngine.nextFreeMove(buttonPos: buttonPos)                }
                // check if there is win move for circle
                gameEngine.fillImage(buttonPos: nextButtonPosition, image: circleImage)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    fillImage(buttonPos: nextButtonPosition)
                    currentTurn = .cross
                    let won = gameEngine.hasWon(image: circleImage)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if won.win {
                            showAlert(buttonText: circleImage.rawValue)
                        } else if won.draw {
                            showAlert(buttonText: "")
                        }
                    }
                }
            case .circle:
                break
                //fillImage(buttonPos: buttonPos)
//                gameEngine.nextMove(buttonPosition: buttonPos)
            }
        }
    }
    
    func reset() {
        button1ImageName = ""
        button2ImageName = ""
        button3ImageName = ""
        button4ImageName = ""
        button5ImageName = ""
        button6ImageName = ""
        button7ImageName = ""
        button8ImageName = ""
        button9ImageName = ""
        alertTitle = "Game Reset"
        currentTurn = .cross
        gameEngine.reset()
    }
    
    func showAlert(buttonText: String) {
        if buttonText == Turn.cross.buttonText {
            alertTitle = "Crosses Win"
        } else if buttonText == Turn.circle.buttonText {
            alertTitle = "Circles Win"
        } else if buttonText == TicTacToeImage.ironman.rawValue {
            alertTitle = "Iron Man Won"
        } else if buttonText == TicTacToeImage.spiderMan.rawValue {
            alertTitle = "Spider Man Won"
        } else if buttonText == TicTacToeImage.fire.rawValue {
            alertTitle = "Fire Won"
        } else if buttonText == TicTacToeImage.thanos.rawValue {
            alertTitle = "Thanos Won"
        } else if buttonText == TicTacToeImage.water.rawValue {
            alertTitle = "Water Won"
        } else if buttonText == TicTacToeImage.wand.rawValue {
            alertTitle = "Wand Won"
        } else if buttonText == TicTacToeImage.venom.rawValue {
            alertTitle = "Venom Won"
        } else if buttonText == TicTacToeImage.harryPotter.rawValue {
            alertTitle = "Harry Won"
        } else {
            alertTitle = "Draw"
        }
        showAlert = true
    }
    
    var body: some View {
        GeometryReader { rect in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Image(currentBackground)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Menu {
                            Picker("Theme", selection: $themeName.onChange(themeChanged)) {
                                ForEach(themes, id: \.self) {
                                    Text($0)
                                }
                            }.pickerStyle(.menu)
                            Picker("Game Mode", selection: $mode.onChange(modeChanged)) {
                                ForEach(modes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            Button {
                            } label: {
                                Text("How It Works")
                            }
                            Button {
                            } label: {
                                Text("About")
                            }
                        } label : {
                            Spacer()
                            Label("", systemImage: "ellipsis.circle").padding()
                                .font(.system(size: 20, weight: .black, design: .serif))
                        }
                        Text("TicTacToe")
                            .font(.system(size: 60, weight: .black, design: .serif))
                            .foregroundColor(Color.white)
                        Button {
                            reset()
                        } label: {
                            Text("Reset")
                                .font(.system(size: 30, weight: .black, design: .serif))
                        }
                        Spacer()
                        Text("\(mode)")
                            .foregroundColor(Color.white)
                            .font(.system(size: 22, weight: .black, design: .serif))
                    }
                    .tint(Color.white)
                    .frame(height: (rect.size.height * 30) / 100) // 30% of the view
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Button {
                                performNextMove(buttonPos: 1)
                            } label: {
                                Image(button1ImageName)
                                    .opacity( button1ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .foregroundColor(Color.white)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeInOut, value: scale)
                            }
                            
                            Button {
                                performNextMove(buttonPos: 2)
                            } label: {
                                Image(button2ImageName)
                                    .opacity( button2ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                                
                            }
                            .overlay(alignment: .leading) {
                                Divider()
                                    .frame(maxWidth: 6, maxHeight: .infinity)
                                    .background(Color.white)
                            }
                            
                            Button {
                                performNextMove(buttonPos: 3)
                            } label: {
                                Image(button3ImageName)
                                    .opacity( button3ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                            }
                            .overlay(alignment: .leading) {
                                Divider()
                                    .frame(maxWidth: 6, maxHeight:.infinity)
                                    .background(Color.white)
                            }
                        }
                        HStack(spacing: 0) {
                            Button {
                                performNextMove(buttonPos: 4)
                            } label: {
                                Image(button4ImageName)
                                    .opacity(button4ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                            }
                            .overlay(alignment: .topTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.white)
                            }
                            .overlay(alignment: .bottomTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.white)
                            }
                            
                            Button {
                                performNextMove(buttonPos: 5)
                            } label: {
                                Image(button5ImageName)
                                    .opacity(button5ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                                
                            }
                            .overlay(alignment: .leading) {
                                Divider()
                                    .frame(maxWidth: 6, maxHeight:.infinity)
                                    .background(Color.white)
                            }
                            .overlay(alignment: .bottomTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.white)
                            }
                            .overlay(alignment: .topTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.white)
                            }
                            
                            Button {
                                performNextMove(buttonPos: 6)
                            } label: {
                                Image(button6ImageName)
                                    .opacity(button6ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                            }
                            .overlay(alignment: .leading) {
                                Divider()
                                    .frame(maxWidth: 6, maxHeight:.infinity)
                                    .background(Color.white)
                            }
                            .overlay(alignment: .bottomLeading ) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.white)
                            }
                            .overlay(alignment: .topTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.white)
                            }
                        }
                        HStack(spacing: 0) {
                            Button {
                                performNextMove(buttonPos: 7)
                            } label: {
                                Image(button7ImageName)
                                    .opacity(button7ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                            }
                            Button {
                                performNextMove(buttonPos: 8)
                            } label: {
                                Image(button8ImageName)
                                    .opacity(button8ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                                
                            }
                            .overlay(alignment: .leading) {
                                Divider()
                                    .frame(maxWidth: 6, maxHeight:.infinity)
                                    .background(Color.white)
                            }
                            Button {
                                performNextMove(buttonPos: 9)
                            } label: {
                                Image(button9ImageName)
                                    .opacity(button9ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                                // Border on left side of button
                            }
                            .overlay(alignment: .leading) {
                                Divider()
                                    .frame(maxWidth: 6, maxHeight:.infinity)
                                    .background(Color.white)
                            }
                        }
                    }// Top level vstack ending
                    .frame(height: (rect.size.height * 50) / 100) // 70% of the view
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text(alertTitle), message: Text("Good job play again"), dismissButton: .default(Text("reset"), action: {
                            reset()
                        }))
                    })
                    .padding(20)
                            
                        }
                    }
            }
        }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
  
