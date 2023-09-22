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
    
    func listCharacters() {
        self.view?.showLoader()
    }
}
