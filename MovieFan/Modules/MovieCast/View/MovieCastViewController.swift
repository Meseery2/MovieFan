//
//  MovieCastViewController.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieCastViewController: UIViewController {

    public var movieViewModel: MovieDetailViewModel!
    
    lazy var tableViewCast: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let tableViewSectionAttrs: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font: UIFont.themeMediumFont(of: 18)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = movieViewModel.movieDetail.title
        setUI()
    }
    
    func setUI() {
        self.view.addSubview(tableViewCast)
        NSLayoutConstraint.activate([
            tableViewCast.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableViewCast.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableViewCast.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            tableViewCast.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        tableViewCast.register(UINib(nibName: "MovieCastCell", bundle: nil), forCellReuseIdentifier: "MovieCastTableViewCell")
        tableViewCast.rowHeight = UITableView.automaticDimension
        tableViewCast.estimatedRowHeight = 48
    }
    
}

extension MovieCastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movieViewModel.castCount
        }
        return movieViewModel.crewCount
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 50))
        view.addSubview(label)
        label.font = UIFont.themeMediumFont(of: 22)
        label.textColor = UIColor.black
        
        label.text = section == 0 ? "Cast" : "Crew"
        
        view.backgroundColor = UIColor.white
        
        return view
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCastTableViewCell", for: indexPath) as! MovieCastTableViewCell
        if indexPath.section == 0 {
            cell.configure(cast: movieViewModel.cast(at: indexPath), indexPath: indexPath)
        } else {
            cell.configure(crew: movieViewModel.crew(at: indexPath), indexPath: indexPath)
        }
        return cell
    }
}
