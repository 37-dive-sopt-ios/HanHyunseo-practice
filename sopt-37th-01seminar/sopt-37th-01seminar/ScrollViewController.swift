//
//  ScrollViewController.swift
//  sopt-37th-01seminar
//
//  Created by 한현서 on 10/18/25.
//

import Foundation
import UIKit
import SnapKit

class ScrollViewController: UIViewController {
    private let scrollView = UIScrollView()
    private var contentView = UIView()
    
    private let viewWidth = UIScreen.main.bounds.width / 2
    private let viewHeight: CGFloat = 450 
    
    private let redView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let orangeView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    private let yellowView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    private let greenView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    private let blueView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    private func setLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [redView, orangeView, yellowView, greenView, blueView, purpleView].forEach {
            contentView.addSubview($0)
        }

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
            $0.height.greaterThanOrEqualToSuperview().priority(.low)
        }
        
        // 첫 번째 줄: 빨강, 주황
        redView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(viewHeight)
        }
        
        orangeView.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView)
            $0.leading.equalTo(redView.snp.trailing)
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(viewHeight)
        }
        
        // 두 번째 줄: 노랑, 초록
        yellowView.snp.makeConstraints {
            $0.top.equalTo(redView.snp.bottom)
            $0.leading.equalTo(contentView)
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(viewHeight)
        }
        
        greenView.snp.makeConstraints {
            $0.top.equalTo(orangeView.snp.bottom)
            $0.trailing.equalTo(contentView)
            $0.leading.equalTo(yellowView.snp.trailing)
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(viewHeight)
        }
        
        // 세 번째 줄: 파랑, 보라
        blueView.snp.makeConstraints {
            $0.top.equalTo(yellowView.snp.bottom)
            $0.leading.equalTo(contentView)
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(viewHeight)
            $0.bottom.equalTo(contentView) // contentView의 마지막 요소
        }
        
        purpleView.snp.makeConstraints {
            $0.top.equalTo(greenView.snp.bottom)
            $0.trailing.equalTo(contentView)
            $0.leading.equalTo(blueView.snp.trailing)
            $0.width.equalTo(viewWidth)
            $0.height.equalTo(viewHeight)
        }
    }
}
