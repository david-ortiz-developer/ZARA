//
//  CharactersListRouter.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
class CharactersListRouter: CharactersListRouterProtocol {
    static func  createCharactersListView() -> CharactersListViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "CharactersListView") as! CharactersListViewController
        let presenter = CharactersListPresenter()
        let interactor = CharactersListInteractor()
        let router = CharactersListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
     func createDetailView(for character: CharacterObject) -> CharacterDetailViewController {
         let detailView = CharactersListRouter.mainstoryboard.instantiateViewController(withIdentifier: "CharacterDetailView") as! CharacterDetailViewController
         detailView.character = character
         return detailView
    }
    static var mainstoryboard: UIStoryboard{
            return UIStoryboard(name:"CharactersListStoryBoard",bundle: Bundle.main)
        }
}
