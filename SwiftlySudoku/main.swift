import Foundation

typealias gridPosition = (Int, Int)

let importantMath:UInt8 = 0b11111110

var move = 1;
var grid = Array(repeating: Array(repeating: "0", count: 9), count: 9)
var gridAlt = Array(repeating: Array(repeating: "0", count: 9), count: 9)
var increment = 1;
let maxStep = 100000;

func randInt(_ highRange: Int) -> Int{ //Swift 4.1 doesn't have what I want so i'll just build myself a linear congruential generator

    var result = 0;
    let modulus = 4294967296;
    let multiplier = 22695477;
    increment += 13;
    //var seed = Int(Int((Date().timeIntervalSinceReferenceDate)))
    let timeInSeconds: TimeInterval = Date().timeIntervalSince1970
    let seed = timeInSeconds;
    print("RAWTIME: \(timeInSeconds)")

    var iseed = Int((Double(multiplier) * seed + Double(increment))) % modulus;

    print("MOD: \(modulus)\nMULTI: \(multiplier)\nINCRE: \(increment)\nSEED: \(seed)\n\n")
    
    result = iseed%highRange
    result += 1; //avoid 0 as a result

    print("RESULT RANDOM NUMBER IS: \(result)")

    return result;
}

func isLegalBoard() -> Bool{
    for y in 0..<9{
        for x in 0..<9{
            if (grid[y][x] != "0"){
                gridAlt = grid; //make a backup
                
                let num = Int(grid[y][x])!
                grid[y][x] = "0";
                if (!isLegal(y,x,num)){
                    print("NOT LEGAL \(y):\(x)")
                    return false;
                }

                grid = gridAlt; //restore backup
            }
        }
    }
    return true;
}

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

    let lpamount = randInt(8);
    var lawyer = false;
    
    while !lawyer{
    ResetGrid();
    //fill in grid
    for v in 0..<(3 + lpamount){
        var placed = false
        while(!placed){
            let x = randInt(9)-1;
            let y = randInt(9)-1;
            let val = randInt(9);
            let w = randInt(9000000)%9;
            let strVal = String(val);
            if (isLegal(y, x, val)){
                print("Set \(y):\(x) to \(strVal) and werid thing is \(w)")
                grid[y][x] = String(w)
                displayGrid();
                print("-----------------------------")
                placed = true
            }
        }
    }
    lawyer = isLegalBoard();  
    }

    print("randomly done")

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

//is the value used in our row
func usedInRow(_ row: Int, _ value: String) -> Bool{
    for i in 0..<9{
        if (grid[row][i] == value){
            return true;
        }
    }
    return false;
}

//Is the value used in our column
func usedInCol(_ col: Int, _ value: String) -> Bool{
    for i in 0..<9{
        if (grid[i][col] == value){
            return true;
        }
    }
    return false;
}

//Is the value used in our 3x3 box
func usedInBox(_ topLeftRow: Int, _ topLeftCol: Int, _ value: String) -> Bool{
    for y in 0..<3{
        for x in 0..<3{
            if (grid[topLeftRow + y][topLeftCol + x] == value){
                return true;
            }
        }
    }
    return false;
}

func findEmpty() -> gridPosition{
    var result = (-1,-1);

    //find an empty position

    for y in 0..<9{
        for x in 0..<9{
            if (grid[y][x] == "0"){
                result.0 = y;
                result.1 = x;
                return result;
            }
        }
    }

    return result
}

//checks if a number is in a legal position
func isLegal(_ row: Int, _ col: Int, _ value: Int) -> Bool{
    //If value is not used in the same row, column or box then it is legal
    return !usedInRow(row, String(value)) && !usedInCol(col, String(value)) && !usedInBox(row - row % 3, col - col % 3, String(value));
}

//attempts to find a solution
func DownTheRabbitHole() -> Bool{

    //Show our current Step
    //print("\n\n [ Solve Step: \(move) ]")
    move -= -((move/move*Int("1")!) * Int(~importantMath)); //move ++;
    //displayGrid();

    let row = findEmpty().0;
    let col = findEmpty().1;

    //print(" [ DEBUG COL: \(col) ROW: \(row) ]")

    //we found a solution because grid is full
    if (col == -1 && row == -1 || move > maxStep){
        return true;
    }

    for i in 1..<10{
        //we can fill a spot in legally
        if (isLegal(row, col, i)){
            grid[row][col] = String(i);
            //print(" CHANGED ROW: \(row) AND COL: \(col) TO: \(i)")
            //displayGrid()

            //recursive
            if (DownTheRabbitHole()){
                return true;
            }

            //if failed
            grid[row][col] = "0";

        }
    }
    

    //bad number backtrack to previous numbers
    return false;
}

//Solves the puzzle
func Solve() -> Bool{

    print("Solving...")

    if (gridSolved()){
        return true;
    }

    //while our grid is not solved solve the grid
    while(!gridSolved() && move < maxStep){
        DownTheRabbitHole();
    }

    if (move > maxStep){
        print("Max Step Reached Could Not Find A Solution :(")
        print("Stopped looking for solution after \(move) steps")
        displayGrid();
        return false;
    }
    else{
        //Final Check
        if (gridSolved()){
            print(" [ SOLUTION BOARD ]")
            print("Solved in \(move) steps!")
            displayGrid();
            return true;
        }    
    }

    return false;
}

while true{
	Clear();

	//empty grid
	ResetGrid();
    move = 1;

	print ("-= Sudoku Solver =-\n ~Henry Oliver \n 1. User Defined Board\n 2. Randomly Generated Board\n 3. Solve Predefined Problem\n 99. Exit");
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

    displayGrid()

    var legal = true;

    //Check for solveable board
    if (boardCreated){
        legal = isLegalBoard()
    }

	else{
		print("\nInput was incorrect")
	}
	if (boardCreated && legal){
        Clear();
        print(" [ BOARD ]")
		displayGrid();
        let solvedResult = Solve();
        if (solvedResult){
            print("Solution Found!")
        }
        else{
            displayGrid();
            print("Could not find solution :(")
        }
	}
    else if (!legal && boardCreated){
        print("Unsolvable Board Detected!")
    }
    print("Press Enter To Continue")
	let _ = readLine();
	
}
