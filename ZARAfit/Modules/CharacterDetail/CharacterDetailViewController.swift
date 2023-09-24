//
//  CharacterDetailViewController.swift
//  ZARAfit
//
//  Created by Davit on 24/09/23.
//

import UIKit
import Lottie

class CharacterDetailViewController: UIViewController {
    var character: CharacterObject!
    @IBOutlet weak var characterImage: ImageLoader!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var characterName: UILabel!
    private var closeAnimationView: LottieAnimationView?
    private var frameAnimationView: LottieAnimationView?
    
    override func viewDidLoad() {
        assert(character != nil, "Character can't be nil")
        if let strUrl = character.image.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
            characterImage.loadImageWithUrl(imgUrl)
            characterImage.layer.cornerRadius = 15
        }
        closeAnimationView = .init(name:"animation_lmxtsihn")
        closeAnimationView?.frame = closeButton.frame
        closeAnimationView?.contentMode = .scaleAspectFit
        closeAnimationView?.loopMode = .autoReverse
        self.view.addSubview(closeAnimationView!)
        closeAnimationView?.play()
        
        frameAnimationView = .init(name:"animation_lmxum64d")
        frameAnimationView?.frame = characterImage.frame
        frameAnimationView?.contentMode = .scaleAspectFit
        frameAnimationView?.loopMode = .autoReverse
        self.view.addSubview(frameAnimationView!)
        frameAnimationView?.play()
        
        self.characterName.text = character.name
        self.characterName.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -10.radians...10.radians))
        
        self.view.bringSubviewToFront(closeButton)
        
    }
    @IBAction func closeView(sender: UIButton) {
        self.dismiss(animated: true)
    }
}
