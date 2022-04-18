//
//  ViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 1/23/22.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    //var db:DBHelper = DBHelper()
    @IBOutlet var login: UIButton!
    @IBOutlet var createAccount: UIButton!
    @IBOutlet var loginWithFB: UIButton!



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // ACTIONS
    
    
    @IBAction func loginAction() {
        performSegue(withIdentifier: "Login_Segue", sender: nil)
    }
    // action function for user login
    // read user name and password... find in database
    // if not found, clear text fields and display incorrect username or password
    // if found, segue to home screen
    
    @IBAction func createProfile() {
        performSegue(withIdentifier: "CreateAccount_Segue", sender: nil)
    }
    // action function for create profile
    // read user info... check for user name availability
    // create new user in db
    // example db.insert(id: 1, firstName: "Melanie", lastName, "Kramer")
    // segue to home screen
    
    //@IBAction func loginWithFB() {}
    // action function for login with facebook
    // i do not know what to do here
    // init func and catch the data recieved

}
 /*
// location manager delegate
// https://www.thorntech.com/how-to-search-for-location-using-apples-mapkit/
extension ViewController : CLLocationManagerDelegate {
    // called when the user responds to permission dialog
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
        locationManager.requestLocation()
    }
}
    // called when location information comes back
    // recieve array of locations, only need the first one
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: (location)")
        }
    }
    // error
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}
*/

private extension MKMapView {
    func centerToLocation( _ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
