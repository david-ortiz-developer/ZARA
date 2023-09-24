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
    var page = 1
    var totalPages = 1
    var loading = false
    
    func listCharacters() {
        if self.loading == false {
            self.view?.showLoader()
            self.loading = true
            self.interactor?.loadCharacters { result in
                if let responseList = result {
                    if self.page == 1 {
                        self.characters = responseList.results
                        self.totalPages = responseList.info.pages
                    } else {
                        self.characters?.append(contentsOf: responseList.results)
                    }
                }
                DispatchQueue.main.async {
                    self.view?.reloadTable()
                    self.view?.hideLoader()
                }
                self.loading = false
            }
        }
    }
    func showDetailfor(character: CharacterObject) {
        self.router?.showDetailView(for: character)
    }
}
