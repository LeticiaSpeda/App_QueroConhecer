//
//  PlacesViewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 02/11/22.
//

import UIKit

final class PlaceFinderViewController: UIViewController {
    
    private lazy var placeView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            placeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            placeView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            placeView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            placeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    
    private func configureStyle() {
        view.backgroundColor = .gray.withAlphaComponent(1.0)
    }
}
