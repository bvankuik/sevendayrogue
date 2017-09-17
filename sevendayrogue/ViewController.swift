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
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!

    private let timer = DispatchSource.makeTimerSource()
    private var paused = true

    // MARK: - Private functions

    private func refresh() {
        self.refreshTitle()
        self.worldView.update(with: Game.instance.world)

        self.playButton.isEnabled = self.paused
        self.pauseButton.isEnabled = !self.paused
        self.nextButton.isEnabled = self.paused

    }

    private func refreshTitle() {
        self.title = "Round \(Game.instance.world.epoch)"
    }

    // MARK: - Actions

    @IBAction func nextButtonAction(_ sender: Any) {
        Game.instance.world.increment()
        self.refresh()
    }

    @IBAction func playButtonAction(_ sender: Any) {
        self.paused = false
        self.refresh()
    }

    @IBAction func pauseButtonAction(_ sender: Any) {
        self.paused = true
        self.refresh()
    }
    
    @objc func timerAction() {
        guard !paused else {
            return
        }

        Game.instance.world.increment()
        self.refresh()
    }

    // MARK: - View cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer.schedule(deadline: .now(), repeating: 1.0)
        timer.setEventHandler {
            DispatchQueue.main.sync {
                self.timerAction()
            }
        }
        timer.activate()
    }

}

