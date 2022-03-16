//
//  ViewController.swift
//  FlipCardGame
//
//  Created by TeU on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var _cards: [UIButton]!
    @IBOutlet var flipCountLabel: UILabel!
    private var _iconList: [String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁"]
    private var _cardState: [Bool] = Array(repeating: false, count: _iconList.count)
    
    private var _fCount:Int! = 0
    {
        didSet {
            flipCountLabel.text = "Flip Count: \(String(describing: _fCount!))"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _shuffleCardInitValue()
    }
    
    private func _shuffleCardInitValue() {
        _iconList.shuffle()
        let cardAmount = _cards.count
        for i in 0..<cardAmount {
            _changeToCardCloseStyle(card: _cards[i])
        }
    }
    
    
    private func _changeToCardCloseStyle(card: UIButton) {
        card.setTitle("", for: .normal)
        card.backgroundColor = #colorLiteral(red: 0.2066814005, green: 0.7795597911, blue: 0.349144876, alpha: 1)
    }
    
    private func _changeToCardOpenStyle(card: UIButton, title: String) {
        card.setTitle(title, for: .normal)
        card.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    }
    
    private func _performCardClicked(targetCardIndex: Int) {
        let _previousState = _cardState[targetCardIndex]
        let _isCardOpened = !_previousState
        _cardState[targetCardIndex] = _isCardOpened
        
        if (_isCardOpened) {
            _changeToCardOpenStyle(card: _cards[targetCardIndex], title: _iconList[targetCardIndex])
        } else {
            _changeToCardCloseStyle(card: _cards[targetCardIndex])
        }
    }
    
    private func _findCardIndex(card: UIButton) -> Int! {
        return _cards.firstIndex(of: card)
    }
    
    
    @IBAction func onCardClicked(_ sender: UIButton, forEvent event: UIEvent) {
        let clickedCardIndex = _findCardIndex(card: sender)!
        _performCardClicked(targetCardIndex: clickedCardIndex)
        _fCount += 1
    }
}

class CardViewModel {
    final let 
}
