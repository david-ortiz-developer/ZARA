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
        guard !loading else { return }
        loading = true
        
        view?.showLoader()
        interactor?.loadCharacters { [weak self] results in
            guard let self = self else { return }
            switch results {
            case .success(let characterObjectResponse):
                if let responseList = characterObjectResponse {
                    if self.page == 1 {
                        self.characters = responseList.results
                        self.totalPages = responseList.info.pages
                    } else {
                        self.characters?.append(contentsOf: responseList.results)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.view?.showErrorView()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.showErrorView()
                    print("failed \(error.localizedDescription)")
                }
            }
            DispatchQueue.main.async {
                self.view?.reloadTable()
                self.view?.hideLoader()
            }
            self.loading = false
        }
    }
    
    func showDetailfor(character: CharacterObject) {
        guard let detailVC = router?.createDetailView(for: character) else { return }
        view?.showDetailViewController(viewController: detailVC)
    }
}

