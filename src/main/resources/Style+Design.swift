//
//  Style+Design.swift
//  UnidadEditorialItunes
//
//  Copyright © 2019 SDOS. All rights reserved.
//

import Foundation
import UIKit
import SDOSSwiftExtension

extension UIView {
    enum style {
        typealias View = UIView
        
        ///Apply with the next line: UIView.style.style1.apply(to: <#T##view#>)
        static var style1: Style<View> {
            return Style<View> {
                $0.backgroundColor = .blue
            }
        }
    }
}

extension UILabel {
    enum style {
        typealias View = UILabel
        
        static var style1: Style<View> {
            return Style<View> {
                $0.backgroundColor = .blue
            }
        }
        static func title(size: Float) -> Style<View> {
            
        }
    }
}
