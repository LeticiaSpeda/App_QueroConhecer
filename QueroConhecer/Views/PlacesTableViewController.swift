//
//  ViewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 01/11/22.
//

import UIKit

final class PlacesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        tableView.register(PlacesTableViewCell.self, forCellReuseIdentifier: PlacesTableViewCell.identifier)
    }
    
    private func configureStyle() {
        view.backgroundColor = .white.withAlphaComponent(0.9)
        navigationItem.title = "Quero Conhecer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white.withAlphaComponent(0.5)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int{
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: PlacesTableViewCell.identifier,
            for: indexPath
        ) as? PlacesTableViewCell {
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = PlaceFinderViewController()
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true)
    }
    
}

