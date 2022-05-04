//
//  SortedTextRange.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 30/4/2022.
//

import UIKit

final class SortedTextRange: UITextRange {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    private let startPosition: SortedTextPosition
    private let endPosition: SortedTextPosition
    
    override var start: SortedTextPosition {
        return startPosition
    }
    
    override var end: SortedTextPosition {
        return endPosition
    }
    
    override var isEmpty: Bool {
        startPosition.index >= endPosition.index
    }
    
    override var description: String {
        "[\(startPosition.index), \(endPosition.index)]"
    }
    
    var length: Int {
        endPosition.index - startPosition.index
    }
    
    // ============
    // MARK: - Init
    // ============
    
    init(from: SortedTextPosition, to: SortedTextPosition) {
        let start: SortedTextPosition
        let end: SortedTextPosition
        
        // Ensure startPosition is less than endPosition
        if from.index < to.index {
            start = from
            end = to
        } else {
            start = to
            end = from
        }
        startPosition = start
        endPosition = end
    }
    
    init(from: SortedTextPosition, maxIndex: Int, in str: String) {
        if maxIndex >= 0 {
            startPosition = from
            let end = min(str.count, from.index + maxIndex)
            endPosition = SortedTextPosition(index: end)
        } else {
            endPosition = from
            let start = max(0, from.index + maxIndex)
            startPosition = SortedTextPosition(index: start)
        }
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func range(in text: String) -> Range<String.Index>? {
        assert(start <= end, "\(#function): TextRange.start must be <= TextRange.end.")
        assert(text.count == (text as NSString).length) // DEBUG
        
        let startIndex = text.index(
            text.startIndex,
            offsetBy: startPosition.index,
            limitedBy: text.endIndex
        )
        
        let endIndex = text.index(
            text.startIndex,
            offsetBy: end.index,
            limitedBy: text.endIndex
        )
        
        if let startIndex = startIndex, let endIndex = endIndex {
            return startIndex..<endIndex
        }
        
        return nil
    }
    
    func nsRange(in text: String) -> NSRange? {
        if let range = range(in: text) {
            return NSRange(range, in: text)
        } else {
            return nil
        }
    }
}
