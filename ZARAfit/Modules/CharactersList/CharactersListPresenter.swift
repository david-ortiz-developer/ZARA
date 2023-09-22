//
//  CharactersListPresenter.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import Foundation
class CharactersListPresenter: CharactersListPresenterProtocol {
    var interactor: CharactersListInteractorProtocol?
    var router: CharactersListRouterProtocol?
    var view: CharactersListViewControllerProtocol?
    
    var characters: [CharacterObject]?
    
    func listCharacters() {
        self.view?.showLoader()
        self.interactor?.loadCharacters { result in
            if let responseList = result {
                self.characters = responseList.results
            }
            DispatchQueue.main.async {
                self.view?.reloadTable()
                self.view?.hideLoader()
            }
        }
    }
}
