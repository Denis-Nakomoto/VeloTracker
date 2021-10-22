//
//  DetailedSnapShotView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 22.10.2021.
//

import UIKit

class DetailedSnapShotView: UIViewController {
    
    let snapShot = UIImageView()
    
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(snapShot: UIImage) {
        self.init(frame: .zero)
        self.snapShot.image = snapShot
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        snapShot.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(snapShot)
        
        NSLayoutConstraint.activate([
            snapShot.topAnchor.constraint(equalTo: view.topAnchor),
            snapShot.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            snapShot.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            snapShot.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}
