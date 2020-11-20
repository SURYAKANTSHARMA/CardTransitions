//
//  SecondViewController.swift
//  DemoTransition
//
//  Created by tokopedia on 08/11/20.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.modalPresentationStyle = .custom
        // Do any additional setup after loading the view.
    }


}

extension SecondViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardAnimationController(isPresenting: true)
    }
}

