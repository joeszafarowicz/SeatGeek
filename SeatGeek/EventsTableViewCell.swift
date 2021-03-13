//
//  EventCell.swift
//  SeatGeek
//
//  Created by Joseph Szafarowicz on 3/12/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eventImageView.layer.cornerRadius = 10
        eventImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        locationLabel.font = UIFont.systemFont(ofSize: 14.0)
        dateLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        titleLabel.textColor = .label
        locationLabel.textColor = .lightGray
        dateLabel.textColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
