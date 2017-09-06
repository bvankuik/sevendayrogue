//
//  ViewController.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 20/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var worldView: WorldView!

    private var timer: Timer?

    // MARK: - Actions

    func timerAction() {
        self.title = "Year \(Game.instance.world.epoch)"
        self.worldView.update(with: Game.instance.world)
        Game.instance.world.increment()
    }

    // MARK: - View cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.worldView.backgroundColor = UIColor.white
    }

    override func viewDidAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                          selector: #selector(self.timerAction), userInfo: nil,
                                          repeats: true)
    }

}

