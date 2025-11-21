//
//  UIView+.swift
//  week2
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit

extension UIView {
    // UIView 여러 개 인자로 받아서 한 번에 addSubview 합니다.
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
