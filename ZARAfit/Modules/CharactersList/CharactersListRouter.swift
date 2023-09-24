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
    func showDetailView(for character: CharacterObject) {
        print("router showing \(character.name)")
    }
    static var mainstoryboard: UIStoryboard{
            return UIStoryboard(name:"CharactersListStoryBoard",bundle: Bundle.main)
        }
}
