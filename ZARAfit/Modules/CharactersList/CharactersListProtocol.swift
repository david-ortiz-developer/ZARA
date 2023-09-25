//
//  CharactersListProtocol.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
protocol CharactersListRouterProtocol {
    static func  createCharactersListView() -> CharactersListViewController
     func createDetailView(for character: CharacterObject) -> CharacterDetailViewController
}

protocol CharactersListPresenterProtocol {
    var view: CharactersListViewControllerProtocol? {get set}
    var router: CharactersListRouterProtocol? {get set}
    var interactor: CharactersListInteractorProtocol? {get set}
    var characters: [CharacterObject]? {get set}
    var page: Int {get set}
    var totalPages: Int {get set}
    var loading: Bool {get set}
    func listCharacters()
    func showDetailfor(character: CharacterObject)
}
protocol CharactersListInteractorProtocol {
    var presenter: CharactersListPresenterProtocol? {get set}
    func loadCharacters(completion: @escaping (Result<CharacterObjectResponse?, Error>) -> Void)
}
protocol CharactersListViewControllerProtocol {
    var presenter: CharactersListPresenterProtocol? {get set}
    func showLoader()
    func hideLoader()
    func reloadTable()
    func showDetailViewController(viewController: CharacterDetailViewController)
    func showErrorView()
}
