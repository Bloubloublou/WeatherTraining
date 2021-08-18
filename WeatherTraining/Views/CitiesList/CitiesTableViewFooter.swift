//
//  CitiesTabViewFooter.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 20/07/2021.
//

import UIKit

protocol CitiesTableViewFooterDelegate: AnyObject {
    func selectCelsius()
    func selectFahrenheit()
    func goToAddCity()
}

class  CitiesTableViewFooter: UIView {
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var addCityLabel: UILabel!
    
    weak var delegate: CitiesTableViewFooterDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let selectCelsiusAction = UITapGestureRecognizer(target: self, action: #selector(selectedCelsius))
        celsiusLabel.isUserInteractionEnabled = true
        celsiusLabel.addGestureRecognizer(selectCelsiusAction)
        
        let selectFahrenheitAction = UITapGestureRecognizer(target: self, action: #selector(selectedFahrenheit))
        fahrenheitLabel.isUserInteractionEnabled = true
        fahrenheitLabel.addGestureRecognizer(selectFahrenheitAction)
        
        let addCityAction = UITapGestureRecognizer(target: self, action: #selector(clickedOnAddCity))
        addCityLabel.isUserInteractionEnabled = true
        addCityLabel.addGestureRecognizer(addCityAction)
    }
    
    @objc func selectedCelsius (sender:UITapGestureRecognizer) {
        
        updateDegreeLabeAppearance(label: celsiusLabel,color: UIColor.white)
        updateDegreeLabeAppearance(label: fahrenheitLabel,color: UIColor.gray)
        
        delegate?.selectCelsius()
    }
    
    @objc func selectedFahrenheit (sender:UITapGestureRecognizer) {
        
        updateDegreeLabeAppearance(label: celsiusLabel,color: UIColor.gray)
        updateDegreeLabeAppearance(label: fahrenheitLabel,color: UIColor.white)
        
        delegate?.selectFahrenheit()
    }
    
    @objc func clickedOnAddCity (sender:UITapGestureRecognizer) {
        delegate?.goToAddCity()
    }
    
    func updateDegreeLabeAppearance(label: UILabel, color: UIColor) {
        label.textColor = color
    }
}
