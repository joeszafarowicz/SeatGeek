//
//  EventModel.swift
//  SeatGeek
//
//  Created by Joseph Szafarowicz on 3/12/21.
//

class EventsModel {
    
    var image: String?
    var title: String?
    var location: String?
    var date: String?
    
    init(image: String?, title: String?, location: String?, date: String?) {
        self.image = image
        self.title = title
        self.location = location
        self.date = date
    }
}
