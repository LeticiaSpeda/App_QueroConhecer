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
        view.backgroundColor = .white
        view.enableView()
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.enableCode()
        return label
    }()
    
    private lazy var andressLabel: UILabel = {
        let label = UILabel()
        label.text = "Endereço:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 6
        label.enableCode()
        return label
    }()
    
    private lazy var traceRoutesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Traçar Rotas", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.08193505555, green: 0.728433311, blue: 0.8918333054, alpha: 1), for: .normal)
        button.enableCode()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
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
    
    private func configureHierarchy() {
        
        view.addSubview(viewColor)
        viewColor.addSubview(search)
        viewColor.addSubview(mainVStack)
        mainVStack.addArrangedSubview(searchMapView)
        mainVStack.addArrangedSubview(testView)
        testView.addSubview(nameLabel)
        testView.addSubview(andressLabel)
        testView.addSubview(traceRoutesButton)
        
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
            
            testView.heightAnchor.constraint(equalToConstant: 250),
            
            nameLabel.topAnchor.constraint(equalTo: testView.topAnchor, constant: 15),
            nameLabel.leftAnchor.constraint(equalTo: testView.leftAnchor, constant: 15),
            
            andressLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 30),
            andressLabel.leftAnchor.constraint(equalTo: testView.leftAnchor, constant: 15),
            
            traceRoutesButton.bottomAnchor.constraint(equalTo: testView.bottomAnchor, constant: -6),
            traceRoutesButton.leftAnchor.constraint(equalTo: testView.leftAnchor, constant: 12),
            traceRoutesButton.rightAnchor.constraint(equalTo: testView.rightAnchor, constant: -12),
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
