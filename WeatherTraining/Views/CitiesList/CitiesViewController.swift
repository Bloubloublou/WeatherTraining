//
//  CitiesViewController.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 19/07/2021.
//


import UIKit
import SnapKit

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var refreshControl: UIRefreshControl!

    private var lastClickedElement:Int = -1
    
    private var cities: [Any] = []
    var isCelsius = true
    
    override func loadView() {
        super.loadView()

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: .main), forCellReuseIdentifier: "city")
        
        tableView.addSubview(refreshControl!)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.cities = CitiesManager.shared.getCities()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // listening for changes inside forecasts
        UserDefaults.standard.addObserver(self, forKeyPath: UserDefaultsManager.forecastKey, options: NSKeyValueObservingOptions.new, context: nil)
        
        reloadData()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.cities = CitiesManager.shared.getCities()
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath:  UserDefaultsManager.forecastKey)
    }
    
    @objc private func reloadData() {
        CitiesManager.shared.updateAllCities()
    }
}

extension CitiesViewController: CityTableViewCellDelegate {
    func isCelsiusSelected() -> Bool {
        return isCelsius
    }
}

extension CitiesViewController: CitiesTableViewFooterDelegate {
    func selectCelsius() {
        isCelsius = true
        tableView.reloadData()
    }
    
    func selectFahrenheit() {
        isCelsius = false
        tableView.reloadData()
    }
    
    func goToAddCity() {
        self.performSegue(withIdentifier: "listToSearch", sender: self)
    }
}

extension CitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! CityTableViewCell
        let city = cities[indexPath.row]
        cell.delegate = self
        cell.configure(city as! City)
        
        return cell
    }
}

extension CitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            cities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer: CitiesTableViewFooter = .fromNib()
        footer.delegate = self
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city: City = (tableView.cellForRow(at: indexPath) as! CityTableViewCell).city!
   
        print("need to go to detailed view of " + city.name)
        self.lastClickedElement = indexPath.row
        
        self.performSegue(withIdentifier: "listToDetailed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "listToDetailed") {
            let vc = segue.destination as! DetailedForecastContainerViewController
            vc.initialPosition = lastClickedElement
        }
    }
}
