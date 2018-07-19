//
//  MapDisplayViewController.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import MapKit
import UIKit
enum MapViewType: Int {
    case stander
    case satellite
    case hybrid

    var mapType: MKMapType {
        switch self {
        case .stander: return .standard
        case .satellite: return .satellite
        case .hybrid: return .hybrid
        }
    }
}

class MapDisplayViewController: BaseViewController {

    // MARK: - IBOutlet

    @IBOutlet var mapView: MKMapView!

    // MARK: - Properties

    private var viewModel: VehiclesViewModel?
    private let regionRadius: CLLocationDistance = CLLocationDistance(Constants.Config.distance)
    // set initial location in Honolulu
    let initialLocation = CLLocation(latitude: Constants.Config.latitude, longitude: Constants.Config.longitude)

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.mapType = .standard
//        mapView.showsCompass = true
//        mapView.showsScale = true
//        let scale = MKScaleView(mapView: mapView)
//        scale.scaleVisibility = .visible // always visible

        // as we will change the UI, ensure it's on main thread
        DispatchQueue.main.async(execute: {
            // switch OFF the standard scale (otherwise both will be visible when zoom in/out)
            self.mapView.showsScale = false

            // build the view
            let scale = MKScaleView(mapView: self.mapView)

            // we want to use autolayout
            scale.translatesAutoresizingMaskIntoConstraints = false

            // scale should be visible all the time
            scale.scaleVisibility = .visible // always visible

            // add it to the map
            self.mapView.addSubview(scale)

            // get the current safe area of the map
            let guide = self.mapView.safeAreaLayoutGuide
            // Activate this array of constraints, which at the time removes leftovers if any
            NSLayoutConstraint.activate(
                [
                    // LEFT (I do not want a change if right-to-left language) margin with an offset to safe area
                    // alternative would be ".leadingAnchor", which switches to the right margin, if right-to-left language is used
                    scale.leftAnchor.constraint(equalTo: guide.leftAnchor, constant: 16.0),

                    // right edge will be the middle of the map
                    scale.rightAnchor.constraint(equalTo: guide.centerXAnchor),

                    // top margin is the top safe area
                    scale.topAnchor.constraint(equalTo: guide.topAnchor),

                    // view will be 20 points high
                    scale.heightAnchor.constraint(equalToConstant: 20.0)
                ]
            )
        })

        centerMapOnLocation(location: initialLocation)
        viewModel = VehiclesViewModel(dataProvider: DataProvider.share)
        viewModel?.delegate = self
        viewModel?.fetchData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func mapViewTypeValueChange(_ sender: Any) {
        guard let segment = sender as? UISegmentedControl else {
            return
        }
        guard let mapType = MapViewType(rawValue: segment.selectedSegmentIndex) else {
            return
        }
        mapView.mapType = mapType.mapType
    }

    // MARK: - Helper

    func drawPinsForVehicles(array: [Displayable]) {
        guard let vehicles = array as? [Vehicle] else {
            return
        }

        for vehicle in vehicles {
            guard let latitude = vehicle.latitude else {
                return
            }

            guard let longitude = vehicle.longitude else {
                return
            }

            guard let model = vehicle.modelName else {
                return
            }

            guard let name = vehicle.name else {
                return
            }

            addPinForLocations(latitude: latitude, longitude: longitude, title: model, subtitle: name)
        }
    }

    func addPinForLocations(latitude: Double, longitude: Double, title: String, subtitle: String) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - ViewModelDelegate

extension MapDisplayViewController: VehiclesViewModelDelegate {
    func successRetrivingResult() {
        guard let vehicles = viewModel?.dataSourceObjects else {
            return
        }
        drawPinsForVehicles(array: vehicles)
    }

    func failureRetrivingResult(error msg: String) {
    }
}

// MARK: - NavigationRouterProtocol

extension MapDisplayViewController: NavigationRouterProtocol {
    static func instantiateFromStoryboard() -> BaseViewController {
        let storyboard = Storyboards.Main.instance
        guard let viewController = storyboard.instantiateViewController(withIdentifier: self.Identity) as? MapDisplayViewController else {
            assertionFailure("can't instantiate object form storyboard for MapDisplayViewController")
            return self.init()
        }
        return viewController
    }
}
