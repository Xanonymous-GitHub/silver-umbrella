//
//  MatchingGame.swift
//  FlipCardGame
//
//  Created by TU-Lin on 2022/3/16.
//

import Foundation
import UIKit

protocol MatchingGame {
    func handleCardClicked(card: UIButton)
}

class MatchingGameImpl : MatchingGame {
    init(cardPairCounts: Int, openColor: UIColor!, closeColor: UIColor!, iconSymbols: Array<String>) {
        assert(cardPairCounts == 2 * iconSymbols.count)
        
        _openColor = openColor
        _closeColor = closeColor
        _cardPairCounts = cardPairCounts
        _cards = []
        _iconSymbols = iconSymbols
        
        _initCardStates()
    }
    
    private final let _openColor: UIColor!
    private final let _closeColor: UIColor!
    private final let _cardPairCounts: Int
    private final var _cards: Array<Card>
    private final let _iconSymbols: Array<String>
    
    public func handleCardClicked(card: UIButton) {
        
    }
    
    private func _initCardStates() {
        for i in 0..<_cardPairCounts {
            let id = i / _cardPairCounts
            _cards.append(
                CardImpl(
                    id: id,
                    title: _iconSymbols[id],
                    openColor: _openColor,
                    closeColor: _closeColor
                )
            )
        }
        
        _cards.shuffle()
    }
}
