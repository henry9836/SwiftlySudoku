import Foundation

var grid = Array(repeating: Array(repeating: "0", count: 9), count: 9)

func displayGrid(){
    for y in 0..<9 {
        for x in 0..<9 {
            if (x == 3 || x == 6){
                print("|", terminator:"");
            }
            print(grid[y][x], terminator:"");
        }
        if (y == 2 || y == 5){
            print("\n---+---+---");
        }
        else{
            print("");
        }
    }
}

func Clear(){
    for _ in 0..<100 {
        print("\n")
    }
}

func userFill() -> Bool{
    print("User Definied Grid\n")
    
    var userInputIsCorrect = false;
    var userGrid = Array(repeating: " ", count: 9)
    //While the user is not giving us valid input
    
    while (!userInputIsCorrect){
        
        Clear();
        
        print("-= User Supplied Grid =-")
        
        for i in 0..<9 {
            userGrid[i] = " ";
        }
        
        var userUsageCount = 1;
        
        //user input
        
        for i in 0..<9 {
            print("Please Input One Line Of 9 Numbers For Row \(userUsageCount): ")
            let l1 = readLine(strippingNewline: true); //set to true to ignore newlines and char combinations
            userGrid[i] = l1!
            userUsageCount += 1
        }
        
        //check user input for bad input
        
        userInputIsCorrect = true
        
        for i in 0..<9{
            if (userGrid[i].count != 9){
                userInputIsCorrect = false
            }
        }
        
        if (userInputIsCorrect){
            
            print("Try and convert values")
            //Try and convert values
            
            for i in 0..<9 {
                for j in 0..<9{
                    print(i)
                    print(j)
                    print(String(userGrid[i][userGrid[i].index(userGrid[i].startIndex, offsetBy: j)]))
                    if let tester = Int(String(userGrid[i][userGrid[i].index(userGrid[i].startIndex, offsetBy: j)])){
                        
                    }
                    else{
                        print("Something went wrong 🙃")
                        userInputIsCorrect = false
                    }
                    
                }
            }
            
        }
        Clear();
        
        if (userInputIsCorrect){
            break; //escape while loop
        }
        
        print("User Input Invalid Please Input Numbers For Each Row. Example: 123456789")
        print("Press Enter To Continue")
        let _ = readLine();
        
    }
    
    //update grid with user input
    
    for i in 0..<9 {
        for j in 0..<9{
            grid[i][j] = String(userGrid[i][userGrid[i].index(userGrid[i].startIndex, offsetBy: j)])
        }
    }
    
    return true;
}


displayGrid();
var userRes = userFill();
Clear();
if userRes{
    displayGrid();
}
else{
    print("\nSomething went wrong exitting...")
}
