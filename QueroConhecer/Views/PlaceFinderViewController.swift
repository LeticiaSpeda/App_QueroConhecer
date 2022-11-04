//
//  PlacesViewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 02/11/22.
//

import UIKit
import MapKit

final class PlaceFinderViewController: UIViewController {
    
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
        return view
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let load = UIActivityIndicatorView(style: .large)
        load.color = #colorLiteral(red: 0, green: 0.7127104998, blue: 0.8844717741, alpha: 1)
        load.startAnimating()
        load.enableView()
        return load
    }()
    
    @objc func handleCloseButton() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    private func commonInit() {
        configureHierarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureHierarchy() {
        view.addSubview(placeView)
        placeView.addSubview(closeButton)
        placeView.addSubview(placeNameLabel)
        placeView.addSubview(locationMapLabel)
        placeView.addSubview(locationMapTextField)
        placeView.addSubview(findCity)
        placeView.addSubview(mapView)
        placeView.addSubview(loadingView)
        loadingView.addSubview(loadingView)
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
            
            loadingView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
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
