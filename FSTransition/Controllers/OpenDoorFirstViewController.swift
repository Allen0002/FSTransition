//
//  OpenDoorFirstViewController.swift
//  FSTransition
//
//  Created by allen_wu on 2019/7/24.
//  Copyright © 2019 Allen. All rights reserved.
//

import UIKit

class OpenDoorFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        fs_registerToInteractiveTransition([.left]) {[weak self] in
            let animation = OpenDoorTranstionAnimation()
            let vc = OpenDoorSecondViewController.init(nibName: "OpenDoorSecondViewController", bundle: nil)
            self?.fs_pushViewController(vc, animation: animation)
        }
        
    }
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
