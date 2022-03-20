//
//  MapViewController.swift
//  FoodiGram
//
//  Created by Melanie Kramer on 1/24/22.
//
// control + i to fix spacing

import Foundation

import UIKit
import MapKit
import CoreLocation
import CryptoKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    var restaurantRequest = MKLocalSearch.Request()
    var coffeeRequest = MKLocalSearch.Request()
    var bakeryRequest = MKLocalSearch.Request()
    var selectedAnnotation: MKPointAnnotation?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.frame = view.bounds
        // St Pete coordinates
        let coordinate = CLLocationCoordinate2D(latitude: 27.7676, longitude: -82.6403)
        mapView.setRegion(MKCoordinateRegion(center:coordinate, span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
        //checkLocationServices()
        locationManager.delegate = self
        locationManager.requestLocation()
        postAnnotations()
    }
    
    
    func postAnnotations() {
        restaurantRequest.naturalLanguageQuery = "restaurant"
        coffeeRequest.naturalLanguageQuery = "coffee"
        bakeryRequest.naturalLanguageQuery = "bakery"
        restaurantRequest.region = self.mapView.region
        
        let restaurantSearch = MKLocalSearch(request: restaurantRequest)
        restaurantSearch.start { response , error in
            guard let response = response else {
                print("Error")
                return
            }
            for item in response.mapItems {
                //self.mapView.addAnnotation(item)
                //print(item.name ?? "No name")
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                // show annotations
                self.mapView.addAnnotation(annotation)
            }
        }
        let coffeeSearch = MKLocalSearch(request: coffeeRequest)
        coffeeSearch.start { response , error in
            guard let response = response else {
                print("Error")
                return
            }
            for item in response.mapItems {
                //self.mapView.addAnnotation(item)
                //print(item.name ?? "No name")
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
            }
        }
        let bakerySearch = MKLocalSearch(request: bakeryRequest)
        bakerySearch.start { response , error in
            guard let response = response else {
                print("Error")
                return
            }
            for item in response.mapItems {
                //self.mapView.addAnnotation(item)
                //print(item.name ?? "No name")
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
            }
        }
    
    }
    // for segue to make post controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MakePostViewController {
            let san = segue.destination as? MakePostViewController
            san?.locName = (selectedAnnotation?.title)!
            let sac = segue.destination as? MakePostViewController
            sac?.locCoor = selectedAnnotation?.coordinate
        }
    }
    // update when user changes map view region
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("region changed")
        mapView.removeAnnotations(mapView.annotations)
        postAnnotations()
    }
    // remove annotations
   // func removeAnnotations(_ annotations: [MKAnnotation]) {}
    // POINT ANNOTATION HOLDS THE DATA
    // ANOTATION VIEW PERIPHERAL DATA, CUSTOM PHOTOS AND IMAGES
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // THIS WAS THE ANNOTATION ERROR I HAD RETURNED NIL FOR MKPOINTANNOTATION
        if !(annotation is MKUserLocation) {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            //annotationView.image =  UIImage(named: "soccerball")
            annotationView?.isEnabled = true
            //annotationView.tintColor = UIColor.blue
            annotationView?.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
            // annotationView!.tintColor = UIColor.blue
        } else {
            annotationView?.annotation = annotation
        }
        let pinImage = UIImage(named: "donut")
        annotationView!.image = pinImage
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.canShowCallout = true
        let btn = UIButton(type: .detailDisclosure)
        view.rightCalloutAccessoryView = btn
        self.selectedAnnotation = view.annotation as? MKPointAnnotation
        // DONT DELETE THE IMAGE LINES
        //let pinImage = UIImage(named: "donut")
        //view.image = pinImage
        //view.annotation = annotation
    }
    
    // for user tap action on callout button
    func mapView(_ mapView: MKMapView,annotationView view: MKAnnotationView,
                          calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "makePost_Segue", sender: nil)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //guard let location = locations.last else { return }
        // VIEW RADIUS
        /*let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 18000, longitudinalMeters: 18000)
        mapView.setRegion(region, animated: true)*/
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
        }
        postAnnotations()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
      
    
       
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            followUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show alert
            break
        case .authorizedAlways:
            break
        
        }
    }
    
    // MAKE SURE LOCATION TRAKCING IS ON
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
               // the user didn't turn it on
        }
    }
       
    func followUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 8000, longitudinalMeters: 8000)
            mapView.setRegion(region, animated: true)
        }
    }
       
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
                         CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
       
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
}
