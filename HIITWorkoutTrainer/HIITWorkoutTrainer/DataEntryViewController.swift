//
//  DataEntryViewController.swift
//  HIITWorkoutTrainer
//
//Submission Date : 04/24/22 11:59 pm
//Team : a02section300team04
//Members:
//  Jordan Keyser jekeyser@iu.edu
//  Jungmin Lee jle18@iu.edu
//  Suriya Narayanasamy surnara@iu.edu


import CoreLocation
import UIKit

class DataEntryViewController: UIViewController, CLLocationManagerDelegate{
    
    // instances of AppDelegate and WorkoutDataModel
    var appDelegate: AppDelegate?
    var workoutData : WorkoutDataModel?
    // variables for user entered workout fields
    var titleEntry = "", numSetsEntry = "", setTimeEntry = "", breakTimeEntry = "", dateEntry = "", timeEntry = "", locationEntry = ""
    var latitudeEntry = 0.0, longitudeEntry = 0.0
    let date = Date()
    let dateFormatter = DateFormatter()
    let locationManager = CLLocationManager()
    let content = UNMutableNotificationContent()

    // view outlets for data entry scene
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var numSetsTextField: UITextField!
    @IBOutlet weak var setTimeTextField: UITextField!
    @IBOutlet weak var breakTimeTextField: UITextField!
    
    // adds current entered workout to the list sends user to next screen
    @IBAction func startButton(_ sender: Any) {
        // obtains user entered information
        self.titleEntry = self.titleTextField.text ?? ""
        self.numSetsEntry = self.numSetsTextField.text ?? ""
        self.setTimeEntry = self.setTimeTextField.text ?? ""
        self.breakTimeEntry = self.breakTimeTextField.text ?? ""
        // gets current date and time
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.dateEntry = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "HH:mm:ss"
        self.timeEntry = dateFormatter.string(from: date)
        // calls addWorkout to add the workout to the workoutList
        workoutData?.addWorkout(pTitle: self.titleEntry, pSetNum: self.numSetsEntry, pSetTime: self.setTimeEntry, pBreakTime: self.breakTimeEntry, pCurrDate: self.dateEntry, pCurrTime: self.timeEntry, pLocation: self.locationEntry, pLatitude: self.latitudeEntry, pLongitude: self.longitudeEntry)
        
        // allows for persistent storage
        do {
            let fm = FileManager.default
            let docsurl = try fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let data = try PropertyListEncoder().encode(workoutData)
            let file = docsurl.appendingPathComponent("WorkoutData.pList")
            try data.write(to: file, options: .atomic)
        }
        catch {
            print(error)
        }
        
        // clears text fields after adding to model and plist
        self.titleTextField.text = ""
        self.numSetsTextField.text = ""
        self.setTimeTextField.text = ""
        self.breakTimeTextField.text = ""
        
        // allows for user notifications
        content.title = "HIIT Workout Trainer"
        content.subtitle = "Please remember to workout today!"
        content.sound  = UNNotificationSound.default
        // controls how many times the notification repeats
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 600, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        // displays user notification
        UNUserNotificationCenter.current().add(request)
    } // end of add workout button
    
    // hides keyboard when screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.workoutData = self.appDelegate?.workoutData
        //get location data
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // gets user location and adds to the list using lat and long coordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //manager.stopUpdatingLocation()
            let coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            self.locationEntry = coordinates.latitude.description + " " + coordinates.longitude.description
            self.latitudeEntry = coordinates.latitude
            self.longitudeEntry = coordinates.longitude
        }
    }
    
    // handles errors
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {}
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print(error)
             print("error. Fail to bring location data")
    }
} // end of view controller class
