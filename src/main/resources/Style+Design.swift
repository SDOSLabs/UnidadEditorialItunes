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
        
        static var separator: Style<View> {
            return Style<View> {
                $0.backgroundColor = .veryLightBlue
            }
        }
    }
}

extension UIImageView {
    enum style {
        typealias View = UIImageView
        
        static func roundCorners(_ corner: Float) -> Style<View> {
            return Style<View> {
                $0.layer.cornerRadius = CGFloat(corner)
                $0.clipsToBounds = true
            }
        }
    }
}

extension UILabel {
    enum style {
        typealias View = UILabel
        
        static func titleDark(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .evergreen
                $0.font = FontFamily.InterUI.bold.font(size: CGFloat(size))
            }
        }
        
        static func titleBlue(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .warmBlue
                $0.font = FontFamily.InterUI.medium.font(size: CGFloat(size))
            }
        }
        
        static func darkGrayBold(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .evergreen
                $0.font = FontFamily.InterUI.bold.font(size: CGFloat(size))
            }
        }
        
        static func grayRegular(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .blueGrey
                $0.font = FontFamily.InterUI.regular.font(size: CGFloat(size))
            }
        }
        
        static func grayBold(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .blueGrey
                $0.font = FontFamily.InterUI.bold.font(size: CGFloat(size))
            }
        }
        
        static func infoRegular(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .slate
                $0.font = FontFamily.InterUI.regular.font(size: CGFloat(size))
            }
        }
        
        static func infoBold(size: Float) -> Style<View> {
            return Style<View> {
                $0.textColor = .slate
                $0.font = FontFamily.InterUI.bold.font(size: CGFloat(size))
            }
        }
    }
}
