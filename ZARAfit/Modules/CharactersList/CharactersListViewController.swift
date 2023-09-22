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
        let cell = UITableViewCell()
        if let characterInfo: CharacterObject = self.presenter?.characters?[indexPath.row] {
            cell.textLabel?.text = characterInfo.name
        }
        return cell
    }
    
    
}
