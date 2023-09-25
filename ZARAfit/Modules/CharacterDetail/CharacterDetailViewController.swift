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
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAnimations()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        assert(character != nil, "Character can't be nil")
        
        if let strUrl = character.image.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
           let imgUrl = URL(string: strUrl) {
            characterImage.loadImageWithUrl(imgUrl)
            characterImage.layer.cornerRadius = 15
        }
        
        characterName.text = character.name
        characterName.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -10.radians...10.radians))
    }
    
    private func configureAnimations() {
        configureAnimationView(&closeAnimationView, name: "animation_lmxtsihn", frame: closeButton.frame)
        configureAnimationView(&frameAnimationView, name: "animation_lmxum64d", frame: characterImage.frame)
        view.bringSubviewToFront(closeButton)
    }
    
    private func configureAnimationView(_ animationView: inout LottieAnimationView?, name: String, frame: CGRect) {
        animationView = LottieAnimationView(name: name)
        animationView?.frame = frame
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .autoReverse
        if let animationView = animationView {
            view.addSubview(animationView)
            animationView.play()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func closeView(sender: UIButton) {
        dismiss(animated: true)
    }
}

extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell else {
            return UITableViewCell()
        }

        switch indexPath.row {
        case 0:
            configureCell(cell, propertyName: "Status:", propertyValue: character.status)
        case 1:
            let species = !character.type.isEmpty ? "\(character.species) / \(character.type)" : character.species
            configureCell(cell, propertyName: "Species:", propertyValue: species)
        case 2:
            configureCell(cell, propertyName: "Gender:", propertyValue: character.gender)
        case 3:
            configureCell(cell, propertyName: "Origin:", propertyValue: character.origin.name)
        case 4:
            configureCell(cell, propertyName: "Location:", propertyValue: character.location.name)
        case 5:
            configureEpisodesCell(cell)
        case 6:
            configureDateCell(cell)
        default:
            return UITableViewCell()
        }

        return cell
    }

    private func configureCell(_ cell: CharacterInfoCell, propertyName: String, propertyValue: String) {
        cell.propertyNameLabel.text = propertyName
        cell.propertyValueLabel.text = propertyValue
    }

    private func configureEpisodesCell(_ cell: CharacterInfoCell) {
        var episodes = ""
        for episodeString in character.episode {
            if let episodeNumber = episodeString.split(separator: "/").last {
                episodes = episodes.appending("\(episodeNumber) ")
            }
        }
        configureCell(cell, propertyName: "Episodes:", propertyValue: episodes)
    }

    private func configureDateCell(_ cell: CharacterInfoCell) {
        guard let dateString = convertToReadableDate(dateString: character.created) else {
            return
        }
        configureCell(cell, propertyName: "Created:", propertyValue: dateString)
    }

    private func convertToReadableDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // The format of the input string
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")  // Set appropriate locale if needed

        if let date = dateFormatter.date(from: dateString) {
            // Define the desired output date format
            dateFormatter.dateFormat = "MMMM dd, yyyy - h:mm a"
            dateFormatter.amSymbol = "AM"
            dateFormatter.pmSymbol = "PM"
            return dateFormatter.string(from: date)
        } else {
            return nil  // Return nil if the input string is not in the expected format
        }
    }
}

