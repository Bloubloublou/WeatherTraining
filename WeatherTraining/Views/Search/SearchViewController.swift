//
//  SearchViewController.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 21/07/2021.
//

import UIKit
import MapKit

class SearchViewController: UIViewController, MKLocalSearchCompleterDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    @IBAction func cancelSearch(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private var completer: MKLocalSearchCompleter = MKLocalSearchCompleter()
    
    private var searchResultArray: [String] = []
    
    override func viewDidLoad() {
        searchResultsTableView.register(UINib(nibName: "SearchTableViewCell", bundle: .main), forCellReuseIdentifier: "result")
        searchResultsTableView.dataSource = self
        searchResultsTableView.delegate = self
        searchBar.delegate = self
    }
    
    func searchFor(cityName: String) {
        print("searching for " + cityName)
        completer.delegate = self
        completer.region = MKCoordinateRegion(.world)
        completer.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        completer.queryFragment = cityName
        
        let results = completer.results.filter { result in
            guard !result.title.contains(" ") else { return false }
            return true
        }
        
        searchResultArray = results.map { $0.title }
        print(searchResultArray.count)
    }
}

extension SearchViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        searchFor(cityName: textSearched)
        
        searchResultsTableView.reloadData()
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 40;
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath) as! SearchTableViewCell
        let cityName = searchResultArray[indexPath.row]
        
        cell.configure(cityName)
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityName: String = (tableView.cellForRow(at: indexPath) as! SearchTableViewCell).cityName!
        
        CitiesManager.shared.addCity(cityName: cityName)
        
        dismiss(animated: true)
    }
}


