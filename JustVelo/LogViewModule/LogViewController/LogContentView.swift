//
//  LogContentView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 20.10.2021.
//

import UIKit

class LogContentView: UIView, UIContentView {
    
    let distanceLbl = UILabel(text: "Ditance:", font: .systemFont(ofSize: 18, weight: .regular), color: .systemGray)
    let coloriesLbl = UILabel(text: "Colories:", font: .systemFont(ofSize: 18, weight: .regular), color: .systemGray)
    let speedLbl = UILabel(text: "Avg speed:", font: .systemFont(ofSize: 18, weight: .regular), color: .systemGray)
    let timeLbl = UILabel(text: "Time:", font: .systemFont(ofSize: 18, weight: .regular), color: .systemGray)
    let distanceLabel = UILabel(text: "DST", font: .systemFont(ofSize: 18, weight: .medium), color: #colorLiteral(red: 0.1960784314, green: 0.5882352941, blue: 0.8392156863, alpha: 1))
    let dateLabel = UILabel(text: "DTE", font: .systemFont(ofSize: 20, weight: .medium), color: #colorLiteral(red: 0.1960784314, green: 0.5882352941, blue: 0.8392156863, alpha: 1))
    
    let pathPassedSnapShot: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "map"))
        image.sizeToFit()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private var currentConfiguration: LogViewContentConfiguration!
    var configuration: UIContentConfiguration {
        get {
            currentConfiguration
        }
        set {
            guard let newConfiguration = newValue as? LogViewContentConfiguration else {
                return
            }
            apply(configuration: newConfiguration)
        }
    }
    
    init(configuration: LogViewContentConfiguration) {
        super.init(frame: .zero)
        setupAllViews()
        apply(configuration: configuration)
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = .systemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LogContentView {
    
    private func setupAllViews() {
        
        backgroundColor = .systemGreen
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        pathPassedSnapShot.translatesAutoresizingMaskIntoConstraints = false
        distanceLbl.translatesAutoresizingMaskIntoConstraints = false
        coloriesLbl.translatesAutoresizingMaskIntoConstraints = false
        speedLbl.translatesAutoresizingMaskIntoConstraints = false
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(distanceLabel)
        addSubview(dateLabel)
        addSubview(pathPassedSnapShot)
        addSubview(distanceLbl)
        addSubview(speedLbl)
        addSubview(coloriesLbl)
        addSubview(timeLbl)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            distanceLbl.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            distanceLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.bottomAnchor.constraint(equalTo: distanceLbl.bottomAnchor),
            distanceLabel.leadingAnchor.constraint(equalTo: distanceLbl.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            speedLbl.topAnchor.constraint(equalTo: distanceLbl.bottomAnchor, constant: 16),
            speedLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            timeLbl.topAnchor.constraint(equalTo: speedLbl.bottomAnchor, constant: 16),
            timeLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            coloriesLbl.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: 16),
            coloriesLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
        
        
        NSLayoutConstraint.activate([
            pathPassedSnapShot.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            pathPassedSnapShot.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            pathPassedSnapShot.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            pathPassedSnapShot.heightAnchor.constraint(equalToConstant: 150),
            pathPassedSnapShot.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func apply(configuration: LogViewContentConfiguration) {

        guard currentConfiguration != configuration else {
            return
        }
        
        currentConfiguration = configuration
        distanceLabel.text = configuration.distance
        distanceLabel.textColor = configuration.nameColor
        dateLabel.textColor = configuration.nameColor
        self.backgroundColor = configuration.contentBackgroundColor
        if let date = configuration.date {
            dateLabel.text = date.dateFormatter()
        }
        if let data = configuration.pathPassed {
            pathPassedSnapShot.image = UIImage(data: data)
        }
    }
}
