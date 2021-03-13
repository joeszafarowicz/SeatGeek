//
//  ViewController.swift
//  SeatGeek
//
//  Created by Joseph Szafarowicz on 3/12/21.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        getEvents()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Event", for: indexPath) as! EventsTableViewCell
        let events: EventsModel
        events = eventsList[indexPath.row]
        
        cell.eventImageView.downloaded(from: "\(events.image!)")
        cell.titleLabel.text = events.title
        cell.locationLabel.text = events.location
        cell.dateLabel.text = events.date
        
        if favorites.contains(where: { $0 == events.title ?? "" }) {
            cell.favoriteImageView.isHidden = false
            cell.favoriteImageView.tintColor = .systemRed
            cell.favoriteImageView.image = UIImage(systemName: "heart.fill")
        } else {
            cell.favoriteImageView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellRow = indexPath.row
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsVC")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isFirstResponder == true {
            return filteredList.count
        }
        
        return eventsList.count
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            filteredList = eventsList.filter({ ($0.title?.contains(searchText))!})
        }
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        self.tableView.reloadData()
    }
    
    func getEvents() {
        let endpoint = URL(string: "https://api.seatgeek.com/2/events?client_id=CLIENT_ID&client_secret=CLIENT_SECRET")!
        URLSession.shared.dataTask(with: endpoint) { data, URLResponse, error in
            guard let data = data, error == nil, URLResponse != nil else {
                print("Something went wrong")
                return
            }
            
            eventsList.removeAll()
            filteredList.removeAll()
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Events.self, from: data)
                for event in results.events {
                    let image = event.performers[0].image
                    let title = event.title
                    let location = "\(event.venue.city ?? ""), \(event.venue.state ?? "")"
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    let date = dateFormatter.date(from: event.datetimeUTC ?? "")

                    dateFormatter.dateFormat = "EEEE, MMM d yyyy h:mm a"
                    dateFormatter.timeZone = TimeZone.current
                    let timeStamp = dateFormatter.string(from: date!)
                    
                    eventsList.append(EventsModel(image: image, title: title, location: location, date: "\(timeStamp)"))
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("\(error.localizedDescription)")
            }
        }.resume()
    }
}
