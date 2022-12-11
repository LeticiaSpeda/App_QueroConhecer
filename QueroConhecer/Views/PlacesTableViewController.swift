//
//  ViewController.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 01/11/22.
//
import MapKit
import UIKit

final class PlacesTableViewController: UITableViewController {
    var places: [Place] = []
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        loadPlaces()
        tableView.register(
            PlacesTableViewCell.self,
            forCellReuseIdentifier: PlacesTableViewCell.identifier
            
        )
    }
    
    private func loadPlaces() {
        if let placesData = ud.data(forKey: "places") {
            do {
                places = try JSONDecoder().decode(
                    [Place].self, from: placesData
                )
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func savePlaces() {
        let json = try? JSONEncoder().encode(places)
        ud.set(json, forKey: "places")
    }

    private func configureStyle() {
        view.backgroundColor = .white.withAlphaComponent(0.9)
        navigationItem.title = "Quero Conhecer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white.withAlphaComponent(0.5)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.rightBarButtonItem = .init(
            image: .init(systemName: "plus"),
            style: .plain, target: self,
            action: #selector(addRoute)
        )
    }

    @objc func addRoute() {
        let controller = PlaceFinderViewController()
        controller.delegate = self
        controller.modalPresentationStyle = .overFullScreen
        controller.modalTransitionStyle = .crossDissolve
        self.present(controller, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{

        return places.count
    }

    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTableViewCell.identifier,
            for: indexPath) as? PlacesTableViewCell {
            let place = places[indexPath.row]
            cell.titleLabel.text = place.name
            return cell
        }
        return UITableViewCell()
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let controller = ViewController()
        let navigation = UINavigationController(rootViewController: controller)
        navigation.modalPresentationStyle = .overFullScreen
        present(navigation, animated: true)
    }
}

extension PlacesTableViewController: PlaceFinderDelegate {
    func addPlace(_ place: Place) {
        if !places.contains(place){
            places.append(place)
            savePlaces()
            tableView.reloadData()
        }
    }
}
