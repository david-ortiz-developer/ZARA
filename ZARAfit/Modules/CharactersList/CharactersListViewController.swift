//
//  ViewController.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
import Lottie

class CharactersListViewController: UIViewController, CharactersListViewControllerProtocol {
    
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var animationView: LottieAnimationView?
    var presenter: CharactersListPresenterProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.presenter?.listCharacters()
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
        self.tableView.reloadData()
    }
}
extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.characters?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let characterInfo: CharacterObject = self.presenter?.characters?[indexPath.row],
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
        if let character = self.presenter?.characters?[indexPath.row] {
            self.presenter?.showDetailfor(character: character)
        }
    }
}
