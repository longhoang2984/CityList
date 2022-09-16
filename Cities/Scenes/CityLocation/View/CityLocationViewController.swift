//
//  CityLocationViewController.swift
//  Cities
//
//  Created by Cửu Long Hoàng on 16/09/2022.
//

import UIKit
import SnapKit
import MapKit

class CityLocationViewController: UIViewController {
    
    private(set) var viewModel: CityLocationViewModel
    private var mapView: MKMapView = MKMapView()
    
    init(viewModel: CityLocationViewModel, nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        self.title = "\(viewModel.city.name), \(viewModel.city.country)"
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.leading.trailing.equalTo(view)
        }
        let viewRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.city.coord.lat, longitude: viewModel.city.coord.lon), latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(viewRegion, animated: false)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.city.coord.lat, longitude: viewModel.city.coord.lon)
        mapView.addAnnotation(annotation)
    }

}
