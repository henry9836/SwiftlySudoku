import Foundation

var grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)

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


displayGrid();