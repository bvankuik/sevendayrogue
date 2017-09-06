//
//  UIView+Extensions.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 06/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit

extension UIView {

    func constrainToSuperview() {
        guard let superview = self.superview else {
            fatalError("No superview")
        }

        let constraints = [
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
        superview.addConstraints(constraints)
    }

    func constrainToSuperviewMargins() {
        guard let superview = self.superview else {
            fatalError("No superview")
        }

        let viewDict = ["self": self]
        let viewLayouts = ["H:|-[self]-|", "V:|-[self]-|"]

        for layout in viewLayouts {
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: layout, options: [], metrics: nil, views: viewDict))
        }
    }
    
}
