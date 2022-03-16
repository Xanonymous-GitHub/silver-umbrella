//
//  Card.swift
//  FlipCardGame
//
//  Created by TU-Lin on 2022/3/16.
//

import Foundation
import UIKit

protocol Card {
    func faceUp()
    func faceDown()
}

class CardImpl : Card{
    init(id: Int, title: String, openColor: UIColor!, closeColor: UIColor!) {
        self.id = id
        self.title = title
        self.isMatched = false
        self.isOpened = false
        self._openColor = openColor
        self._closeColor = closeColor
    }
    
    private final let _openColor: UIColor!
    private final let _closeColor: UIColor!
    
    public final let id: Int
    public final let title: String
    public final var isOpened: Bool
    public final var isMatched: Bool
    
    public func faceUp() {
        
    }
    
    public func faceDown() {
//        title = ""
    }
}
