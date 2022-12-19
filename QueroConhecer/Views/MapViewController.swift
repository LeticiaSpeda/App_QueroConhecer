//
//  viewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 04/11/22.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    var places: [Place] = []
    
    static let identifier = String(describing: MapViewController.self)
    
    private lazy var viewColor: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1011282429, green: 0.7283702493, blue: 0.8918107748, alpha: 1)
        view.enableCode()
        return view
    }()
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.enableCode()
        return stack
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "O que você deseja buscar? ",
            attributes: [NSAttributedString.Key.foregroundColor:
                    UIColor.black.withAlphaComponent(0.5)]
        )
        search.searchTextField.leftView?.tintColor = .black.withAlphaComponent(0.5)
        search.barTintColor = #colorLiteral(red: 0.08193505555, green: 0.728433311, blue: 0.8918333054, alpha: 1)
        search.searchTextField.backgroundColor = .white
        search.layer.cornerRadius = 5
//        search.isHidden = true
        search.enableCode()
        return search
    }()
    
    
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.layer.cornerRadius = 10
        map.enableCode()
        return map
    }()
    
    private lazy var infoVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.enableCode()
        return stack
    }()
    
    private lazy var infoMapView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
//        view.isHidden = true
        view.enableView()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.enableCode()
        return label
    }()
    
    private lazy var andressLabel: UILabel = {
        let label = UILabel()
        label.text = "Endereço:"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 6
        label.enableCode()
        return label
    }()
    
    private lazy var traceRoutesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Traçar Rotas", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.08193505555,
                                           green: 0.728433311,
                                           blue: 0.8918333054,
                                           alpha: 1), for: .normal)
        button.enableCode()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        
        if places.count == 1 {
            title = places[0].name
        } else {
            title = "Meus lugares 🚗💨"
        }
        
        for place in places {
            addToMap(place)
        }
    }
    
    @objc func handleFinishButton(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func searchMap() {
        
    }
    
    private func commonInit() {
        configureHierarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func addToMap(_ place: Place ) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = place.coordinate
        annotation.title = place.name
        mapView.addAnnotation(annotation)
    }
    
    private func showPlaces() {
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    private func configureHierarchy() {
        view.addSubview(viewColor)
        viewColor.addSubview(mainVStack)
        mainVStack.addArrangedSubview(searchBar)
        mainVStack.addArrangedSubview(mapView)
        mainVStack.addArrangedSubview(infoMapView)
        mainVStack.addArrangedSubview(UIView())
        infoMapView.addSubview(infoVStack)
        infoVStack.addArrangedSubview(nameLabel)
        infoVStack.addArrangedSubview(andressLabel)
        infoVStack.addArrangedSubview(UIView())
        infoVStack.addArrangedSubview(traceRoutesButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            viewColor.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewColor.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewColor.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewColor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mainVStack.topAnchor.constraint(equalTo: viewColor.topAnchor, constant: 20),
            mainVStack.leadingAnchor.constraint(equalTo: viewColor.leadingAnchor, constant: 20),
            mainVStack.trailingAnchor.constraint(equalTo: viewColor.trailingAnchor, constant: -20),
            mainVStack.bottomAnchor.constraint(equalTo: viewColor.bottomAnchor, constant: -20),
            
            mapView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40),

            infoVStack.topAnchor.constraint(equalTo: infoMapView.topAnchor,constant: 5),
            infoVStack.leadingAnchor.constraint(equalTo: infoMapView.leadingAnchor,constant: 10),
            infoVStack.trailingAnchor.constraint(equalTo: infoMapView.trailingAnchor,constant: -10),
            infoVStack.bottomAnchor.constraint(equalTo: infoMapView.bottomAnchor),
        ])
    }
    
    private func configureStyle() {
        view.backgroundColor = .white
        navigationItem.title = "Teste"
        navigationItem.leftBarButtonItem = .init(
            image: .init(systemName: "chevron.left"),
            style: .plain, target: self,
            action: #selector(handleFinishButton)
        )
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = .init(image: .init(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchMap))
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white.withAlphaComponent(0.5)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

extension UIView {
    func enableCode() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
