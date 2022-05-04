//
//  SortedTextPosition.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 30/4/2022.
//

import UIKit

final class SortedTextPosition: UITextPosition, NSTextLocation, Comparable {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let index: Int
    
    override var description: String {
        "\(index)"
    }
    
    // ============
    // MARK: - Init
    // ============
    
    init(index: Int) {
        self.index = index
    }
    
    init(position: SortedTextPosition, offset: Int) {
        self.index = position.index + offset
    }
    
    static func < (lhs: SortedTextPosition, rhs: SortedTextPosition) -> Bool {
        lhs.index < rhs.index
    }
}

extension SortedTextPosition {
    func compare(_ location: NSTextLocation) -> ComparisonResult {
        guard let to = location as? SortedTextPosition
        else { fatalError() }
        
        let from = self
        
        if from.index < to.index {
            return .orderedAscending
        } else if from.index > to.index {
            return .orderedDescending
        }
        return .orderedSame
    }
}
