import UIKit

//Variables and constants
let players = [["name" : "Joe Smith", "height" : 42.0, "experience" : true, "guardians" : "Jim and Jan Smith"],
               ["name" : "Jill Tanner", "height" : 36.0, "experience" : true, "guardians" : "Clara Tanner"],
               ["name" : "Bill Bon", "height" : 43.0, "experience" : true, "guardians" : "Sara and Jenny Bon"],
               ["name" : "Eva Gordon", "height" : 45.0, "experience" : false, "guardians" : "Wendy and Mike Gordon"],
               ["name" : "Matt Gill", "height" : 40.0, "experience" : false, "guardians" : "Charles and Sylvia Gill"],
               ["name" : "Kimmy Stein", "height" : 41.0, "experience" : false, "guardians" : "Bill and Hillary Stein"],
               ["name" : "Sammy Adams", "height" : 45.0, "experience" : false, "guardians" : "Jeff Adams"],
               ["name" : "Karl Saygan", "height" : 42.0, "experience" : true, "guardians" : "Heather Bledsoe"],
               ["name" : "Suzane Greenberg", "height" : 44.0, "experience" : true, "guardians" : "Henrietta Dumas"],
               ["name" : "Sal Dali", "height" : 41.0, "experience" : false, "guardians" : "Gala Dali"],
               ["name" : "Joe Kavalier", "height" : 39.0, "experience" : false, "guardians" : "Sam and Elaine Kavalier"],
               ["name" : "Ben Finkelstein", "height" : 44.0, "experience" : false, "guardians" : "Aaron and Jill Finkelstein"],
               ["name" : "Diego Soto", "height" : 41.0, "experience" : true, "guardians" : "Robin and Sarika Soto"],
               ["name" : "Chloe Alaska", "height" : 47.0, "experience" : false, "guardians" : "David and Jamie Alaska"],
               ["name" : "Arnold Willis", "height" : 41.0, "experience" : true, "guardians" : "Claire Willis"],
               ["name" : "Phillip Helm", "height" : 44.0, "experience" : true, "guardians" : "Thomas Helm and Eva Jones"],
               ["name" : "Les Clay", "height" : 42.0, "experience" : true, "guardians" : "Wynonna Brown"],
               ["name" : "Herschel Krustofski", "height" : 45.0, "experience" : true, "guardians" : "Hyman and Rachel Krustofski"]]

var experienced : [[String : Any]] = []
var nonExperienced : [[String : Any]] = []

var teamSharks : [[String : Any]] = []
var teamDragons : [[String : Any]] = []
var teamRaptors : [[String : Any]] = []

let dates = [["sharks" : "March 17, 1pm", "dragons" : "March 17, 3pm", "raptors" : "March 18, 1pm"]]

//Functions

func getAverage(container : [[String : Any]]) -> Double{
    var sum : Double = 0
    var result : Double = 0
    
    for player in container {
        if let height = player["height"] as? Double{
            sum = sum + height
        }
    }
    
    result = sum / countContainer(container: container)
    
    return result
}

func countContainer(container : [[String : Any]]) -> Double{
    var sum : Double = 0
    for _ in container {
        sum = sum + 1
    }
    
    return sum
}


func assignPlayers(){
    filterPlayers()
    
    let n = experienced.count
    let d = n / 3
    
    
    assignExperienced(numberOfPlayers: d)
    teamBalancer()
    
    let avgTeam1 = getAverage(container: teamSharks)
    let avgTeam2 = getAverage(container: teamDragons)
    let avgTeam3 = getAverage(container: teamRaptors)
    
    
}

func teamBalancer(){
    while nonExperienced.count > 0 {
        print("NON EXPERIENCED COUNT:\(nonExperienced.count)")
        //Get the team with the lowest average
        print("Lowestaverage")
        let lowestAvg = lowestAverage()
        //Get the index of tallest non-experienced player

        let tallestPlayer = getTallestPlayer(container: nonExperienced)
        //Get the indexes of the 2 shortest non-experienced players
        
        if nonExperienced.count % 3 == 0 {
            let shortestPair = getShortestPair(container: nonExperienced)
            print("tallestPlayer:\(tallestPlayer)")
            print("shortestPair:\(shortestPair)")
            switch lowestAvg.team {
            case 1:
                print("CASE 1")
                teamSharks.append(nonExperienced[tallestPlayer])
                teamDragons.append(nonExperienced[shortestPair[0]])
                teamRaptors.append(nonExperienced[shortestPair[1]])
            case 2:
                print("CASE 2")
                teamSharks.append(nonExperienced[shortestPair[0]])
                teamDragons.append(nonExperienced[tallestPlayer])
                teamRaptors.append(nonExperienced[shortestPair[1]])
            case 3:
                print("CASE 3")
                teamSharks.append(nonExperienced[shortestPair[0]])
                teamDragons.append(nonExperienced[shortestPair[1]])
                teamRaptors.append(nonExperienced[tallestPlayer])
            default:
                break
            }
            
            nonExperienced.remove(at: tallestPlayer)
            nonExperienced.remove(at: shortestPair[0])
            nonExperienced.remove(at: shortestPair[1])
        }
        else {
            let shortestPlayer = getShortestPlayer(container: nonExperienced)
            print("tallestPlayer:\(tallestPlayer)")
            print("shortestPlayer:\(shortestPlayer)")
            switch lowestAvg.team {
            case 1:
                print("CASE 1")
                teamSharks.append(nonExperienced[tallestPlayer])
                teamDragons.append(nonExperienced[shortestPlayer])
            case 2:
                print("CASE 2")
                teamSharks.append(nonExperienced[shortestPlayer])
                teamDragons.append(nonExperienced[tallestPlayer])
            case 3:
                print("CASE 3")
                teamDragons.append(nonExperienced[shortestPlayer])
                teamRaptors.append(nonExperienced[tallestPlayer])
            default:
                break
            }
            
            nonExperienced.remove(at: tallestPlayer)
            nonExperienced.remove(at: shortestPlayer)

        }
        
    }
}


//Function to get the highest height amongst all non experienced players
func getTallestPlayer(container : [[String : Any]]) -> Int{
    var highest : Double = 0.0
    var index : Int = 0
    
    highest = container[0]["height"] as! Double
    index = 0
    for i in 1...container.count-1 {
        if let height = container[i]["height"] as? Double {
            if height > highest {
                highest = height
                index = i
            }
        }
    }
    
    return index
}

//Function to get the highest height amongst all non experienced players
func getShortestPlayer(container : [[String : Any]]) -> Int{
    var shortest : Double = 0.0
    var index : Int = 0
    
    shortest = container[0]["height"] as! Double
    index = 0
    for i in 1...container.count-1 {
        if let height = container[i]["height"] as? Double {
            if height < shortest {
                shortest = height
                index = i
            }
        }
    }
    
    return index
}

//Function to get the indexes of 2 players with the lowest height
func getShortestPair(container : [[String : Any]]) -> [Int]{
    var copyContainer = container
    var lowest : Double = 0.0
    var index : Int = 0
    var resultArray : [Int] = []
    
    for j in 0...1{
        lowest = copyContainer[0]["height"] as! Double
        for i in 1...container.count-1 {
            if let height = copyContainer[i]["height"] as? Double {
                if height < lowest {
                    lowest = height
                    resultArray.append(i)
                    copyContainer.remove(at: i)
                    break
                }
            }
        }
    }
    
    return resultArray
}



//Function to get lowest average height amongst all teams
func lowestAverage() -> (lowest: Double, team: Int){
    let avgTeam1 = getAverage(container: teamSharks)
    let avgTeam2 = getAverage(container: teamDragons)
    let avgTeam3 = getAverage(container: teamRaptors)
    
    var lowest = avgTeam1
    var team = 1
    
    if lowest > avgTeam2 {
        lowest = avgTeam2
        team = 2
    }
    
    if lowest > avgTeam3 {
        lowest = avgTeam3
        team = 3
    }
    
    return (lowest: lowest, team: team)
}

func assignExperienced(numberOfPlayers : Int){
    var count : Int = 0
    //Assigns experienced players to each base on the numberOfPlayers (number of exp. players / 3)
    if experienced.count > 0 {
        while count < numberOfPlayers {
            teamSharks.append(experienced[0])
            experienced.remove(at: 0)
            count = count + 1
        }
    }
    
    count = 0
    
    if experienced.count > 0 {
        while count < numberOfPlayers {
            teamDragons.append(experienced[0])
            experienced.remove(at: 0)
            count = count + 1
        }
    }
    
    count = 0
    
    if experienced.count > 0 {
        while count < numberOfPlayers {
            teamRaptors.append(experienced[0])
            experienced.remove(at: 0)
            count = count + 1
        }
    }
    
    count = 0
    //In case the number of experience players is odd, assign the last one
    if experienced.count > 0 {
        teamSharks.append(experienced[0])
        experienced.remove(at: 0)
    }
}

//Filter all players in experienced and non experienced players
func filterPlayers(){
    for player in players {
        if let exp = player["experience"] as? Bool {
            if exp {
                experienced.append(player)
            }
            else {
                nonExperienced.append(player)
            }
        }
    }
}





assignPlayers()
