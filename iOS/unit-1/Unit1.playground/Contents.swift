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

var letters : [String] = []

let dates = ["Sharks" : "March 17, 1pm", "Dragons" : "March 17, 3pm", "Raptors" : "March 18, 1pm"]
let messages = ["Sharks" : "don't try to star in Jaws movie or something, ok?",
                "Dragons" : "don't try to star in Game of Thrones or something, ok?",
                "Raptors" : "don't try to star in Jurassic World or something, ok?"]

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
    
    letterGenerator(container: teamSharks)
    letterGenerator(container: teamDragons)
    letterGenerator(container: teamRaptors)
    
    for i in letters {
        print(i)
    }
    
}

func letterGenerator(container : [[String : Any]]){
    for player in container {
        if let playerName = player["name"] as? String,
            let teamName = player["team"] as? String,
            let guardianName = player["guardians"] as? String,
            let startDate = dates[teamName],
            let message = messages[teamName]
        {
            letters.append(generate(teamName: teamName, playerName: playerName, startDate: startDate, guardianNames: guardianName, message: message))
        }
        
    }
}

func generate(teamName : String,
              playerName : String,
              startDate : String,
              guardianNames : String,
              message: String) -> String{
    
        return """
        Greetings, \(guardianNames). Congratulations on the acceptance of \(playerName) to the \(teamName) soccer team.
        The first practice will be held in the following date: \(startDate) so all players of the team are expected to be
        there.
        
        We hope that we see he/she there, and please \(message)
        """
    
}

func teamBalancer(){
    while nonExperienced.count > 0 {
        /***
         This functions aims to balance the teams in two steps:
         The first is, once the experienced players have beeen assigned in the previous step
         the function seeks the lowest team height average, and assigns the tallest player amongs
         the non experienced players to that team. Also gets the two shortest players in that moment
         and assigns it to the other two teams. The function repeats the process until all players
         have been assigned.
         ***/
        let lowestAvg = lowestAverage()
        let tallestPlayer = getTallestPlayer(container: nonExperienced)
        
        if nonExperienced.count % 3 == 0 {
            let shortestPair = getShortestPair(container: nonExperienced, tallestPlayer: tallestPlayer)
            switch lowestAvg.team {
            case 1:
                teamSharks.append(nonExperienced[tallestPlayer])
                teamDragons.append(nonExperienced[shortestPair[0]])
                teamRaptors.append(nonExperienced[shortestPair[1]])
            case 2:
                teamSharks.append(nonExperienced[shortestPair[0]])
                teamDragons.append(nonExperienced[tallestPlayer])
                teamRaptors.append(nonExperienced[shortestPair[1]])
            case 3:
                teamSharks.append(nonExperienced[shortestPair[0]])
                teamDragons.append(nonExperienced[shortestPair[1]])
                teamRaptors.append(nonExperienced[tallestPlayer])
            default:
                break
            }
            
            let indexArray = [tallestPlayer, shortestPair[0], shortestPair[1]]
            removeElements(elementIndexes: indexArray)
        }
        else {
            let shortestPlayer = getShortestPlayer(container: nonExperienced, tallestPlayer: tallestPlayer)
            switch lowestAvg.team {
            case 1:
                teamSharks.append(nonExperienced[tallestPlayer])
                teamDragons.append(nonExperienced[shortestPlayer])
            case 2:
                teamSharks.append(nonExperienced[shortestPlayer])
                teamDragons.append(nonExperienced[tallestPlayer])
            case 3:
                teamDragons.append(nonExperienced[shortestPlayer])
                teamRaptors.append(nonExperienced[tallestPlayer])
            default:
                break
            }
            
            let indexArray = [tallestPlayer, shortestPlayer]
            removeElements(elementIndexes: indexArray)
        }
        
    }
    
    if players.count % 3 == 0 {
        var count1 = teamSharks.count
        var count2 = teamDragons.count
        var count3 = teamRaptors.count
        
        while !(count1 == count2 && count1 == count3) {
            count1 = teamSharks.count
            count2 = teamDragons.count
            count3 = teamRaptors.count
            
            var highestCount = ""
            var lowestCount = ""
            
            if count1 > count2 {
                if count1 > count3 {
                    highestCount = "sharks"
                }
                else {
                    highestCount = "raptors"
                }
            }
            else {
                if count2 > count3 {
                    highestCount = "dragons"
                }
                else {
                    highestCount = "raptors"
                }
            }
            
            
            if count1 < count2 {
                if count1 < count3 {
                    lowestCount = "sharks"
                }
                else {
                    lowestCount = "raptors"
                }
            }
            else {
                if count2 < count3 {
                    lowestCount = "dragons"
                }
                else {
                    lowestCount = "raptors"
                }
            }
            
            
            var readjustment : [String : Any] = [:]
            switch highestCount {
                case "sharks":
                    if let re = teamSharks.last {
                        readjustment = re
                    }
                    teamSharks.removeLast()
                case "dragons":
                    if let re = teamDragons.last {
                        readjustment = re
                    }
                    teamDragons.removeLast()
                case "raptors":
                    if let re = teamRaptors.last {
                        readjustment = re
                    }
                    teamRaptors.removeLast()
                default:
                    break
            }
            
            switch lowestCount {
                case "sharks":
                    teamSharks.append(readjustment)
                case "dragons":
                    teamDragons.append(readjustment)
                case "raptors":
                    teamRaptors.append(readjustment)
                default:
                    break
            }
            
            
        }
    }
    
    for i in 0...teamSharks.count - 1 {
        teamSharks[i]["team"] = "Sharks"
    }
    
    for i in 0...teamDragons.count - 1 {
        teamDragons[i]["team"] = "Dragons"
    }
    
    for i in 0...teamRaptors.count - 1 {
        teamRaptors[i]["team"] = "Raptors"
    }
    
}

func removeElements(elementIndexes: [Int]){
    var container : [[String : Any]] = []
    
    //Getting the selected players for delete out of the nonExperienced array
    for element in elementIndexes {
        container.append(nonExperienced[element])
    }
    
    //If the name of the player in nonExperienced fits with the one selected, remove it
    for element in container{
        for i in 0...nonExperienced.count-1 {
            if let element2 = element["name"] as? String{
                if let player = nonExperienced[i]["name"] as? String{
                    if element2 == player {
                        nonExperienced.remove(at: i)
                        break
                    }
                }
            }
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
func getShortestPlayer(container : [[String : Any]], tallestPlayer : Int) -> Int{
    var copyContainer = container
    copyContainer.remove(at: tallestPlayer)
    var shortest : Double = 0.0
    var index : Int = 0
    
    shortest = copyContainer[0]["height"] as! Double
    index = 0
    for i in 1...copyContainer.count-1 {
        if let height = copyContainer[i]["height"] as? Double {
            if height < shortest {
                shortest = height
                index = i
            }
        }
    }
    
    return index
}

//Function to get the indexes of 2 players with the lowest height
func getShortestPair(container : [[String : Any]], tallestPlayer : Int) -> [Int]{
    var copyContainer = container
    //Remove tallestPlayer
    copyContainer.remove(at: tallestPlayer)
    var lowest : Double = 0.0
    var resultArray : [Int] = []
    
    for j in 0...1{
        lowest = copyContainer[0]["height"] as! Double
        
        if copyContainer.count > 2 {
            for i in 1...copyContainer.count-1 {
                if let height = copyContainer[i]["height"] as? Double {
                    if height < lowest {
                        lowest = height
                        resultArray.append(i)
                        copyContainer.remove(at: i)
                        break
                    }
                }
                
                if i == copyContainer.count-1{
                    resultArray.append(i)
                    copyContainer.remove(at: i)
                }
            }
        }
        else if copyContainer.count == 2{
            resultArray.append(0)
            resultArray.append(1)
            copyContainer.removeAll()
            break
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
