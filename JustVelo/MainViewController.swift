////
////  ViewController.swift
////  JustVelo
////
////  Created by Denis Svetlakov on 21.09.2021.
////
//
//import UIKit
//
//class MainViewController: UIViewController {
//    
//    var presenter: MapViewPresenterProtocol!
//    
//    let tableView = UITableView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupConstraints()
//    }
//    
//    func setupConstraints() {
//        
//        view.backgroundColor = .white
//        title = "Home"
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.dataSource = self
//        tableView.delegate = self
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.heightAnchor.constraint(equalToConstant: self.view.bounds.height),
//            tableView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
//        ])
//    }
//}
//
//extension MainViewController: UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return presenter.comments?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let comment = presenter.comments?[indexPath.row]
//        cell.textLabel?.text = comment?.body
//        return cell
//    }
//    
//}
//
//extension MainViewController: MapViewProtocol {
//
//}
//
//extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let comment = presenter.comments?[indexPath.row]
//        let logViewController = ModuleBuilder.createLogModule(comment: comment)
//        self.present(logViewController, animated: true)
//    }
//}
//
