//
//  ViewController.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
import Lottie

class CharactersListViewController: UIViewController, CharactersListViewControllerProtocol, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UIView!
    
    private var animationView: LottieAnimationView?
    var presenter: CharactersListPresenterProtocol?
    let searchController = UISearchController(searchResultsController: nil)
    private var charactersFiltered: [CharacterObject]?


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.presenter?.listCharacters()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Filter Characters"
        navigationItem.searchController = searchController
            definesPresentationContext = true
        searchBar.addSubview(searchController.searchBar)
    }
    func configureUI() {

    }

    func showLoader() {
        self.loaderView.alpha = 0.0
        animationView = .init(name:"animation_lmuxghgn")
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
    func reloadTable() {
        if !(searchController.searchBar.text?.isEmpty ?? false) {
            self.charactersFiltered = self.presenter?.characters?.filter { $0.name.lowercased().contains(searchController.searchBar.text?.lowercased() ?? "")}
        } else {
            self.charactersFiltered = self.presenter?.characters
        }
        self.tableView.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let _ = searchController.searchBar.text {
            reloadTable()
        }
    }
}
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let resultsCount = self.charactersFiltered?.count,
           resultsCount > 0 {
            return resultsCount
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let resultsCount = self.charactersFiltered?.count,
        resultsCount > 0
        {
            if let characterInfo: CharacterObject = self.charactersFiltered?[indexPath.row],
             let cell = tableView.dequeueReusableCell(withIdentifier: "charactersTableCell", for: indexPath) as? CharactersTableViewCell
            {
                cell.nameLabel.text = characterInfo.name
                cell.nameLabel.layer.masksToBounds = false
                cell.nameLabel.layer.cornerRadius = 5.0
                cell.nameLabel.clipsToBounds = true
                if let strUrl = characterInfo.image.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                    let imgUrl = URL(string: strUrl) {

                    cell.cellImage.loadImageWithUrl(imgUrl)
                    cell.cellImage.layer.masksToBounds = false
                    cell.cellImage.layer.cornerRadius = cell.cellImage.frame.height/2
                    cell.cellImage.layer.borderWidth = 1
                    cell.cellImage.layer.borderColor = UIColor.clear.cgColor
                    cell.cellImage.clipsToBounds = true
                    
                    cell.backgroundRoundView.layer.masksToBounds = false
                    cell.backgroundRoundView.layer.cornerRadius = cell.backgroundRoundView.frame.height/2
                    cell.backgroundRoundView.layer.borderWidth = 1
                    cell.backgroundRoundView.layer.borderColor = UIColor.clear.cgColor
                    cell.backgroundRoundView.clipsToBounds = true
                    cell.selectedBackgroundView?.backgroundColor = .systemMint
              }
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as? EmptyResultsTableViewCell
            let sadMortyAnimation: LottieAnimationView = LottieAnimationView(name: "animation_lmyxell9")

            sadMortyAnimation.frame = cell?.sadAnimation.bounds ?? self.tableView.bounds
            sadMortyAnimation.contentMode = .scaleAspectFit
            sadMortyAnimation.loopMode = .loop
            cell?.sadAnimation.addSubview(sadMortyAnimation)
            sadMortyAnimation.play()
            return cell ?? UITableViewCell()
        }
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
