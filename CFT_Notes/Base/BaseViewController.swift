//
//  BaseViewController.swift
//  CFT_Notes
//
//  Created by Sofya Olekhnovich on 11.02.2024.
//

import UIKit

class BaseViewController: UIViewController {

    private var needLargeTitle: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(needLargeTitle: Bool) {
        self.needLargeTitle = needLargeTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .defaultScreenBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.prefersLargeTitles = needLargeTitle
        }
    }

}

