//
//  ViewController.swift
//  FlipCardGame
//
//  Created by TeU on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var _cardButtons: [UIButton]!
    @IBOutlet var flipCountLabel: UILabel!
    @IBOutlet var debugModeSwitch: UISwitch!
    
    private var _iconList: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐥", "🐝", "🐓", "🐲", "🍄", "⛄️"]
    
    private lazy final var game: MatchingGame = MatchingGameImpl(cardPairCounts: _cardButtons.count, openColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), closeColor: #colorLiteral(red: 0.2066814005, green: 0.7795597911, blue: 0.349144876, alpha: 1), matchedColor: #colorLiteral(red: 0.2605186105, green: 0.2605186105, blue: 0.2605186105, alpha: 1), iconSymbols: _iconList, cardClickedPostWork: _updateCardUIs)
    
    private var _fCount:Int! = 0
    {
        didSet {
            flipCountLabel.text = "Flip Count: \(String(describing: _fCount!))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _updateCardUIs()
    }
    
    
    @IBAction func onCardClicked(_ sender: UIButton, forEvent event: UIEvent) {
        let clickedCardIndex = _findCardIndex(card: sender)!
        _performCardClicked(targetCardIndex: clickedCardIndex)
    }
    
    @IBAction func onDebugModeChanged(_ sender: UISwitch, forEvent event: UIEvent) {
        _setDebugMode(mode: sender.isOn)
    }
    
    
    @IBAction func onRestartCliecked(_ sender: UIButton, forEvent event: UIEvent) {
        _reset()
    }
}

extension ViewController {
    private func _reset() {
        game.reset()
        debugModeSwitch.isOn = false
        _updateCardUIs()
    }
    
    private func _setDebugMode(mode: Bool) {
        game.setDebugMode(mode: mode)
        _updateCardUIs()
    }
    
    private func _updateFCount() {
        _fCount = game.flipCounts
    }
    
    private func _performCardClicked(targetCardIndex: Int) {
        game.handleClicked(from: game.cards[targetCardIndex])
        _updateCardUIs()
    }
    
    private func _findCardIndex(card: UIButton) -> Int! {
        return _cardButtons.firstIndex(of: card)
    }
    
    private func _updateCardUIs() {
        for index in game.cards.indices {
            let targetCardButton = _cardButtons[index]
            let targetCard = game.cards[index]
            
            targetCardButton.setTitle(targetCard.title, for: .normal)
            
            targetCardButton.backgroundColor = targetCard.color
        }
        _updateFCount()
    }
}
