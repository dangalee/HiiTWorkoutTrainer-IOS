//
//  WorkoutDataModel.swift
//  HIITWorkoutTrainer
//
//Submission Date : 04/24/22 11:59 pm
//Team : a02section300team04
//Members:
//  Jordan Keyser jekeyser@iu.edu
//  Jungmin Lee jle18@iu.edu
//  Suriya Narayanasamy surnara@iu.edu



import Foundation

// WorkoutDataModel class, keeps the list of workouts a
class WorkoutDataModel: NSObject, Codable {
    
    // keeps track of all entered workouts
    var workoutList: [Workout] = []

    // description for persistent data
    override var description : String {
        var outputString: String = ""
        for i in workoutList {
            outputString += i.title + " "
            outputString += i.setNum + " "
            outputString += i.setTime + " "
            outputString += i.breakTime + " "
            outputString += i.currDate + " "
            outputString += i.currTime + " "
            outputString += i.location + " "
            outputString += String(i.latitude) + " "
            outputString += String(i.longitude) + " "
        }
        return outputString
    }
    
    // adds a Workout class item to the workoutList
    func addWorkout(pTitle: String, pSetNum: String, pSetTime: String, pBreakTime: String, pCurrDate: String, pCurrTime: String, pLocation: String, pLatitude: Double, pLongitude: Double) {
        workoutList.append(Workout(pTitle: pTitle, pSetNum: pSetNum, pSetTime: pSetTime, pBreakTime: pBreakTime, pCurrDate: pCurrDate, pCurrTime: pCurrTime, pLocation: pLocation, pLatitude: pLatitude, pLongitude: pLongitude))
        print(workoutList[workoutList.count - 1])
    }
    
    // returns last item of workout list
    func getLastData() -> Workout {
        return workoutList[workoutList.count - 1]
    }
} // end of WorkoutDataModel class

// Workout class, describes the property of a single workout
class Workout: NSObject, Codable {
    
    // instances of Workout class
    var title: String
    var setNum: String
    var setTime: String
    var totalTime: String
    var breakTime: String
    var currDate: String
    var currTime: String
    var location: String
    var latitude: Double
    var longitude: Double
    
    //Create Int version of setNum, setTime, breakTime
    var setNumInt: Int
    var setTimeInt: Int
    var breakTimeInt: Int
    
    // initializer for Workout class
    init (pTitle: String, pSetNum: String, pSetTime: String, pBreakTime: String, pCurrDate: String, pCurrTime: String, pLocation: String, pLatitude: Double, pLongitude: Double) {
        // initializes all instances of Item class
        self.title = pTitle
        self.setNum = pSetNum
        self.setTime = pSetTime
        self.breakTime = pBreakTime
        self.currDate = pCurrDate
        self.currTime = pCurrTime
        self.setNumInt = Int(pSetNum) ?? 0
        self.setTimeInt = Int(pSetTime) ?? 0
        self.breakTimeInt = Int(pBreakTime) ?? 0
        self.totalTime = String((setNumInt * setTimeInt) + (breakTimeInt * (setNumInt - 1)))
        self.location = pLocation
        self.latitude = pLatitude
        self.longitude = pLongitude
        super.init()
    }
} // end of Item class

