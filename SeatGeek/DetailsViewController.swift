//
//  DetailsViewController.swift
//  SeatGeek
//
//  Created by Joseph Szafarowicz on 3/12/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.tintColor = .label
        favoriteButton.tintColor = .label
        
        eventTitleLabel.textColor = .label
        eventDateLabel.textColor = .label
        eventLocationLabel.textColor = .lightGray
        
        eventTitleLabel.font = UIFont.boldSystemFont(ofSize: 27.0)
        eventDateLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        eventLocationLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        eventTitleLabel.text = eventsList[cellRow].title
        eventDateLabel.text = eventsList[cellRow].date
        eventLocationLabel.text = eventsList[cellRow].location
        
        eventImageView.downloaded(from: "\(eventsList[cellRow].image!)")
        eventImageView.layer.cornerRadius = 10
        eventImageView.clipsToBounds = true
        
        if favorites.contains(where: { $0 == eventsList[cellRow].title ?? "" }) {
            favoriteButton.tintColor = .systemRed
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventsVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        if favoriteButton.tintColor != .systemRed {
            favoriteButton.tintColor = .systemRed
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)

            favorites.append(eventsList[cellRow].title ?? "")
            UserDefaults.standard.set(favorites, forKey: "favoritesList")
        } else {
            favoriteButton.tintColor = .label
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)

            favorites.removeAll { $0 == eventsList[cellRow].title ?? "" }
            UserDefaults.standard.set(favorites, forKey: "favoritesList")
        }
    }
}
