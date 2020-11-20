//
//  ViewController.swift
//  DemoTransition
//
//  Created by tokopedia on 08/11/20.
//

import UIKit

enum ViewState {
    case expand
    case collapse
}

class FirstView: UIView {
    
    lazy var ctaButton: UIButton = {
         let button = UIButton(frame: CGRect(x: 0, y: 40, width: frame.width, height: 40))
         button.setTitle("Click here for open view1", for: .normal)
         button.backgroundColor = .red
         //button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.text = "First View"
        return label
    }()
    
    var state: ViewState? {
        didSet {
            updateFrameAndView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    func updateFrameAndView() {
        switch state {
        case .collapse:
            self.addSubview(ctaButton)
            label.isHidden = true
            // add button for expand
        case .expand:
            ctaButton.removeFromSuperview()
            label.isHidden = false
            self.addSubview(label)
            label.center = center
        case .none:
            fatalError()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


class SecondView: UIView {
    
    lazy var ctaButton: UIButton = {
         let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
         button.setTitle("Click here for open view2", for: .normal)
         button.backgroundColor = .green
         return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.text = "Second View"
        return label
    }()
    
    lazy var thirdViewctaButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
         button.setTitle("Click here for open view3", for: .normal)
         button.backgroundColor = .brown
         return button
    }()
    
    var state: ViewState? {
        didSet {
            updateFrameAndView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
    }
    
    func updateFrameAndView() {
        switch state {
        case .collapse:
            self.addSubview(ctaButton)
            ctaButton.isHidden = false
            thirdViewctaButton.isHidden = true
            label.isHidden = true
            // add button for expand
        case .expand:
            ctaButton.isHidden = true
            thirdViewctaButton.isHidden = false
            addSubview(thirdViewctaButton)
            thirdViewctaButton.frame = CGRect(x: 0, y: frame.height-40-40, width: frame.width, height: 80)
            label.isHidden = false
            addSubview(label)
            label.center = center
        case .none:
            fatalError()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}


class ThirdView: UIView {
    
   lazy var label: UILabel = {
      let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
      label.text = "Third View"
      return label
   }()
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        addSubview(label)
        label.center = center
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

class FirstViewController: UIViewController {
    
    var firstView: FirstView!
    var secondView: SecondView!
    var thirdView: ThirdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstView = FirstView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 80))
        firstView?.state = .expand
        
        // 40 can be calculated dynamically if there are multiple views
        view.addSubview(firstView)
        firstView.ctaButton.addTarget(self, action: #selector(firstViewCTATapped(_:)), for: .touchUpInside)
        
        secondView = SecondView(frame: CGRect(x: 0, y: view.frame.height - 80, width: view.frame.width, height:  80))
        secondView.state = .collapse
        view.addSubview(secondView)
            
        secondView.ctaButton.addTarget(self, action: #selector(secondViewCTATapped(_:)), for: .touchUpInside)
        secondView.thirdViewctaButton.addTarget(self, action: #selector(thirdViewCTATapped(_:)), for: .touchUpInside)
    }
    
    
    @objc func thirdViewCTATapped(_ button: UIButton) {
        // add third view
        self.thirdView = ThirdView(frame: CGRect(x: 0, y: view.frame.width, width: self.view.frame.width, height: 100))
        self.view.addSubview(self.thirdView)
        UIView.animate(withDuration: 0.75) {
            self.secondView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: 80)
            self.thirdView.frame =  CGRect(x: 0, y: 120, width: self.view.frame.width, height: self.view.frame.height - 120)
        } completion: { _ in
            self.firstView.state = .collapse
            self.secondView.state = .collapse
        }
    }
    
    @objc func secondViewCTATapped(_ button: UIButton) {
        UIView.animate(withDuration: 0.75) {
            self.secondView.frame = CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height - 80)
            self.firstView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
            self.thirdView?.removeFromSuperview()
        } completion: { _ in
            self.firstView.state = .collapse
            self.secondView.state = .expand
        }
    }
    

    @objc func firstViewCTATapped(_ button: UIButton) {
        UIView.animate(withDuration: 0.75) {
            self.firstView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 80)
            self.secondView.frame = CGRect(x: 0, y: self.view.frame.height - 80, width: self.view.frame.width, height: 80)
            self.thirdView?.removeFromSuperview()
        } completion: { _ in
            self.firstView.state = .expand
            self.secondView.state = .collapse
        }
     }
}
    
