//
//  PlacesViewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 02/11/22.
//

import UIKit
import MapKit

protocol PlaceFinderDelegate: AnyObject {
    func addPlace(_ place: Place)
}

final class PlaceFinderViewController: UIViewController {
    var place: Place?
    weak var delegate: PlaceFinderDelegate?
    
    enum PlaceFinderMessageType {
        case error(String)
        case confirmation(String)
    }
    
    private lazy var placeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.enableView()
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        button.enableView()
        return button
    }()
    
    private lazy var placeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite o nome do local que você deseja conhecer..."
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.enableView()
        return label
    }()
    
    private lazy var locationMapLabel: UILabel = {
        let label = UILabel()
        label.text = "...ou escolha tocando no mapa \npor 2 segundos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.enableView()
        return label
    }()
    
    private lazy var locationMapTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Digite a localização..."
        tf.textColor = .gray
        tf.backgroundColor = .white
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.cornerRadius = 6
        tf.enableView()
        return tf
    }()
    
    private lazy var findCity: UIButton = {
        let button = UIButton()
        button.setTitle("Escolher", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7127103806, blue: 0.8802782297, alpha: 1)
        button.layer.cornerRadius = 6
        button.enableView()
        button.addTarget(self, action: #selector(searchButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.enableView()
        return map
    }()
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.9)
        view.enableView()
        view.isHidden = true
        return view
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView(style: .large)
        load.color = #colorLiteral(red: 0, green: 0.7127104998, blue: 0.8844717741, alpha: 1)
        load.startAnimating()
        load.enableView()
        return load
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        let gesture = UILongPressGestureRecognizer(
            target: self, action: #selector(getLocation(_:))
        )
        gesture.minimumPressDuration = 2.0
        mapView.addGestureRecognizer(gesture)
    }
    
    @objc func handleCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func searchButton() {
        guard let address = locationMapTextField.text else { return }
        view.endEditing(true)
        load(show: true)
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { [weak self] placemarks, error in
            guard let self = self else { return }
            self.load(show: false)
            self.handlePlacemark(placemarks: placemarks, error: error)
        }
    }
    
    @objc func getLocation(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            
            let point = gesture.location(in: mapView)
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
            load(show: true)
            CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
                guard let self = self else { return }
                self.load(show: false)
                self.handlePlacemark(placemarks: placemarks, error: error)
            }
        }
    }
    
    private func handlePlacemark(placemarks: [CLPlacemark]?, error: Error?) {
        if error == nil {
            let hasNoLocal = !self.savePlace(with: placemarks?.first)
            if hasNoLocal{
                self.showManage(type: .error("Não foi encontrado nenhum local com esse nome"))
            }
        } else {
            self.showManage(type: .error("Erro desconhecido"))
        }
    }
    
    private func savePlace(with placemark: CLPlacemark?) -> Bool {
        guard let placemark = placemark, let coordinate = placemark.location?.coordinate else { return false }
        
        let name = placemark.name ?? placemark.country ?? "Desconhecido"
        let address = Place.getFormatedAddress(with: placemark)
        place = Place(
            name: name,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            address: address
        )
        
        let regiom = MKCoordinateRegion(
            center: coordinate, latitudinalMeters: 3500,
            longitudinalMeters: 3500
        )
        mapView.setRegion(regiom, animated: true)
        
        self.showManage(type: .confirmation(place?.name ?? " "))
        
        return true
    }
    
    private func load(show: Bool) {
        loadingView.isHidden = !show
        if show {
            loading.startAnimating()
        } else {
            loading.stopAnimating()
        }
    }
    
    private func showManage(type: PlaceFinderMessageType) {
        let title: String, message: String
        var hasConfirmation: Bool = false
        
        switch type {
        case .confirmation(let name):
            title = "Local encontrado"
            message = "Deseja adicionar \(name)"
            hasConfirmation = true
        case .error(let errorMessage):
            title = "Erro"
            message = errorMessage
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        alert.addAction(cancelAction)
        if hasConfirmation {
            let confirmeAction = UIAlertAction(title: "OK", style: .default) { (action) in
                self.delegate?.addPlace(self.place ?? .init(name: " ", latitude: 0, longitude: 0, address: " "))
                self.dismiss(animated: true)
                
            }
            alert.addAction(confirmeAction )
        }
        present(alert, animated: true)
    }
    
    private func commonInit() {
        configureHierarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureHierarchy() {
        view.addSubview(placeView)
        placeView.addSubview(placeNameLabel)
        placeView.addSubview(locationMapLabel)
        placeView.addSubview(locationMapTextField)
        placeView.addSubview(findCity)
        placeView.addSubview(mapView)
        placeView.addSubview(loadingView)
        placeView.addSubview(closeButton)
        loadingView.addSubview(loading)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            placeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            placeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            placeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            placeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            closeButton.topAnchor.constraint(equalTo: placeView.topAnchor, constant: -14),
            closeButton.rightAnchor.constraint(equalTo: placeView.rightAnchor, constant: 8),
            
            placeNameLabel.topAnchor.constraint(equalTo: placeView.topAnchor, constant: 20),
            placeNameLabel.leftAnchor.constraint(equalTo: placeView.leftAnchor, constant: 30),
            placeNameLabel.rightAnchor.constraint(equalTo: placeView.rightAnchor, constant: -30),
            
            locationMapLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 90),
            locationMapLabel.centerXAnchor.constraint(equalTo: placeNameLabel.centerXAnchor),
            locationMapLabel.leftAnchor.constraint(equalTo: placeView.leftAnchor, constant: 30),
            locationMapLabel.rightAnchor.constraint(equalTo: placeView.rightAnchor, constant: -30),
            
            
            locationMapTextField.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 30),
            locationMapTextField.leftAnchor.constraint(equalTo: placeView.leftAnchor, constant: 10),
            locationMapTextField.rightAnchor.constraint(equalTo: findCity.leftAnchor, constant: -10),
            locationMapTextField.heightAnchor.constraint(equalToConstant: 30),
            
            findCity.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: 30),
            findCity.leftAnchor.constraint(equalTo: locationMapTextField.rightAnchor, constant: 10),
            findCity.rightAnchor.constraint(equalTo: placeNameLabel.rightAnchor, constant: -10),
            findCity.widthAnchor.constraint(equalToConstant: 80),
            
            mapView.topAnchor.constraint(equalTo: locationMapLabel.bottomAnchor, constant: 20),
            mapView.leftAnchor.constraint(equalTo: placeView.leftAnchor, constant: 10),
            mapView.rightAnchor.constraint(equalTo: placeView.rightAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: placeView.bottomAnchor, constant: -10),
            
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            
            loading.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
        ])
    }
    
    private func configureStyle() {
        view.backgroundColor = .gray.withAlphaComponent(1.0)
    }
}

extension UIView {
    func enableView() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
