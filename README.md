# HiiTWorkoutTrainer-IOS
개인용 운동 설정 및 기록이 가능한 ios기반 어플리케이션 (with 타이머)

General Description of App:

 This app is based around providing modern fitness enthusiasts an app that helps them perform
 and track timed HIIT (high intensity interval training) workouts. It allows a user to choose
 their workout length, interval length, and work to rest ratio within their interval. Then it
 plays your workout and beeps in between every work and rest period. This application will
 also send you a notification daily if you have not completed your workout before a given time
 on that day. From the timer screen, you will also be able to view a detailed history of your past 
 workouts after you have completed the current one. Finally, the user will be able to switch between 
 the data entry and timer screens using a tab bar, and view the workout history table using a 
 relationship segue.

Programming Environment Used:
	
	- To complete this project, I used Xcode version 13.2.1
	- External hardware IS NOT required to run and test this application
	- The iPhone 11 simulator was used to test this application

Application Feature List:

	- MapKit Framework: WorkoutTableViewCell.swift, WorkoutTableViewController.swift

	- Core Location Framework: DataEntryViewController.swift, WorkoutTableViewController.swift

	- SpriteKit Framework: WorkOutImages.atlas, StickmanScene.swift, WorkoutViewController.swift

	- User Notifications: DataEntryViewController.swift

	- Persistent Storage: AppDelegate.swift, DataEntryViewController.swift

	- Data entry functionality: DataEntryViewController.swift

	- Timer functionality: WorkoutViewController.swift

	- Workout trainer functionality: WorkoutViewController.swift

	- Workout audio alert: WorkoutViewController.swift

	- Workout history functionality: WorkoutTableViewController.swift, WorkoutTableViewCell.swift

	- Workout data model structure: DataEntryViewController.swift, WorkoutDataModel.swift, WorkoutTableViewController.swift, AppDelegate.swift, WorkoutViewController.swift

