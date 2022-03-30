//
//  Card.swift
//  FlipCardGame
//
//  Created by TU-Lin on 2022/3/16.
//

import Foundation
import UIKit

protocol Card {
    func flip()
    func markAsMatched()
    func setDebugMode(mode: Bool)
    var id: Int { get }
    var matchId: Int { get }
    var color: UIColor { get }
    var title: String { get }
    var isOpened: Bool { get }
    var isMatched: Bool { get }
}

class CardImpl {
    init(id: Int, matchId: Int, title: String, openColor: UIColor!, closeColor: UIColor!, matchedColor: UIColor!) {
        self.id = id
        self.matchId = matchId
        _emoji = title
        isMatched = false
        isOpened = false
        _openColor = openColor
        _closeColor = closeColor
        _matchedColor = matchedColor
    }
    
    private final let _openColor: UIColor!
    private final let _closeColor: UIColor!
    private final let _matchedColor: UIColor!
    private final var _emoji: String
    private final var _isDebugShowTitleEnabled = false

    public final let id: Int
    public final let matchId: Int
    public final var isOpened: Bool
    public final var isMatched: Bool
}

extension CardImpl: Card {
    public func setDebugMode(mode: Bool) {
        _isDebugShowTitleEnabled = mode
    }
    
    public func flip() {
        isOpened = !isOpened
    }
    
    public func markAsMatched() {
        isOpened = true
        isMatched = true
    }
    
    public final var color: UIColor {
        get {
            if (isMatched) {
                return _matchedColor
            }
            
            return isOpened ? _openColor : _closeColor
        }
    }
    
    public final var title: String {
        get {
            return _isDebugShowTitleEnabled || isMatched || isOpened ? _emoji : ""
        }
    }
}
