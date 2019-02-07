//
//  HomeViewController.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit
import PulsarKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func showMoving(_ sender: Any) {
        let vc = MovingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

