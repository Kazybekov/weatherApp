//
//  DayCell.swift
//  VK_weather
//
//  Created by Yersin Kazybekov on 20.03.2024.
//

import UIKit

class DayCell:UITableViewCell{
    static let identifier = "DayCell"
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        self.backgroundColor = UIColor(red: 0.17, green: 0.47, blue: 0.76, alpha: 0.4)

        views()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(data:Weather){
        deltaTemp.text = String(Int(data.minTemp))+" °C"
        dayLabel.text = data.date
        logo.image = UIImage(systemName: data.imageName)
    }
    let logo:UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "barometer"))
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let dayLabel:UILabel = {
        let label = UILabel()
        label.text = "Monday"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deltaTemp:UILabel = {
        let label = UILabel()
        label.text = "24'/26'"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func views(){
        self.addSubview(dayLabel)
        self.addSubview(logo)
        self.addSubview(deltaTemp)
        
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.centerXAnchor.constraint(equalTo: self.rightAnchor,constant: -80),
            
            deltaTemp.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            deltaTemp.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
}
