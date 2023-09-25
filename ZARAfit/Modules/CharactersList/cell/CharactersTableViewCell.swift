//
//  CharactersTableViewCell.swift
//  ZARAfit
//
//  Created by Davit on 23/09/23.
//

import Lottie
import UIKit
class CharactersTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellImage: ImageLoader!
    @IBOutlet weak var backgroundRoundView: UIView!
    @IBInspectable var selectionColor: UIColor = .gray {
        didSet {
            configureSelectedBackgroundView()
        }
    }

    func configureSelectedBackgroundView() {
        let view = UIView()
        view.backgroundColor = .clear
        let frameAnimated = configureBackgroundAnimation()
        view.addSubview(frameAnimated)
        frameAnimated.play()
        selectedBackgroundView = view
    }
    private func configureBackgroundAnimation() -> LottieAnimationView {
        let errorAnimation = LottieAnimationView(name: "animation_lmzie8od")
        errorAnimation.frame = self.bounds
        errorAnimation.contentMode = .scaleToFill
        errorAnimation.loopMode = .loop
        return errorAnimation
    }
}
