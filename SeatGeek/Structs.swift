//
//  Events.swift
//  SeatGeek
//
//  Created by Joseph Szafarowicz on 3/12/21.
//

struct Events: Codable {
    let events: [Event]

    enum CodingKeys: String, CodingKey {
        case events
    }
}

struct Event: Codable {
    let id: Double?
    let datetimeUTC: String?
    let venue: Venue
    let performers: [Performer]
    let title: String?

    enum CodingKeys: String, CodingKey {
        case id, title, performers
        case datetimeUTC = "datetime_utc"
        case venue
    }
}

struct Performer: Codable {
    let image: String?

    enum CodingKeys: String, CodingKey {
        case image
    }
}

struct Venue: Codable {
    let city: String?
    let state: String?

    enum CodingKeys: String, CodingKey {
        case city, state
    }
}

