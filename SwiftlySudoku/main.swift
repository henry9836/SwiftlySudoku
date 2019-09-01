//
// (c) Copyright
// Media Design School
// Bachelor of Software Engineering
// 2019
//
// Batch: 19022A
// Class: GD2S03
//
// File: main.swift
// Description: This script solves sudoku puzzles
// Author: Henry Oliver
// Email: henry983615@gmail.com
//

import Foundation

typealias gridPosition = (Int, Int) //tuple to hold x and y

let importantMath:UInt8 = 0b11111110 //used to increment a value

var move = 1; //used to track recursive functions
var grid = Array(repeating: Array(repeating: "0", count: 9), count: 9) //our board
var gridAlt = Array(repeating: Array(repeating: "0", count: 9), count: 9) //backup board used for checks
var increment = 1; //used for random numbers
let maxStep = 100000; //used to stop recursive function


//Name: randInt
//Desc: randInt is a linear congruential generator that returns a random number from 1 to the argument of highRange
func randInt(_ highRange: Int) -> Int{
    var result = 0;
    let modulus = 4294967296;
    let multiplier = 22695477;
    increment += 13; //increment by 13 to simulate more time passing
    let seed: TimeInterval = Date().timeIntervalSince1970 //get current time since 1970 in seconds as a double
    print("RAWTIME: \(seed)")

    let iseed = Int((Double(multiplier) * seed + Double(increment))) % modulus; //convert seed into an int so we can use modulus on it, from there we round our seed to the modulus

    print("MOD: \(modulus)\nMULTI: \(multiplier)\nINCRE: \(increment)\nSEED: \(seed)\n\n")
    
    result = iseed%highRange //round iseed to our highRange argument to get a random number beteen 0 and highRange
    result += 1; //avoid 0 as a result

    print("RESULT RANDOM NUMBER IS: \(result)")

    return result;
}

//Name: isLegalBoard
//Desc: Checks each number in our board to see if it is in a legal position
func isLegalBoard() -> Bool{
    for y in 0..<9{
        for x in 0..<9{
            if (grid[y][x] != "0"){ //skip empty spots
                gridAlt = grid; //make a backup 
                
                let num = Int(grid[y][x])! 
                grid[y][x] = "0";
                if (!isLegal(y,x,num)){ 
                    return false; //our board is not legal
                }
                grid = gridAlt; //restore backup
            }
        }
    }
    return true; //board is legal
}

//Name: displayGrid
//Desc: Goes through all elements of the board and displays them in a grid
func displayGrid(){
    for y in 0..<9 {
        for x in 0..<9 {
            if (x == 3 || x == 6){
                print("|", terminator:""); //horizontal seperator
            }
            print(grid[y][x], terminator:"");
        }
        if (y == 2 || y == 5){
            print("\n---+---+---"); //vertical seperator
        }
        else{
            print(""); //new line
        }
    }
}

//Name: gridSolved
//Desc: Checks if the grid is solved
func gridSolved() -> Bool{
    var result = true;

    for y in 0..<9 {
        for x in 0..<9 {
            if (grid[y][x] == "0"){
                result = false; //if we found a empty spot return false
            }
        }
    }

    return result;
}

//Name: ResetGrid
//Desc: Sets all positions to empty
func ResetGrid(){
	for y in 0..<9 {
        for x in 0..<9 {
			grid[y][x] = "0";
		}
	}
}

//Name: Clear
//Desc: Clears the screen by making 100 newlines
func Clear(){
    for _ in 0..<100 {
        print("\n")
    }
}

//Name: randomFill
//Desc: Generates a new board with numbers in random positions that are legal
func randomFill() -> Bool{

    let lpamount = randInt(8); //how many numbers we want to generate
    var lawyer = false; //checker for legal board
    
    while !lawyer{
        ResetGrid(); //reset the board
        //fill in grid
        for _ in 0..<(3 + lpamount){
            var placed = false //checker for when we place a number
            while(!placed){
                let x = randInt(9)-1; //generarte a random number from 0-8
                let y = randInt(9)-1; //generarte a random number from 0-8
                let val = randInt(9); //generarte a random number from 1-9
                let strVal = String(val); //get string value of val to use later
                if (isLegal(y, x, val)){ //if our randomised position and number are legal then
                    print("Set \(y):\(x) to \(strVal)")
                    grid[y][x] = String(val) //set position on grid to our value
                    displayGrid();
                    print("-----------------------------")
                    placed = true //we have placed a number
                }
            }
        }
        lawyer = isLegalBoard(); //check if generated board is legal
    }

    //print("randomly done") //done

	return true;
}

//Name: predefinedFill
//Desc: Sets up a board that has been predefined
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

//Name: userFill
//Desc: Takes user input to create a board
func userFill() -> Bool{
    print("User Definied Grid\n")
    
    var userInputIsCorrect = false;
    var userGrid = Array(repeating: " ", count: 9)

    //While the user is not giving us valid input
    while (!userInputIsCorrect){
        
        Clear(); //clear the screen
        
        print("-= User Supplied Grid =-")
        
        //reset users grid
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
        
        //check for invalid length
        for i in 0..<9{
            if (userGrid[i].count != 9){
                userInputIsCorrect = false
            }
        }
        
        if (userInputIsCorrect){
            print("Try and convert values")
            //Try and convert user values
            for i in 0..<9 {
                for j in 0..<9{
                    print(i)
                    print(j)
                    print(String(userGrid[i][userGrid[i].index(userGrid[i].startIndex, offsetBy: j)]))
                    if let _ = Int(String(userGrid[i][userGrid[i].index(userGrid[i].startIndex, offsetBy: j)])){ //if we can convert user input into valid variables then
                        //success
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
            break; //escape while loop because user has supplied correct input
        }
        
        //user has not supplied correct input

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

//Name: usedInRow
//Desc: Is the value used in our row
func usedInRow(_ row: Int, _ value: String) -> Bool{
    for i in 0..<9{
        if (grid[row][i] == value){
            return true;
        }
    }
    return false;
}

//Name: usedInRow
//Desc: Is the value used in our column
func usedInCol(_ col: Int, _ value: String) -> Bool{
    for i in 0..<9{
        if (grid[i][col] == value){
            return true;
        }
    }
    return false;
}
//Name: usedInRow
//Desc: Is the value used in our 3x3 box
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

//Name: findEmpty
//Desc: finds the first empty position on the grid and returns the x and y in a tuple
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

//Name: isLegal
//Desc: Checks if a number is in a legal position on the board
func isLegal(_ row: Int, _ col: Int, _ value: Int) -> Bool{
    //If value is not used in the same row, column or box then it is legal
    return !usedInRow(row, String(value)) && !usedInCol(col, String(value)) && !usedInBox(row - row % 3, col - col % 3, String(value));
}

//Name: DownTheRabbitHole
//Desc: Attempts to find a solution via recursive functions
func DownTheRabbitHole() -> Bool{

    //Update our current step counter
    move -= -((move/move*Int("1")!) * Int(~importantMath)); //move ++;

    //find an empty spot on the board

    let row = findEmpty().0; 
    let col = findEmpty().1;

    //we found a solution because grid is full or we have exceeded our maximum steps so exit
    if (col == -1 && row == -1 || move > maxStep){
        return true;
    }

    //for values 1-9 try and fill the empty spot
    for i in 1..<10{
        //can we can fill a spot in legally
        if (isLegal(row, col, i)){
            grid[row][col] = String(i); //set the position on the grid to our value

            //recursive
            if (DownTheRabbitHole()){
                return true; //we found a valid number backtrace
            }

            //if failed
            grid[row][col] = "0"; //reset position on the grid because we failed

        }
    }

    //bad number backtrack to previous numbers
    return false;
}

//Name: Solve
//Desc: Starts the recursive function to solve the puzzle as well as outputting if we solved it successfully or not
func Solve() -> Bool{

    print("Solving...")

    if (gridSolved()){
        return true;
    }

    //while our grid is not solved solve the grid
    while(!gridSolved() && move < maxStep){
        let _ = DownTheRabbitHole();
    }

    if (move > maxStep){ //failed to find solution
        print("Max Step Reached Could Not Find A Solution :(")
        print("Stopped looking for solution after \(move) steps")
        displayGrid();
        return false;
    }
    else{ //found solution
        //Final Check
        if (gridSolved()){
            print(" [ SOLUTION BOARD ]")
            print("Solved in \(move) steps!")
            displayGrid();
            return true;
        }    
    }

    return false; //solver failed to run correctly
}

//main loop of program
while true{
    //clear screen
	Clear();

	//empty grid and reset counter
	ResetGrid();
    move = 1;

    //main menu
	print ("-= Sudoku Solver =-\n ~Henry Oliver \n 1. User Defined Board\n 2. Randomly Generated Board\n 3. Solve Predefined Problem\n 99. Exit");

    //take user input and complete action based on user choice
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

    displayGrid() //display the grid


    //Check for solveable board    
    var legal = true;
    if (boardCreated){
        legal = isLegalBoard()
    }
	else{
		print("\nInput was incorrect")
	}
    //if our board is legal then
	if (boardCreated && legal){
        Clear();
        print(" [ BOARD ]")
		displayGrid();
        let solvedResult = Solve(); //attempt to find a solution
        if (solvedResult){
            print("Solution Found!")
        }
        else{
            displayGrid();
            print("Could not find solution :(")
        }
	}
    //if our board is not legal then
    else if (!legal && boardCreated){
        print("Unsolvable Board Detected!")
    }
    print("Press Enter To Continue")
	let _ = readLine(); //pause
	
}
