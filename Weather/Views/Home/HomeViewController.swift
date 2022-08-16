//
//  HomeViewController.swift
//  Weather
//
//  Created by Navi on 02/08/22.
//

import UIKit
import MapKit
import CoreLocation

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var mapView: MKMapView! {
        didSet {
            let region = MKCoordinateRegion(.world)
            mapView.setRegion(region, animated: true)
        }
    }
    @IBOutlet var tableView: UITableView!
    var places: [Place] = []
    var viewModel: HomeViewModelData = HomeViewModel()
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        setupUI()
    }
    
    // MARK: - Private methods
    private func setupUI() {
        setupDelegates()
        setGesture()
        addDefaultPins()
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        mapView.delegate = self
        viewModel.delegate = self
    }
    
    private func setGesture() {
        let longGesture = UILongPressGestureRecognizer(target: self,
                                                       action: #selector(didLongPress))
        mapView.addGestureRecognizer(longGesture)
    }
    
    private func addDefaultPins() {
        guard let bookmarks = viewModel.fetchBookmarks() else {
            return
        }
        places = bookmarks
        let defaultAnnotationsList = AnnotationManager.shared.getBookmarkPins(for: bookmarks)
        mapView.addAnnotations(defaultAnnotationsList)
    }
    
    @objc private func didLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(for: locationOnMap)
        }
    }
    
    // MARK: - Internal methods
    func addAnnotation(for location: CLLocationCoordinate2D){
        viewModel.findPlace(for: location)
    }
}
