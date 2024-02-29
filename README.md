# tictactoe

<img src="https://github.com/msiddharth2813/tictactoe_swiftui/assets/109169591/d5e848a3-b822-4fd4-97ba-643ef8da1692" width="300"/>

### This is how I made my TicTaccToe Game

 ## Chapter : 1 The Layout 

First of all  I created a Vstack in the Vstack I added another two Vstacks inside I left the first one empty but in the second Vstack I added three additional Hstacks.
I added these, so I can get the layout ready. In each of these Hstacks I added three buttons, so each square was tapable. Now each square was capable, but  we still need to add the lines. To do this I had a simple method 

```
.overlay(alignment: .leading) {
Divider()
    .frame(maxWidth: 6, maxHeight: .infinity)
    .background(Color.black)
} 
```
This will create a line in the Left
```
.overlay(alignment: .topTrailing) {
Divider()
    .frame(maxWidth: .infinity, maxHeight:6)
    .background(Color.black)
}
```
This will create a line in the top
```
.overlay(alignment: .bottomTrailing) {
Divider()
    .frame(maxWidth: .infinity, maxHeight:6)
    .background(Color.black)
}
```
This will create a line in the right
```
.overlay(alignment: .bottomLeading ) {
  Divider()
     .frame(maxWidth: .infinity, maxHeight:6)
     .background(Color.black)
} 
```
This will create a line in the bottom

After you finish making all the lines you will need to split the view 

How you will do that is by typing this below the top level stack
By the way the top level stack is the Vstack that holds all the other Vstacks
```
.frame(height: (rect.size.height * 50) / 100) // 70% of the view
```
Type this top of the Vstack that holds all the Hstacks, so this covers the top.
```
  .frame(height: (rect.size.height * 30) / 100) // 30% of the view
```
In the first Stack type TicTacToe as a title and give it a height of 60 and any font you want.

## Chapter : 2 Game Logic 


Now Checking if it is a Win or not to check this we need to add a func 

In the func  you have to add a if 

 checking for horizontal button 1,2,3
 
```
if !button1ImageName.isEmpty && !button2ImageName.isEmpty && !button3ImageName.isEmpty && button1ImageName == button2ImageName && button2ImageName == button3ImageName {
    checkAlert(buttonText: button1ImageName)
}
```
Like this add a extending else if until you check all the squares. 
 
This Enum will help creating a cross and a circle. 
This will also help checking if win.  
This is the main Enum for the logic of the game so it could work. 

```
 Enum Turn  {
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
 }
```
Add all these variables for calling them to  show the x and o 

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
 
These varibles are really important.

This is an Example of an button .
```
Button {
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
```
Add all of these requirements and don’t forget to add all the requirements for the label.
Add 9 of these to create nine buttons.

## Chapter : 3 Alerts

Now we need to show the win/lose/draw alert. 
To do this create an alert like this
```
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
```
In checkWin create another function.
``` 
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
```
Now when you win you should get this alert.
Basically we are calling the alert when we either win or lose after it is called you should
see a button reset so the game resets.

This should be in your Vstack 
Add the reset button if you didn’t 
It is really important if you want to reset the game in the middle.
```
Button {
    reset()
} label: {
    Text("Reset")
}
Spacer()
Text("TicTacToe")
```

## Chapter : 4 Themes

 Lastly in the top level stack place This

```
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
```

Add all this in The top level Vstack for the dropdown button and the themes, but you have to add themes in your assets. 

Add this all for each buttons.
```
button9ImageName = button9ImageName.count == 0 ? currentTurn.imageName(theme: currentTheme) : button9ImageName
```
Change the button name too.

## Chapter : 5 GameModes

Everything was at place but there was an problem what if you didnt have a player to play with?

you would need an robot to play with you that is accurate.

first start off simple add an picker with two modes to choose two player and botVsPlayer
```

   Picker("Game Mode", selection: $mode.onChange(modeChanged)) {
	ForEach(modes, id: \.self) {
	    Text($0)
	}
    }
    .pickerStyle(.menu)
```
mode was an State var that defined the current mode.

also create another file to store the two different gamemodes. Create an enum to store both your cases and define the enum as a string. Give the enum string values.

modes will contain the two modes and modes is an let.

then in the ticTactoeimages file add unamed and add it 9 times and give each one of them an string value.

Then you will need to create an file called the game engine.

in the engine create an two dimensional array called positions because it will know the squares positions.

create an func named nextMove and give it buttonPos that will be an int and give it image that will be tictactoeImage.

then adde every case there is like this

    if positions[0][0] == positions[0][1] && positions[0][0] == image {
            if positions[0][2] == TicTacToeImage.unnamed3 {
                return convertArrayIndexToButtonPosition((0, 2))
            }
        }
so basically think a two dimensional array like this
```
    [0, 0], [0, 1], [0, 2]
    [1, 0], [1, 1], [1, 2]
    [2, 0], [2, 1], [2, 2]
    ```
```
     func fillImage(buttonPos: Int, image: TicTacToeImage) {
        let index = convertButtonPosToArrayIndex(position: buttonPos)
        positions[index.0][index.1] = image
    }
    ```
this func will fill in the squares.
now create another func 

next freemove it will see the next free move it will check all the avaliblePos to fill it in.
next move takes in button pos that is an int as parameters 

we also need to get rid of check win and add hasWon has won if faster and an easier way to check win it will return a tuple bool and in its parameters i will have image that will recal tictactoeimage. 

```
if positions[0][0] == positions[0][1] &&  positions[0][1] == positions[0][2] && positions[0][0] == image {
    return (true, false)
}
```
add like this until you get all the cases
then at last add a draw case that has all the cases then return false and false.


