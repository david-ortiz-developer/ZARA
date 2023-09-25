//
//  CharactersListRouter.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
class CharactersListRouter: CharactersListRouterProtocol {
    static func createCharactersListView() -> CharactersListViewController {
        let view = instantiateViewController(fromStoryboard: .charactersListView) as! CharactersListViewController
        let presenter = CharactersListPresenter()
        let interactor = CharactersListInteractor()
        let router = CharactersListRouter()
        
        configure(view: view, with: presenter, interactor: interactor, and: router)
        return view
    }
    
    func createDetailView(for character: CharacterObject) -> CharacterDetailViewController {
        let detailView = CharactersListRouter.instantiateViewController(fromStoryboard: .characterDetailView) as! CharacterDetailViewController
        detailView.character = character
        return detailView
    }
    
    private static func configure(view: CharactersListViewController, with presenter: CharactersListPresenter, interactor: CharactersListInteractor, and router: CharactersListRouter) {
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    private static func instantiateViewController(fromStoryboard storyboard: Storyboard) -> UIViewController {
        return storyboard.instance.instantiateViewController(withIdentifier: storyboard.identifier)
    }
}

// Enum to represent storyboards
private enum Storyboard {
    case charactersListView
    case characterDetailView
    
    var instance: UIStoryboard {
        switch self {
        case .charactersListView:
            return UIStoryboard(name: "CharactersListStoryBoard", bundle: Bundle.main)
        case .characterDetailView:
            return UIStoryboard(name: "CharacterDetailStoryBoard", bundle: Bundle.main)
        }
    }
    
    var identifier: String {
        switch self {
        case .charactersListView:
            return "CharactersListView"
        case .characterDetailView:
            return "CharacterDetailView"
        }
    }
}

