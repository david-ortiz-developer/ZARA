//
//  CharacterDetailViewController.swift
//  ZARAfit
//
//  Created by Davit on 24/09/23.
//

import UIKit
class CharacterDetailViewController: UIViewController {
    var character: CharacterObject!
    override func viewDidLoad() {
        assert(character != nil, "Character can't be nil")
    }
}
