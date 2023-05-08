//
//  WorkoutTableViewController.swift
//  HIITWorkoutTrainer
//
//Submission Date : 04/24/22 11:59 pm
//Team : a02section300team04
//Members:
//  Jordan Keyser jekeyser@iu.edu
//  Jungmin Lee jle18@iu.edu
//  Suriya Narayanasamy surnara@iu.edu



import UIKit
import CoreLocation
import MapKit

class WorkoutTableViewController: UITableViewController {
    
    // instances of app delegate and workout model
    var appDelegate: AppDelegate?
    var workoutData : WorkoutDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.workoutData = self.appDelegate?.workoutData
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workoutData?.workoutList.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath) as! WorkoutTableViewCell

        // gets users latitude and longitude from model and sets the coordinate
        let currentLat = self.workoutData?.workoutList[indexPath.row].latitude
        let currentLong = self.workoutData?.workoutList[indexPath.row].longitude
        let userCoordinate = CLLocationCoordinate2DMake(currentLat ?? 0.0, currentLong ?? 0.0)
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: userCoordinate,span: span)
        // creates an annotation to be displayed on the map
        let annotation = MKPointAnnotation()
        annotation.title = self.workoutData?.workoutList[indexPath.row].title
        annotation.subtitle = self.workoutData?.workoutList[indexPath.row].currDate
        annotation.coordinate = userCoordinate

        //Configure the cell...
        cell.titleLabel?.text = self.workoutData?.workoutList[indexPath.row].title
        cell.numSetsLabel?.text = self.workoutData?.workoutList[indexPath.row].setNum
        cell.setTimeLabel?.text = self.workoutData?.workoutList[indexPath.row].setTime
        cell.totalTimeLabel?.text = self.workoutData?.workoutList[indexPath.row].totalTime
        cell.dateLabel?.text = self.workoutData?.workoutList[indexPath.row].currDate
        cell.timeLabel?.text = self.workoutData?.workoutList[indexPath.row].currTime
        
        // code for setting the map view and adding the annotation
        cell.mapView?.setCenter(userCoordinate, animated: true)
        cell.mapView?.setRegion(region, animated: true)
        cell.mapView?.addAnnotation(annotation)

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tableView = self.tableView {
            tableView.reloadData()
            tableView.rowHeight = 300
        }
    }
}
