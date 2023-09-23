//
//  CharactersListInteractor.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
class CharactersListInteractor: CharactersListInteractorProtocol {
    var presenter: CharactersListPresenterProtocol?
    func loadCharacters(completion: @escaping (CharacterObjectResponse?) -> Void) {
        self.loadFromServer { characters  in
            completion(characters)
        }
    }
    func loadFromServer(completion: @escaping (CharacterObjectResponse?) -> Void) {
        if let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\((self.presenter?.page ?? 1))") {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let _ = error {
                    completion(nil)
                }
                if let jsonData = data {
                    let responseList: CharacterObjectResponse = try! JSONDecoder().decode(CharacterObjectResponse.self, from: jsonData)
                    DispatchQueue.main.async {
                        //self.save(banks: banksList)
                    }
                    
                    completion(responseList)
                }
            }
            
            urlSession.resume()
        }
    }
}
