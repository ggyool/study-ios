//
//  ViewController.swift
//  MapKitExam
//
//  Created by ggyool on 2020/10/25.
//

import UIKit
import MapKit

// 37.5636, 126.9789

// 37.5609, 126.9985
// 37.5631, 127.0026
// 37.5591, 127.0029

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManger = CLLocationManager()
    var myLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var finishLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
        mapView.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest // 미터 단위 입력로 입력 가능
        // locationManger.distanceFilter = // 새로 측정하는 최소 이동거리 (가만히 있으면 측정이 필요 없는 경우)
        self.mapView.showsUserLocation = true
        //        self.mapView.setUserTrackingMode(.follow, animated: false)
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressMapView(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func touchUpMyLocationButton(_ sender: Any) {
        self.setReginWithMyLocation()
    }
    
    @objc func longPressMapView(_ sender: UITapGestureRecognizer) {
        let point: CGPoint = sender.location(in: mapView)
        let coordinate: CLLocationCoordinate2D = mapView.convert(point, toCoordinateFrom: mapView)
        makeAnnotation(coordinate)
        print("touch: ", coordinate)
    }
    
    func setReginWithMyLocation() {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 0.01 - 100배 확대
        let region: MKCoordinateRegion = MKCoordinateRegion(center: self.myLocation, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func touchUpSearchButton(_ sender: Any) {
        let leftTopCoordinate: CLLocationCoordinate2D = mapView.convert(.zero, toCoordinateFrom: mapView)
        let rightBottomCoordinate: CLLocationCoordinate2D =
            mapView.convert(CGPoint(x: mapView.frame.width, y: mapView.frame.height), toCoordinateFrom: mapView)
        print("leftTop: ", leftTopCoordinate)
        print("rightBottom: ", rightBottomCoordinate)
    }
    
    // 해당 위치에 어노테이션을 만든다.
    func makeAnnotation(_ coordinate: CLLocationCoordinate2D) {
        let truck = Truck()
        truck.coordinate = coordinate
        truck.title = "군밤"
        truck.subtitle = "3000원"
        truck.up = 10
        truck.down = 5
        mapView.addAnnotation(truck)
    }
}

// CLLocationManagerDelegate
extension ViewController {
    // 권한 변화에 따른 동작
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("승인")
            locationManger.startUpdatingLocation()
        case .denied:
            print("거부")
        case .notDetermined:
            print("결정x")
            locationManger.requestWhenInUseAuthorization()
        case .restricted:
            print("제한")
        default:
            print("ios 업데이트로 새로 생긴 값")
        }
    }
    
    // location 변화에 따른 동작
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 배열 형태로 전달 되는데, 대부분 1개의 데이터만 넘어온다.
        // 특별한 경우 (ex. 한번에 전달이 안 된 경우) 두개 이상의 객체가 전달 될 수 있다.
        // coordinate, altitude, timestamp...
        let location: CLLocation = locations.last!
        let coordinate = location.coordinate
        self.myLocation = coordinate
        if(finishLoaded==false) {
            finishLoaded = true
            self.setReginWithMyLocation()
        }
        print(self.myLocation)
    }
    
    // 측정 에러가 생길시 동작
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}


// MKMapViewDelegate
extension ViewController {
    // 네트워크를 통해 map을 받아오는 중 에러 mapViewDelegate
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print(userLocation)
    }
    
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//        print("run")
    }
    
    // 어노테이션에 따라 해당하는 뷰를 반환
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(annotation is Truck) {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "TRUCK")
            if(annotationView==nil) {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "TRUCK")
                annotationView?.canShowCallout = true
                // annotationView?.leftCalloutAccessoryView = ??
                // annotationView?.rightCalloutAccessoryView = ??
                annotationView?.image = UIImage(named: "밤_작은")
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
}
