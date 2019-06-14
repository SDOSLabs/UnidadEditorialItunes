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

extension UINavigationBar {
    enum style {
        typealias View = UINavigationBar
        
        static var general: Style<View> {
            return Style<View> {
                $0.tintColor = .white
                $0.barTintColor = .charcoalGrey
                $0.isTranslucent = false
                $0.prefersLargeTitles = true
                $0.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                $0.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                $0.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
                UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).textColor = UIColor.white
                
                for view in $0.subviews {
                    let subviews = view.subviews
                    if subviews.count > 0, let label = subviews[0] as? UILabel {
                        label.textColor = UIColor.white
                    }
                }
            }
        }
    }
}

typealias StyleSDOS = Style

extension UISearchBar {
    enum style {
        typealias View = UISearchBar
        
        static var general: StyleSDOS<View> {
            return StyleSDOS<View> {
                $0.barTintColor = .white
                $0.tintColor = .white
                
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            }
        }
    }
}
