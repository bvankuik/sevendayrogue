//
//  ViewController.swift
//  sevendayrogue
//
//  Created by Bart van Kuik on 20/08/2017.
//  Copyright © 2017 DutchVirtual. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var worldView: WorldView!
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!

    private let timer = DispatchSource.makeTimerSource()
    private var paused = true

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Actions.allValues.count
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionCell", for: indexPath)

        let action = Actions.allValues[indexPath.row]
        if let actionable = action as? Actionable {
            cell.textLabel?.text = actionable.name
        }
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedAction = Actions.allValues[indexPath.row]
        switch selectedAction {
        case .HailAction():
            Game.instance.world.append(newAction: HailAction())
        }
    }

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
    
    func timerAction() {
        guard !paused else {
            return
        }

        Game.instance.world.increment()
        self.refresh()
    }

    // MARK: - Layout

    override func viewWillLayoutSubviews() {
        let size = self.view.frame.size
        if size.width > size.height {
            self.stackView.axis = .horizontal
        } else {
            self.stackView.axis = .vertical
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            if size.width > size.height {
                self.stackView.axis = .horizontal
            } else {
                self.stackView.axis = .vertical
            }
        }, completion: nil)
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

