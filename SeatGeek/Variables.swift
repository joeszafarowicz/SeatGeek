//
//  Variables.swift
//  SeatGeek
//
//  Created by Joseph Szafarowicz on 3/13/21.
//

import Foundation

var eventsList = [EventsModel]()
var filteredList = [EventsModel]()
var cellRow: Int = 0
var favorites = UserDefaults.standard.array(forKey: "favoritesList") as! [String]
