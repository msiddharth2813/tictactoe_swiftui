//
//  TicTacToeView.swift
//  TicTacToe
//
//  Created by siddharth on 10/15/23.
//

import SwiftUI

struct TicTacToeView: View {
    
    
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
                case .Avengers:
                    return "IronMan"
                case .SpiderMan:
                    return "SpiderMan"
                case .FireWater:
                    return "Fire"
                case .HarryPotter:
                    return "HarryPotter"
                case .standard:
                    return "X"
                }
         
            case .circle:
                switch theme {
                case .Avengers:
                    return "Thanos"
                case .SpiderMan:
                    return "Venom"
                case .FireWater:
                    return "Water"
                case .HarryPotter:
                    return "Wand"
                case .standard:
                    return "O"
                }
            }
        }
    }
    enum Theme {
        case standard
        case Avengers
        case SpiderMan
        case FireWater
        case HarryPotter
    }
    @State private var crossesScore = 0
    @State private var circleScore = 0
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
    @State var changeBackground = "StandardBackground"
    
    func toggleTurn() {
        switch currentTurn {
            
        case .cross:
            currentTurn = .circle
            
        case .circle:
            currentTurn = .cross
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
        alertTitle = ""
    }
    
    func checkWin() {
        func checkAlert(buttonText: String) {
            if buttonText == Turn.cross.buttonText {
                alertTitle = "Crosses Win"
                crossesScore+=1
            } else if buttonText == Turn.circle.buttonText {
                alertTitle = "Circles Win"
                circleScore+=1
            } else {
                alertTitle = "Draw"
            }
            showAlert = true
        }
        // checking for horizontal button 1,2,3
        if !button1ImageName.isEmpty && !button2ImageName.isEmpty && !button3ImageName.isEmpty && button1ImageName == button2ImageName && button2ImageName == button3ImageName {
            checkAlert(buttonText: button1ImageName)
        }
        // checking for horizontal button 4,5,6
        else if !button4ImageName.isEmpty && !button5ImageName.isEmpty && !button6ImageName.isEmpty && button4ImageName == button5ImageName && button5ImageName == button6ImageName {
            checkAlert(buttonText: button4ImageName)
        }
        // checking for horizontal button 7,8,9
        else if !button7ImageName.isEmpty && !button8ImageName.isEmpty && !button9ImageName.isEmpty && button7ImageName == button8ImageName && button8ImageName == button9ImageName {
            checkAlert(buttonText: button7ImageName)
        }
        // checking for vertical button 1,4,7
        else if !button1ImageName.isEmpty && !button4ImageName.isEmpty && !button7ImageName.isEmpty && button1ImageName == button4ImageName && button4ImageName == button7ImageName  {
            checkAlert(buttonText: button1ImageName)
        }
        // checking for vertical button 3,6,9
        else if !button3ImageName.isEmpty && !button6ImageName.isEmpty && !button9ImageName.isEmpty && button3ImageName == button6ImageName && button6ImageName == button9ImageName  {
            checkAlert(buttonText: button3ImageName)
        }
        // checking for vertical button 2,5,8
        else if !button2ImageName.isEmpty && !button5ImageName.isEmpty && !button8ImageName.isEmpty && button2ImageName == button5ImageName && button5ImageName == button8ImageName {
            checkAlert(buttonText: button2ImageName)
        }
        // checking for diagonal button 1,5,9
        else if !button1ImageName.isEmpty && !button5ImageName.isEmpty && !button9ImageName.isEmpty && button1ImageName == button5ImageName && button5ImageName == button9ImageName  {
            checkAlert(buttonText: button1ImageName)
        }
        // checking for diagonal button 7,5,3
        else if !button7ImageName.isEmpty && !button5ImageName.isEmpty && !button3ImageName.isEmpty && button7ImageName == button5ImageName && button5ImageName == button3ImageName  {
            checkAlert(buttonText: button7ImageName)
        }
        // checking for draw
        else if !button1ImageName.isEmpty && !button2ImageName.isEmpty && !button3ImageName.isEmpty && !button4ImageName.isEmpty && !button5ImageName.isEmpty && !button6ImageName.isEmpty && !button7ImageName.isEmpty && !button8ImageName.isEmpty && !button9ImageName.isEmpty{
            checkAlert(buttonText: "")
        }
    }
  
    var body: some View {
        
        GeometryReader { rect in
            ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                Image(changeBackground)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Menu {
                            Menu {
                                Button("SpiderMan") {
                                    currentTheme = .SpiderMan
                                    changeBackground = "SpidermanBackground"
                                    reset()
                                }
                                Button("Avengers") {
                                    currentTheme = .Avengers
                                    changeBackground = "IronManBackground"
                                    reset()
                                }
                                Button("Elements") {
                                    currentTheme = .FireWater
                                    changeBackground = "FireWaterBackground"
                                    reset()
                                }
                                Button("HarryPotter") {
                                    currentTheme = .HarryPotter
                                    changeBackground = "HarryPotterBackground"
                                    reset()
                                }
                                Button("Standard") {
                                    changeBackground = "StandardBackground"
                                    currentTheme = .standard
                                    reset()
                                }
                            } label: {
                                Label("Theme", systemImage: "folder.circle")
                            }
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
                        }
                        Button {
                            reset()
                        } label: {
                            Text("Reset")
                        }
                        Spacer()
                        Text("TicTacToe")
                            .font(.system(size: 60, weight: .black, design: .serif))
                    }
                    .frame(height: (rect.size.height * 30) / 100) // 30% of the view
                    VStack(spacing: 0) {
                        
                        HStack(spacing: 0) {
                            Button {
                                button1ImageName = button1ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button1ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button1ImageName)
                                    .opacity( button1ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .foregroundColor(Color.black)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeInOut, value: scale)
                            }
                            
                            Button {
                                button2ImageName = button2ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button2ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button2ImageName)
                                    .opacity( button2ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                            
                            Button {
                                button3ImageName = button3ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button3ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button3ImageName)
                                    .opacity( button3ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                        }
                        HStack(spacing: 0) {
                            Button {
                                button4ImageName = button4ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button4ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button4ImageName)
                                    .opacity(button4ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                            .overlay(alignment: .bottomTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.black)
                            }
                            
                            Button {
                                button5ImageName = button5ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button5ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button5ImageName)
                                    .opacity(button5ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                            .overlay(alignment: .bottomTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.black)
                            }
                            .overlay(alignment: .topTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.black)
                            }
                            
                            Button {
                                button6ImageName = button6ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button6ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button6ImageName)
                                    .opacity(button6ImageName.count > 0  ? 1.0 : 0.0)
                                    .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                            .overlay(alignment: .bottomLeading ) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.black)
                            }
                            .overlay(alignment: .topTrailing) {
                                Divider()
                                    .frame(maxWidth: .infinity, maxHeight:6)
                                    .background(Color.black)
                            }
                        }
                        HStack(spacing: 0) {
                            Button {
                                button7ImageName = button7ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button7ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button7ImageName)
                                    .opacity(button7ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 100)
                                    .onTapGesture{
                                        showText.toggle()
                                    }
                                    .animation(.easeIn, value: scale)
                            }
                            Button {
                                button8ImageName = button8ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button8ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button8ImageName)
                                    .opacity(button8ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                            Button {
                                button9ImageName = button9ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button9ImageName
                                toggleTurn()
                                checkWin()
                            } label: {
                                Image(button9ImageName)
                                    .opacity(button9ImageName.count > 0  ? 1.0 : 0.0)                                .font(.system(size: 60))
                                    .fontWeight(.heavy)
                                    .foregroundColor(Color.black)
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
                                    .background(Color.black)
                            }
                        }
                    }// Top level vstack ending
                    .frame(height: (rect.size.height * 50) / 100) // 70% of the view
                    
                    .alert(isPresented: $showAlert, content: {
                        Alert(title: Text(alertTitle), message: Text("Good job play again"), dismissButton: .default(Text("reset"), action: {
                            button1ImageName = ""
                            button2ImageName = ""
                            button3ImageName = ""
                            button4ImageName = ""
                            button5ImageName = ""
                            button6ImageName = ""
                            button7ImageName = ""
                            button8ImageName = ""
                            button9ImageName = ""
                            alertTitle = ""
                        }))
                    })
                    .padding(20)
                    
                }
            }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
    }
}
