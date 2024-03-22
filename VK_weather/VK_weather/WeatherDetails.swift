//
//  weatherDetails.swift
//  VK_weather
//
//  Created by Yersin Kazybekov on 20.03.2024.
//

import UIKit

class WeatherDetails:UIView {
    
    init(frame: CGRect,imageName:String,desc:String,stat:String) {
        super.init(frame: frame)
        logo.image = UIImage(systemName: imageName)
        info.text = desc
        statistics.text = stat
        setupViews()
    }
    
    func updateInfo(stat:String){
        statistics.text = stat
    }
    
    let logo:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .white
        return view
    }()
    
    let info:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let statistics:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        self.addSubview(logo)
        self.addSubview(info)
        self.addSubview(statistics)
        
        NSLayoutConstraint.activate([
            
            logo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logo.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            
            statistics.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            statistics.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 16),
            
            
            info.topAnchor.constraint(equalTo: self.centerYAnchor),
            info.leftAnchor.constraint(equalTo: logo.rightAnchor, constant: 16)
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
