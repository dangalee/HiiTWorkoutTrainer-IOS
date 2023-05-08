//
//  WorkoutTableViewCell.swift
//  HIITWorkoutTrainer
//
//Submission Date : 04/24/22 11:59 pm
//Team : a02section300team04
//Members:
//  Jordan Keyser jekeyser@iu.edu
//  Jungmin Lee jle18@iu.edu
//  Suriya Narayanasamy surnara@iu.edu



import UIKit
import MapKit  

class WorkoutTableViewCell: UITableViewCell {

    // view outlets for table view cell
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numSetsLabel: UILabel!
    @IBOutlet weak var setTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

