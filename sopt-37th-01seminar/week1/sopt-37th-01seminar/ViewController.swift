//
//  ViewController.swift
//  sopt-37th-01Seminar
//
//  Created by 이명진 on 9/16/25.
//


import UIKit
 
class ViewController: UIViewController {
    private var redView: UIView = {
        var view = UIView(frame: CGRect(origin: CGPoint(x: 100, y: 200),
                                        size: CGSize(width: 200, height: 100)))
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(redView)
        print("frame: \(self.redView.frame)\nbounds: \(self.redView.bounds)")
    }
}

// let view = UIView(frame: CGRect(x: 100, y: 200, width: 100, height: 100))
// 이걸로도 가능!
// x, y, width, height가 있어야 만들 수 있음

//#Preview {ViewController()}
