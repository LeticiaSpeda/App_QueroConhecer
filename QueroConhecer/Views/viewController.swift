//
//  viewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 04/11/22.
//

import UIKit
import MapKit

final class ViewController: UIViewController {
    
    private lazy var viewColor: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1011282429, green: 0.7283702493, blue: 0.8918107748, alpha: 1)
        view.enableCode()
        return view
    }()
    
    private lazy var search: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "O que você deseja buscar? "
        search.barTintColor = #colorLiteral(red: 0.08193505555, green: 0.728433311, blue: 0.8918333054, alpha: 1)
        search.searchTextField.backgroundColor = .white
        search.layer.cornerRadius = 5
        search.enableCode()
        return search
    }()
    
    private lazy var mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.enableCode()
        return stack
    }()
    
    private lazy var searchMapView: MKMapView = {
        let map = MKMapView()
        map.enableCode()
        return map
    }()
    
    private lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.enableView()
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    @objc func handleFinishButton(){
        dismiss(animated: true, completion: nil)
    }
    
    private func commonInit() {
        configureHierarchy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureHierarchy() {
        
        view.addSubview(viewColor)
        viewColor.addSubview(search)
        viewColor.addSubview(mainVStack)
        mainVStack.addArrangedSubview(searchMapView)
        mainVStack.addArrangedSubview(testView)
        
        
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            
            viewColor.topAnchor.constraint(equalTo: view.topAnchor),
            viewColor.leftAnchor.constraint(equalTo: view.leftAnchor),
            viewColor.rightAnchor.constraint(equalTo: view.rightAnchor),
            viewColor.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            search.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            search.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            search.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            search.bottomAnchor.constraint(equalTo: mainVStack.topAnchor, constant: -10),
            
            mainVStack.topAnchor.constraint(equalTo: search.bottomAnchor, constant: 10),
            mainVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainVStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),

            searchMapView.heightAnchor.constraint(equalToConstant: 370),
            
            testView.heightAnchor.constraint(equalToConstant: 250)
            
            
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
