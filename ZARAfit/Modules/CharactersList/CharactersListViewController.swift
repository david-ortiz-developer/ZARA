//
//  ViewController.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
import Lottie

class CharactersListViewController: UIViewController,
                                    CharactersListViewControllerProtocol,
                                    UISearchResultsUpdating,
                                        UISearchBarDelegate {

    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var animationErrorView: UIView!
    private var animationView: LottieAnimationView?
    var presenter: CharactersListPresenterProtocol?
    let searchController = UISearchController(searchResultsController: nil)
    private var charactersFiltered: [CharacterObject]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.presenter?.listCharacters()
    }
    func configureUI() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Filter Characters"
        navigationItem.searchController = searchController
            definesPresentationContext = true
        searchBar.addSubview(searchController.searchBar)
        let errorAnimation = configureErrorAnimation()
        animationErrorView.addSubview(errorAnimation)
        errorAnimation.play()
        self.view.bringSubviewToFront(errorView)
        self.hideErrorView(sender: UIButton())
    }

    func showLoader() {
        self.loaderView.alpha = 0.0
        animationView = .init(name: "animation_lmuxghgn")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        loaderView.addSubview(animationView!)
        animationView?.play()
        UIView.animate(withDuration: 2.0, delay: 0.5, options: .curveEaseIn, animations: {
            self.loaderView.alpha = 1.0
            self.loaderView.isHidden = false
        })
    }
    func hideLoader() {
        UIView.animate(withDuration: 2.0, delay: 1.0, options: .curveEaseOut, animations: {
                   self.loaderView?.alpha = 0.0
               }, completion: {_ in
                   self.animationView?.removeFromSuperview()
                   self.loaderView.isHidden = true
               })

    }
    func showErrorView() {
        self.errorView.isHidden = false
        self.searchController.searchBar.isHidden = true
    }
    @IBAction func hideErrorView(sender: UIButton) {
        self.errorView.isHidden = true
        self.searchController.searchBar.isHidden = false
    }
    func reloadTable() {
        if !(searchController.searchBar.text?.isEmpty ?? false) {
            self.charactersFiltered = self.presenter?.characters?.filter {
                $0.name.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")
            }
        } else {
            self.charactersFiltered = self.presenter?.characters
        }
        self.tableView.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text != nil {
            reloadTable()
        }
    }
}
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let resultsCount = charactersFiltered?.count, resultsCount > 0 else {
            return 1
        }
        return resultsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let resultsCount = charactersFiltered?.count, resultsCount > 0 else {
            return configureEmptyCell(tableView: tableView, indexPath: indexPath)
        }

        guard let characterInfo = charactersFiltered?[indexPath.row],
              let cell = configureCharacterCell(tableView: tableView,
                                                indexPath: indexPath,
                                                characterInfo: characterInfo) else {
            return UITableViewCell()
        }

        return cell
    }

    private func configureCharacterCell(tableView: UITableView,
                                        indexPath: IndexPath,
                                        characterInfo: CharacterObject) -> CharactersTableViewCell? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "charactersTableCell",
                                                       for: indexPath) as? CharactersTableViewCell else {
            return nil
        }

        cell.nameLabel.text = characterInfo.name
        configureCellAppearance(cell: cell, urlString: characterInfo.image)

        return cell
    }

    private func configureEmptyCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell",
                                                       for: indexPath) as? EmptyResultsTableViewCell else {
            return UITableViewCell()
        }

        let sadMortyAnimation = configureSadMortyAnimation(for: cell)
        cell.sadAnimation.addSubview(sadMortyAnimation)
        sadMortyAnimation.play()

        return cell
    }

    private func configureSadMortyAnimation(for cell: EmptyResultsTableViewCell) -> LottieAnimationView {
        let sadMortyAnimation = LottieAnimationView(name: "animation_lmyxell9")
        sadMortyAnimation.frame = cell.sadAnimation.bounds
        sadMortyAnimation.contentMode = .scaleAspectFit
        sadMortyAnimation.loopMode = .loop
        return sadMortyAnimation
    }
    private func configureErrorAnimation() -> LottieAnimationView {
        let errorAnimation = LottieAnimationView(name: "animation_lmz1snim")
        errorAnimation.frame = self.animationErrorView.bounds
        errorAnimation.contentMode = .scaleAspectFit
        errorAnimation.loopMode = .loop
        return errorAnimation
    }

    private func configureCellAppearance(cell: CharactersTableViewCell, urlString: String) {
        guard let strUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let imgUrl = URL(string: strUrl) else {
            return
        }

        cell.cellImage.loadImageWithUrl(imgUrl)
        configureRoundedCorners(for: cell)
        cell.selectedBackgroundView?.backgroundColor = .systemMint
    }

    private func configureRoundedCorners(for cell: CharactersTableViewCell) {
        configureRoundedCorners(for: cell.cellImage)
        configureRoundedCorners(for: cell.backgroundRoundView)
    }

    private func configureRoundedCorners(for view: UIView) {
        view.layer.masksToBounds = false
        view.layer.cornerRadius = view.frame.height / 2
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.clipsToBounds = true
    }
}

extension CharactersListViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (self.presenter?.page ?? 1) < (self.presenter?.totalPages ?? 1) {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            if maximumOffset - currentOffset <= 10.0 {
                self.presenter?.page += 1
                self.presenter?.listCharacters()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let character = self.charactersFiltered?[indexPath.row] {
            self.presenter?.showDetailfor(character: character)
        }
    }
    func showDetailViewController(viewController: CharacterDetailViewController) {
        self.present(viewController, animated: true)
    }
}
