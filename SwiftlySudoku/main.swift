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

func gridSolved() -> Bool{
    var result = true;

    for y in 0..<9 {
        for x in 0..<9 {
            if (grid[y][x] == "0"){
                result = false;
            }
        }
    }

    return result;
}

func ResetGrid(){
	for y in 0..<9 {
        for x in 0..<9 {
			grid[y][x] = "0";
		}
	}
}

func Clear(){
    for _ in 0..<100 {
        print("\n")
    }
}

func randomFill() -> Bool{
	return true;
}

func predefinedFill() -> Bool{

	//rows (y,x)
	//first row
	grid[0][0] = "8";
	grid[0][3] = "4";
	grid[0][5] = "6";
	grid[0][8] = "7";
	//second row
    grid[1][6] = "4";
    //third row
    grid[2][1] = "1";
    grid[2][6] = "6";
    grid[2][7] = "5";
    //fourth row
    grid[3][0] = "5";
    grid[3][2] = "9";
    grid[3][4] = "3";
    grid[3][6] = "7";
    grid[3][7] = "8";
    //fifth row
    grid[4][4] = "7";
    //sixth row
    grid[5][1] = "4";
    grid[5][2] = "8";
    grid[5][4] = "2";
    grid[5][6] = "1";
    grid[5][8] = "3";
    //seventh row
    grid[6][1] = "5";
    grid[6][2] = "2";
    grid[6][7] = "9";
    //eigth row
    grid[7][2] = "1";
    //ninth row
    grid[8][0] = "3";
    grid[8][3] = "9";
    grid[8][5] = "2";
    grid[8][8] = "5";

	return true;
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
                    if let _ = Int(String(userGrid[i][userGrid[i].index(userGrid[i].startIndex, offsetBy: j)])){
                        
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

func Solve() -> Bool{

    if (gridSolved()){
        return true;
    }

    //Final Check
    if (gridSolved()){
        return true;
    }    

    return false;
}

while true{
	Clear();

	//empty grid
	ResetGrid();

	print ("-= Sudoku Solver =- \n 1. User Defined Board\n 2. Randomly Generated Board\n 3. Solve Predefined Problem\n 99. Exit");
	//displayGrid();
	let c = readLine();
	var boardCreated = false;
	if (c == "1"){
		boardCreated = userFill();
	}
	else if (c == "2"){
		boardCreated = randomFill();
	}
	else if (c == "3"){
		boardCreated = predefinedFill();
	}
    else if (c == "99"){
        break
    }
	else{
		print("\nInput was incorrect")
	}
	if boardCreated{
		displayGrid();
        let solvedResult = Solve();
        if (solvedResult){
            print("Solution Found!")
        }
        else{
            print("Could not find solution :(")
        }
	}
    print("Press Enter To Continue")
	let _ = readLine();
	
}
