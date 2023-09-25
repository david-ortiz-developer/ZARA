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
extension CharacterDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell {
                cell.propertyNameLabel.text = "Status:"
                cell.propertyValueLabel.text = character.status
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell {
                cell.propertyNameLabel.text = "Species:"
                if  !character.type .isEmpty {
                    cell.propertyValueLabel.text = "\(character.species) / \(character.type)"
                } else {
                    cell.propertyValueLabel.text = character.species
                }
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell {
                cell.propertyNameLabel.text = "Gender:"
                cell.propertyValueLabel.text = character.gender
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell {
                cell.propertyNameLabel.text = "Origin:"
                cell.propertyValueLabel.text = character.origin.name
                return cell
            }
        case 4:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell {
                cell.propertyNameLabel.text = "Location:"
                cell.propertyValueLabel.text = character.location.name
                return cell
            }
        case 5:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell {
                var episodes = ""
                for episodeString in character.episode {
                    if let episodeNumber = episodeString.split(separator: "/").last {
                        episodes = episodes.appending("\(episodeNumber) ")
                    }
                }
                cell.propertyNameLabel.text = "Episodes:"
                cell.propertyValueLabel.text = episodes
                return cell
            }
        case 6:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "characterPropertiesCell", for: indexPath) as? CharacterInfoCell,
            let dateString = convertToReadableDate(dateString: character.created) {
                cell.propertyNameLabel.text = "Created:"
                cell.propertyValueLabel.text = dateString
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    func convertToReadableDate(dateString: String) -> String? {
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
