//
//  ViewController.swift
//  VK_weather
//
//  Created by Yersin Kazybekov on 20.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let presenter:Presenter
    
    init(presenter:Presenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupTableView()
        addSubviews()
        setupLayout()
        currentDataHolder.setData(data: presenter.weatherArray[0])
    }
    
    func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DayCell.self, forCellReuseIdentifier: "DayCell")
    }
    
    func setupBackground(){
        let imageView = UIImageView(image: UIImage(named: "stars"))
        imageView.frame = view.bounds
        imageView.contentMode = .scaleToFill
        view.addSubview(imageView)
        view.backgroundColor = .white
    }
    
    let currentDataHolder:CurrentDataHolder = {
        let view = CurrentDataHolder()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let tableView:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.allowsSelection = false
        table.showsVerticalScrollIndicator = false
        table.layer.cornerRadius = 20
        table.bounces = false
        table.backgroundColor = .clear
        return table
    }()
    
    func addSubviews(){
        view.addSubview(currentDataHolder)
        view.addSubview(tableView)
    }
    
    func setupLayout(){
        
        NSLayoutConstraint.activate([
            currentDataHolder.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 12),
            currentDataHolder.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            currentDataHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            currentDataHolder.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -12),
            tableView.topAnchor.constraint(equalTo: currentDataHolder.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as? DayCell else {
            return UITableViewCell()
        }
        
        cell.setupData(data: presenter.weatherArray[indexPath.row+1])
        
        return cell
    }
    
    
}

