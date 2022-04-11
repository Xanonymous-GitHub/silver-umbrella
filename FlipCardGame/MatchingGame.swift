//
//  MatchingGame.swift
//  FlipCardGame
//
//  Created by TU-Lin on 2022/3/16.
//

import Foundation
import UIKit

protocol MatchingGame {
    func handleClicked(from clickedCard: Card)
    func setDebugMode(mode: Bool)
    func reset()
    var cards: Array<Card> { get }
    var flipCounts: Int { get }
    var score: Int { get }
}

class MatchingGameImpl {
    init(cardPairCounts: Int, openColor: UIColor!, closeColor: UIColor!,matchedColor: UIColor!, iconSymbols: Array<String>, cardClickedPostWork: @escaping () -> Void) {
        assert(cardPairCounts == 2 * iconSymbols.count)
        
        _openColor = openColor
        _closeColor = closeColor
        _matchedColor = matchedColor
        _cardPairCounts = cardPairCounts
        cards = []
        _iconSymbols = iconSymbols
        _cardClickedPostWork = cardClickedPostWork
        
        _initCardStates()
    }
    
    private final let _openColor: UIColor!
    private final let _closeColor: UIColor!
    private final let _matchedColor: UIColor!
    private final let _cardPairCounts: Int
    private final let _iconSymbols: Array<String>
    private final var _flipingCard: Card!
    private final var _isFlipingLocked = false
    private final let _cardClickedPostWork: () -> Void
    
    public final var cards: Array<Card>
    public final var flipCounts = 0
    public final var score: Int = 0;
}

extension MatchingGameImpl: MatchingGame {
    public func reset() {
        cards.removeAll(keepingCapacity: true)
        flipCounts = 0
        score = 0
        _initCardStates()
    }
    
    public func handleClicked(from clickedCard: Card) {
        if _isFlipingLocked || clickedCard.isMatched {
            return
        }
        
        clickedCard.flip()
        flipCounts += 1
        
        if _flipingCard == nil {
            _flipingCard = clickedCard
            return
        }
        
        if _flipingCard.matchId == clickedCard.matchId && clickedCard.id != _flipingCard.id{
            clickedCard.markAsMatched()
            _flipingCard.markAsMatched()
            score += 30
            _flipingCard = nil
        } else {
            _isFlipingLocked = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                clickedCard.flip()
                self._flipingCard.flip()
                self._flipingCard = nil
                self.score -= 10
                self._cardClickedPostWork()
                self._isFlipingLocked = false
            }
        }
    }
    
    private func _initCardStates() {
        for i in 0..<_cardPairCounts {
            let matchId = i / 2
            cards.append(
                CardImpl(
                    id: i,
                    matchId: matchId,
                    title: _iconSymbols[matchId],
                    openColor: _openColor,
                    closeColor: _closeColor,
                    matchedColor: _matchedColor
                )
            )
        }
        
        cards.shuffle()
    }
    
    public func setDebugMode(mode isDebugEnabled: Bool) {
        cards.forEach { card in
            card.setDebugMode(mode: isDebugEnabled)
        }
        
        if (isDebugEnabled) {
            score -= 1000
        }
    }
}
