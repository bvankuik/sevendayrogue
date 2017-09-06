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
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!

    private var timer: Timer?
    private var paused = true

    // MARK: - Private functions

    private func refresh() {
        self.title = "Year \(Game.instance.world.epoch)"
        self.worldView.update(with: Game.instance.world)

        if self.paused {
            self.playButton.title = "Play"
            self.nextButton.isEnabled = true
        } else {
            self.playButton.title = "Pause"
            self.nextButton.isEnabled = false
        }
    }

    // MARK: - Actions

    @IBAction func nextButtonAction(_ sender: Any) {
        Game.instance.world.increment()
        self.refresh()
    }

    @IBAction func playButtonAction(_ sender: Any) {
        self.paused = !self.paused
        self.refresh()
    }

    func timerAction() {
        guard !paused else {
            return
        }

        Game.instance.world.increment()
        self.refresh()
    }

    // MARK: - View cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Year \(Game.instance.world.epoch)"
    }

    override func viewDidAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                          selector: #selector(self.timerAction), userInfo: nil,
                                          repeats: true)
    }

}

