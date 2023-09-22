//
//  CharactersListProtocol.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
protocol CharactersListRouterProtocol {
    static func  createCharactersListView() -> CharactersListViewController
}

protocol CharactersListPresenterProtocol {
    var view: CharactersListViewControllerProtocol? {get set}
    var router: CharactersListRouterProtocol? {get set}
    var interactor: CharactersListInteractorProtocol? {get set}
    
    func listCharacters()
}
protocol CharactersListInteractorProtocol {
    var presenter: CharactersListPresenterProtocol? {get set}
}
protocol CharactersListViewControllerProtocol {
    var presenter: CharactersListPresenterProtocol? {get set}
    func showLoader()
    func hideLoader()
}
