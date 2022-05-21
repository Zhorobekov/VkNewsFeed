//
//  GradientView.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 21.05.2022.
//

import UIKit

class GradientView: UIView {
    
    @IBInspectable private var startColor: UIColor? {
        didSet {
            setUpGradientColors()
        }
    }
    @IBInspectable private var endColor: UIColor? {
        didSet {
            setUpGradientColors()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setUpGradient() {
        self.layer.addSublayer(gradientLayer)
        setUpGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
    }
    
    private func setUpGradientColors() {
        if let startColor = startColor, let endColor = endColor {
            gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        }
    }
}


