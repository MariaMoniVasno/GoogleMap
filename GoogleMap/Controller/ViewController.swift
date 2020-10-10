//
//  ViewController.swift
//  GoogleMap
//
//  Created by developer on 10/10/20.
//  Copyright © 2020 WeFour. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreTelephony

class ViewController: UIViewController {
        
    var googleMapView = GMSMapView()
    @IBOutlet var pickupLbl : UILabel!
    @IBOutlet var dropLbl : UILabel!
    @IBOutlet var customerNameLbl : UILabel!
    @IBOutlet var callBtn : UIButton!
    @IBOutlet var locationView : UIView!
    @IBOutlet var customerDetailsView : UIView!
    //View Model
    private let viewModel = OrderDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Trip In Progress"
        //readJsonFile
        viewModel.readJsonFile()
        mapProperties()
    }
    //MARK:- GoogleMapView Properties
    func mapProperties(){
        //Camera Position
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees((viewModel.getInfo?.customer_lat)!)!, longitude: CLLocationDegrees((viewModel.getInfo?.customer_lng)!)!, zoom: 11)
        googleMapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view.addSubview(googleMapView)
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = true
        

        //PickUp and Drop Marker
        let pickUpMarker = GMSMarker()
        pickUpMarker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees((viewModel.getInfo?.customer_lat)!)! , longitude: CLLocationDegrees((viewModel.getInfo?.customer_lng)!)!)
        pickUpMarker.map = googleMapView

        let dropMarker = GMSMarker()
        dropMarker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees((viewModel.getInfo?.warehouse_lat)!)!, longitude: CLLocationDegrees((viewModel.getInfo?.warehouse_lng)!)!)
        dropMarker.map = googleMapView
        view = googleMapView
        
        //Draw the route from pickup & drop
        fetchRoute(from: CLLocationCoordinate2D(latitude: CLLocationDegrees((viewModel.getInfo?.customer_lat)!)!, longitude: CLLocationDegrees((viewModel.getInfo?.customer_lng)!)!), to: CLLocationCoordinate2D(latitude: CLLocationDegrees((viewModel.getInfo?.warehouse_lat)!)!, longitude: CLLocationDegrees((viewModel.getInfo?.warehouse_lng)!)!))
        //Constraints for Custom View
        customViewProperties()
    }
    //Draw the route from pickup & drop
    func fetchRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
         
         let session = URLSession.shared
         let apiKey = "AIzaSyAKRlXIiYU1eYxh28ytahC4LIsXcsfVKo4"
         let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=\(apiKey)")!

     
             let task = session.dataTask(with: url, completionHandler: {
                     (data, response, error) in

                     guard error == nil else {
                         print(error!.localizedDescription)
                         return
                     }

                     guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] else {

                         print("error in JSONSerialization")
                         return

                     }

                     guard let routes = jsonResult["routes"] as? [Any] else {
                         return
                     }

                     guard let route = routes[0] as? [String: Any] else {
                         return
                     }

                     guard let legs = route["legs"] as? [Any] else {
                         return
                     }

                     guard let leg = legs[0] as? [String: Any] else {
                         return
                     }

                     guard let steps = leg["steps"] as? [Any] else {
                         return
                     }
                       for item in steps {

                         guard let step = item as? [String: Any] else {
                             return
                         }

                         guard let polyline = step["polyline"] as? [String: Any] else {
                             return
                         }

                         guard let polyLineString = polyline["points"] as? String else {
                             return
                         }

                         //Call this method to draw path on map
                         DispatchQueue.main.async {
                             self.drawPath(from: polyLineString)
                         }

                     }
                 })
                 task.resume()
     }
     
     func drawPath(from polyStr: String){
         let path = GMSPath(fromEncodedPath: polyStr)
         let polyline = GMSPolyline(path: path)
         polyline.strokeWidth = 3.0
         polyline.strokeColor = UIColor.black
         polyline.map = googleMapView
     }
    //MARK:-Constraints for Custom View locationView & customerDetailsView
    func customViewProperties(){
       var layoutDic = [String:AnyObject]()
        //LocationView
        layoutDic["locationView"] = locationView
        googleMapView.addSubview(locationView)
        googleMapView.bringSubviewToFront(locationView)
        locationView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[locationView]-(10)-|", options: [], metrics: nil, views: layoutDic))
        googleMapView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(120)-[locationView(80)]", options: [], metrics: nil, views: layoutDic))
        //CustomerDetailsView
        layoutDic["customerDetailsView"] = customerDetailsView
        googleMapView.addSubview(customerDetailsView)
        googleMapView.bringSubviewToFront(customerDetailsView)
        customerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        googleMapView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(10)-[customerDetailsView]-(10)-|", options: [], metrics: nil, views: layoutDic))
        googleMapView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[customerDetailsView(60)]-(110)-|", options: [], metrics: nil, views: layoutDic))
       
        //Location Text
        lblProperties(lbl: pickupLbl, str: "PickUp Location: \((viewModel.getInfo?.customer_address)!)")
        lblProperties(lbl: dropLbl, str: "Drop Location: \((viewModel.getInfo?.warehouse_address)!)")
        lblProperties(lbl: customerNameLbl, str: "Customer Name: \((viewModel.getInfo?.customer_name)!)")

        //CallBtn
        callBtn.addTarget(self, action: #selector(callBtnAction), for: .touchUpInside)
        callBtn.setTitle("\(viewModel.getInfo?.customer_mobile! ?? "1234567890")", for: .normal)
        callBtn.contentHorizontalAlignment = .center
    }
    //callbtn action
    @objc func callBtnAction(){
        //Sim is there,Trying to call the number
        let customerMobileNumber = viewModel.getInfo?.customer_mobile
        guard let number = URL(string: "tel://" + "\(customerMobileNumber ?? "1234567890")") else { return }
        UIApplication.shared.open(number)
            
    }
    //Label properties
    func lblProperties(lbl : UILabel, str : String){
        lbl.backgroundColor = UIColor.clear
        lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        lbl.text = str
        lbl.adjustsFontSizeToFitWidth = true
    }
}

