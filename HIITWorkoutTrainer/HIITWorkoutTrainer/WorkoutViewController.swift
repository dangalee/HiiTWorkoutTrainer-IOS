//
//  WorkoutViewController.swift
//  HIITWorkoutTrainer
//
//Submission Date : 04/24/22 11:59 pm
//Team : a02section300team04
//Members:
//  Jordan Keyser jekeyser@iu.edu
//  Jungmin Lee jle18@iu.edu
//  Suriya Narayanasamy surnara@iu.edu

import UIKit
import SwiftUI
import AudioToolbox
import SpriteKit

class WorkoutViewController: UIViewController {
    
    // Reference AppDelegate and WorkoutDataModel so that we can access to model, especially array -> var workoutList: [Workout] = []
    var appDelegate: AppDelegate?
    var workoutData : WorkoutDataModel?
    
    // Global variables, accessible from both ViewWillAppear and IBAction func.
    var eachSetTime: Int = 0 //e.g. 120 sec for each set
    var eachBreakTime: Int = 0 // e.g. 60 sec for each set
    var counter: Int = 0 //Total Time(Sec) displayed in the middle of the scene
    var breakOrNot : Bool = false //Check if current is break or not
    var setNumCount: Int = 1 //Set starts from 1
    var breakNumCount: Int = 1 //Break starts from 1
    var setNumTotal: Int = 0 //Stop when setNumCount == setNumTotal
    
    // controls timer displayed on screen
    var timer = Timer() //Timer Class
    
    //Outlets for workout information, timer representation.
    @IBOutlet weak var labelForTimer: UILabel!
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var wTotalTime: UILabel!
    @IBOutlet weak var trackWorkout: UILabel!
    @IBOutlet weak var timerNum: UILabel!
    //button outlet created to change its name
    @IBOutlet weak var timerBeginButton: UIButton!
    
    // begins workout timer for the entered info from data entry scene
    @IBAction func timerBeginButton(_ sender: Any) {
        timer.invalidate()  //whenever button is tapped. STOP Timer and Restart!
    
        workOutView.isHidden = false;
        workOutView2.isHidden = false;//By default, views are hidden, so make them visible
        
        //Case2: If reset is clicked, Set labels properly and reset setNumCount and breakNumCount to 1.
        //Disable button and pause sprite kit scene from moving.
        if (self.timerBeginButton.title(for: .normal) == "Reset") {
            self.labelForTimer.text = "Please set a new workout set!"
            self.trackWorkout.text = "Resetted"
            self.setNumCount = 1
            self.breakNumCount = 1
            timerBeginButton.isEnabled = false //disables start button once reset is clicked
            workOutView.isPaused = true //pause the view for reset
            workOutView2.isPaused = true
        }
        //Case1: Normal
        else {
            //Case 1.1 : If Set
            if (breakOrNot == false) {
                timerBeginButton.setTitle("Next -> Break \(self.breakNumCount)", for: .normal)//change button label
                //Set counter to each set time. //+ 1 sec since there's delay
                self.counter = self.eachSetTime + 1 //This counter will be timer number in timerAction func
                
                    //Change text labels accordingly
                    // IF last set
                    if (self.setNumCount == self.setNumTotal || self.setNumCount == 0) {
                        self.trackWorkout.text = "Last Set!!!"
                        timerBeginButton.setTitle("Reset", for: .normal)

                    } else {
                        //IF not last set
                        self.trackWorkout.text = "Set \(self.setNumCount)"
                    }
            // start the timer
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            //End of the timer : Make breakOrNot False -> True, Increase setNumCount
            self.breakOrNot = !breakOrNot
            self.setNumCount += 1
            //Present StickmanScene in SKViews (WorkOutView, workOutView2)
            let scene = StickmanScene(size: workOutView.bounds.size)
            workOutView.presentScene(scene)
            workOutView2.presentScene(scene)
        
            }
            //Case2.2 : If Break
            else {
                timerBeginButton.setTitle("Next -> Set\(self.setNumCount)", for: .normal)//change button label
                //Set counter to each break time. //+ 1 sec since there's delay
                self.counter = self.eachBreakTime + 1
                //Change text labels accordingly : Break + breakNumCount
                self.trackWorkout.text = "Break \(self.breakNumCount)"
                // start the timer
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)

                //if timer ends, make breakOrNot True -> False, Increase breakNumCount
                self.breakOrNot = !breakOrNot
                self.breakNumCount += 1

                //Break: pasue the scene from running.
                workOutView.isPaused = true
                workOutView2.isPaused = true
                
            }
        } // end of main else case for core functionality
    } // end of timer begin button
        
    // controls the timer
    @objc func timerAction() {
        counter -= 1 //reduce timer by 1 sec
        self.timerNum.text = "\(counter)" //set timer number
        if counter == 0 {
            timer.invalidate() //if timer (counter) hits 0, then stop timer action. Otherwise, timer'll keep running negative -1 -2...etc
            //Whenever counter hits 0, make a sound
            let systemSoundID: SystemSoundID = 1304
            AudioServicesPlayAlertSound(systemSoundID)
        }
    }
     
    //two SKViews for showing Stickman Scene
    @IBOutlet weak var workOutView: SKView!
    @IBOutlet weak var workOutView2: SKView!
    
    override func viewWillAppear(_ animated: Bool) {
        //obtain a reference to the AppDelegate:
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        //from the AppDelegate, obtain a reference to the Model data:
        self.workoutData = self.appDelegate?.workoutData
        
        //Enable timer, change label to correct form.
        timerBeginButton.isEnabled = true
        self.labelForTimer.text = "Now you're doing:"
        self.timerBeginButton.setTitle("Start Timer", for: .normal)
        //Start from Set1, hence BreakOrNot = false
        breakOrNot = false
        
        // will display blank if workout list is > 0, otherwise displays last item in list
        if (workoutData?.workoutList.count ?? 0 < 1) {
            // sets default values below
            self.workoutName.text = ""
            self.wTotalTime.text = ""
            self.trackWorkout.text = ""
            self.timerNum.text = ""
            self.eachSetTime = 0
            self.eachBreakTime = 0
            self.counter = 0
            self.setNumTotal = 0
        } else {
            //Whenever view appears, get Last element from Array in the model
            //1. Update Outlets such as workout name, total workout time, Set and Break tracker and timer seconds
            self.workoutName.text = workoutData?.getLastData().title
            self.wTotalTime.text = "\(workoutData?.getLastData().totalTime ?? "") seconds"
            self.trackWorkout.text = "Set \(self.setNumCount)"
            self.timerNum.text = "\(counter)"
            //2. Set global variables such as setTime, BreakTime, counter, and total set numbers.
            self.eachSetTime = workoutData?.getLastData().setTimeInt ?? 0
            self.eachBreakTime = workoutData?.getLastData().breakTimeInt ?? 0
            self.counter = eachSetTime
            self.setNumTotal = workoutData?.getLastData().setNumInt ?? 0
        }
    }
}
