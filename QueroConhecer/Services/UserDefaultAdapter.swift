//
//  UserDefaultAdapter.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 22/12/22.
//

import Foundation

protocol LocalDataBase {
    func fetch(forKey key: String) -> [Place]
    func register(forKey key: String, places: [Place])
}

final class UserDefaultAdapter: LocalDataBase {
    let ud = UserDefaults.standard
    
    func fetch(forKey key: String) -> [Place] {
        if let placesData = ud.data(forKey: key) {
            do {
                return try JSONDecoder().decode(
                    [Place].self, from: placesData
                )
            } catch {
                return []
            }
        }
        
        return []
    }

    func register(forKey key: String, places: [Place]) {
        let json = try? JSONEncoder().encode(places)
        ud.set(json, forKey: key)
    }
}

//Codable: Faz os dois
//Encodable: Codigo(Estrutura) -> Data
//Decodable: Data -> Codigo(Estrutura)
