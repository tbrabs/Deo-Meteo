//
//  LocationManager.swift
//  DeoMeteo
//
//  Created by Tristan on 04/01/2021.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject {
    
    private let locationManager = CLLocationManager()
    var location: CLLocation? = nil
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter  = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
    }
    
    func getLocationCityName(location: CLLocation, completion: @escaping ((String?) -> Void)) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let _ = error {
                print("Erreur avec le Geocoder")
                return
            }
            
            guard let placemark = placemarks?.first else {
                return
            }
            
            var cityName = ""
            
            if let city = placemark.locality {
                cityName = city
            }
            
            completion(cityName)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Wrong, \(error.localizedDescription)")
    }
}

