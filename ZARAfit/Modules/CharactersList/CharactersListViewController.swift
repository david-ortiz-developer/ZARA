//
//  ViewController.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import UIKit
import Lottie

class CharactersListViewController: UIViewController, CharactersListViewControllerProtocol {
    var presenter: CharactersListPresenterProtocol?
    
    private var animationView: LottieAnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

