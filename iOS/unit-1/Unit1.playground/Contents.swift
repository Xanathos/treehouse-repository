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
    let avgTeam1 = getAverage(container: teamSharks)
    let avgTeam2 = getAverage(container: teamDragons)
    let avgTeam3 = getAverage(container: teamRaptors)
    
    print(avgTeam1)
    print(avgTeam2)
    print(avgTeam3)
}

func teamBalancer(){
    let highest = highestAverage()
}

func highestAverage() -> (highest: Double, team: Int){
    let avgTeam1 = getAverage(container: teamSharks)
    let avgTeam2 = getAverage(container: teamDragons)
    let avgTeam3 = getAverage(container: teamRaptors)
    
    var highest = avgTeam1
    var team = 1
    
    if highest < avgTeam2 {
        highest = avgTeam2
        team = 2
    }
    
    if highest < avgTeam3 {
        highest = avgTeam3
        team = 3
    }
    
    return (highest, team)
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
