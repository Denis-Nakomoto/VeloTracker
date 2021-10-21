//
//  LogView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 23.09.2021.
//

import UIKit

class LogViewController: UIViewController {
    
    // Enum describes all sections
    enum Section: Int, CaseIterable {
        case trainings
    }
    
    var presenter: LogViewPresenterProtocol!
    private lazy var dataSource = {self.configureDataSource()}()
    lazy var collectionView = makeCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTrainingsData()
        reloadData(trainings: presenter.storageManager.trainings.value!)
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Training> {
        let cellRegistration = UICollectionView.CellRegistration<LogViewCell, Training> { cell, indexPath, training in
            cell.backgroundConfiguration?.backgroundInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
            cell.backgroundConfiguration?.cornerRadius = 20
            cell.training = training
        }
        
        return UICollectionViewDiffableDataSource<Section, Training>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, training in
                return collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: training
                )
            }
        )
    }
    
    func makeCollectionView() -> UICollectionView {
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.backgroundColor = .systemBackground
        config.showsSeparators = true
        config.separatorConfiguration.bottomSeparatorVisibility = .visible
        
        config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            guard let self = self else { return nil }

            let actionHandler: UIContextualAction.Handler = { action, view, completion in
                if let training = self.presenter.storageManager.trainings.value?[indexPath.row] {
                    self.presenter.storageManager.deleteTraining(item: training)
                }
                completion(true)
            }

            let action = UIContextualAction(style: .normal, title: "Delete", handler: actionHandler)
            
            action.image = UIImage(systemName: "trash")
            action.backgroundColor = .systemRed
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [action])
            swipeConfiguration.performsFirstActionWithFullSwipe = false
            return swipeConfiguration
        }
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    // Sets observer for saved trainings array and initially fethes trainings from core data
    private func setupTrainingsData() {
        presenter.storageManager.trainings.add({ trainings in
            DispatchQueue.main.async {
                self.presenter?.reloadData(trainings: trainings ?? [])
            }
        })
        presenter.storageManager.fetchData()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Trainings statistics"
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
//        appearance.configureWithTransparentBackground()
//        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortTrainings))
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
}

extension LogViewController: LogViewProtocol {
    // Realoads data in the view
    func reloadData(trainings: [Training]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Training>()
        let trainingValue = trainings
        snapshot.appendSections([.trainings])
        snapshot.appendItems(trainingValue, toSection: .trainings)
        dataSource.apply(snapshot)
    }
    
    @objc func sortTrainings() {
        
        presenter?.reversedSorting.toggle()
        
        let alert = UIAlertController(title: "", message: "Sorting", preferredStyle: .actionSheet)
        
        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 18)]
        let messageString = NSAttributedString(string: "Sorting", attributes: messageAttributes as [NSAttributedString.Key : Any])
        alert.setValue(messageString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: "Date", style: .default , handler:{ (UIAlertAction)in
            self.presenter.sortTrainings(by: .date)
        }))
        
        alert.addAction(UIAlertAction(title: "Distance", style: .default , handler:{ (UIAlertAction)in
            self.presenter.sortTrainings(by: .distance)
        }))

        alert.addAction(UIAlertAction(title: "Calories", style: .default , handler:{ (UIAlertAction)in
            self.presenter.sortTrainings(by: .calories)
        }))
        
        alert.addAction(UIAlertAction(title: "Time", style: .default, handler:{ (UIAlertAction)in
            self.presenter.sortTrainings(by: .time)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true, completion: nil)
    }
}
