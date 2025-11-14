//
//  UIView+Extension.swift
//  sopt-37th-01seminar
//
//  Created by 한현서 on 11/8/25.
//

import Foundation
import UIKit

extension UIView {
    // 여러 개의 뷰를 한 번에 추가하는 메서드
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
