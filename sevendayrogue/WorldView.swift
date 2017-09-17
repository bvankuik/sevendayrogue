//
//  WorldView.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 06/09/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit


extension WorldView {
    class SquareView: UILabel {
        func update(with square: World.Grid.Square) {
            if square.encounters.isEmpty {
                self.text = "·" // Unicode middle dot
            } else {
                if let first = square.encounters.first {
                    self.text = first.emoji
                }
            }
            if square.isBase {
                self.font = UIFont.systemFont(ofSize: constants.baseFontSize)
                self.text = "⍟"  //☆✪ 🏰🏯🏠
            } else {
                self.font = UIFont.systemFont(ofSize: constants.gridFontSize)
            }
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.textAlignment = .center
            self.lineBreakMode = .byTruncatingTail
            self.adjustsFontSizeToFitWidth = true
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension WorldView {

    class GridView: UIView {
        private var squareViews: Array<Array<SquareView>>
        private var stackView = UIStackView()

        // MARK: - Public functions

        func update(with grid: World.Grid) {
            for x in 0 ..< grid.width {
                for y in 0 ..< grid.height {
                    let square = grid[x, y]
                    self.squareViews[x][y].update(with: square)
                }
            }
        }

        // MARK: - Operators

        subscript(x: Int, y: Int) -> SquareView {
            get {
                return self.squareViews[x][y]
            }
            set {
                self.squareViews[x][y] = newValue
            }
        }

        // MARK: - Life cycle

        override init(frame: CGRect) {
            self.squareViews = []
            super.init(frame: frame)

            self.addSubview(self.stackView)
            self.stackView.axis = .horizontal
            self.stackView.distribution = .fillEqually
            self.stackView.translatesAutoresizingMaskIntoConstraints = false
            self.stackView.constrainToSuperview()

            // loop over x
            for _ in 0 ..< constants.worldGridWidth {
                let colStackView = UIStackView()
                colStackView.axis = .vertical
                colStackView.distribution = .fillEqually
                self.stackView.addArrangedSubview(colStackView)

                var squareViewCol: [SquareView] = []

                // loop over y
                for _ in 0 ..< constants.worldGridHeight {
                    let squareView = SquareView()
                    squareViewCol.append(squareView)
                    colStackView.addArrangedSubview(squareView)
                }
                self.squareViews.append(squareViewCol)
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }
}


class WorldView: UIView {

    let gridView = GridView()

    // MARK: - Public functions

    func update(with world: World) {
        self.gridView.update(with: world.grid)
    }

    // MARK: - Life cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        self.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        self.addSubview(self.gridView)
        self.gridView.translatesAutoresizingMaskIntoConstraints = false
        self.gridView.constrainToSuperview()
    }

}
