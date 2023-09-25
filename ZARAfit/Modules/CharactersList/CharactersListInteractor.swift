//
//  CharactersListInteractor.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
class CharactersListInteractor: CharactersListInteractorProtocol {
    var presenter: CharactersListPresenterProtocol?
    func loadCharacters(completion: @escaping (Result<CharacterObjectResponse?, Error>) -> Void) {
        loadFromServer { result in
            switch result {
            case .success(let characters):
                completion(.success(characters))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func loadFromServer(completion: @escaping (Result<CharacterObjectResponse?, Error>) -> Void) {
        guard let page = presenter?.page else {
            completion(.failure(NetworkError.invalidInput))
            return
        }
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let jsonData = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let responseList = try JSONDecoder().decode(CharacterObjectResponse.self, from: jsonData)
                completion(.success(responseList))
            } catch {
                completion(.failure(error))
            }
        }
        urlSession.resume()
    }
}
