//
//  CurrentDataHolder.swift
//  VK_weather
//
//  Created by Yersin Kazybekov on 20.03.2024.
//

import UIKit

class CurrentDataHolder:UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0.17, green: 0.47, blue: 0.76, alpha: 0.4)
        self.layer.cornerRadius = 20
        views()
        setLayout()
    }
    
    func setData(data:Weather){
        locationName.text = data.city
        temperature.text = String(Int(data.temp))+" °C"
        weatherDescription.text = data.imageName
        
        currentDate.text = data.date
        
        let image = getImage(name: data.imageName)
       
        weatherLogo.addSubview(image)

        image.centerYAnchor.constraint(equalTo: weatherLogo.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: weatherLogo.centerXAnchor).isActive = true
        
        windSpeed.updateInfo( stat: String(data.windSpeed)+" km/h")
        
        chanceOfRain.updateInfo(stat: String(Int(data.feelsLike))+" °C")
        
        humidity.updateInfo(stat: String(data.humidity)+" %")
        
        pressure.updateInfo(stat: String(data.pressure)+" mBar")
        
        
    }
    
    func getImage(name:String)->UIImageView{
        let image = UIImageView(image: UIImage(systemName:name))
        
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false

        image.widthAnchor.constraint(equalToConstant: 120).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return image
    }
    
    let locationName:UILabel = {
        let label = UILabel()
        label.text = "Astana"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 26,weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let currentDate:UILabel = {
        let label = UILabel()
        label.text = "Thursday | Nov 12"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let temperature:UILabel = {
        let label = UILabel()
        label.text = "23'"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 44,weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let weatherDescription:UILabel = {
        let label = UILabel()
        label.text = "Heavy rain"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label;
    }()
    
    let zStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    let hStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let weatherLogo:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    let lineView:UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 2).isActive = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let windSpeed:WeatherDetails = {
        let view = WeatherDetails(frame: .null, imageName: "wind", desc: "Wind speed", stat: "3.5 km/h")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let chanceOfRain:WeatherDetails = {
        let view = WeatherDetails(frame: .null, imageName: "person", desc: "Feels Like", stat: "65%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pressure:WeatherDetails = {
        let view = WeatherDetails(frame: .null, imageName: "barometer", desc: "Pressure", stat: "1029 mbar")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let humidity:WeatherDetails = {
        let view = WeatherDetails(frame: .null, imageName: "humidity", desc: "Humidity", stat: "17%")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func views(){
        self.addSubview(locationName)
        
        zStack.addArrangedSubview(currentDate)
        zStack.addArrangedSubview(temperature)
        zStack.addArrangedSubview(weatherDescription)
                
        hStack.addArrangedSubview(weatherLogo)
        hStack.addArrangedSubview(zStack)
        
        self.addSubview(hStack)
        
        self.addSubview(lineView)
        
        self.addSubview(windSpeed)
        self.addSubview(pressure)
        self.addSubview(chanceOfRain)
        self.addSubview(humidity)
        
        
        
    }
    
    func setLayout(){
        NSLayoutConstraint.activate([
            locationName.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            locationName.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: 16),
            hStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            hStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: hStack.bottomAnchor,constant: 16),
            lineView.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 16),
            lineView.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16)
        ])
        
        
        NSLayoutConstraint.activate([
            windSpeed.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32),
            windSpeed.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            windSpeed.rightAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            chanceOfRain.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 32),
            chanceOfRain.leftAnchor.constraint(equalTo: windSpeed.rightAnchor),
            
            pressure.topAnchor.constraint(equalTo: windSpeed.bottomAnchor,constant: 42),
            pressure.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            pressure.rightAnchor.constraint(equalTo: self.centerXAnchor),

            humidity.topAnchor.constraint(equalTo: windSpeed.bottomAnchor, constant: 42),
            humidity.leftAnchor.constraint(equalTo: windSpeed.rightAnchor),
            
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




