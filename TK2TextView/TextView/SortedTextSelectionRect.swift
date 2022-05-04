//
//  SortedTextSelectionRect.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 4/5/2022.
//

import UIKit

final class SortedTextSelectionRect: UITextSelectionRect {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var selectionRect: CGRect
    var rectContainsStart: Bool
    var rectContainsEnd: Bool
    
    override var writingDirection: NSWritingDirection {
        .leftToRight
    }
    
    override var isVertical: Bool {
        false
    }
    
    override var rect: CGRect {
        selectionRect
    }
    
    override var containsStart: Bool {
        rectContainsStart
    }
    
    override var containsEnd: Bool {
        rectContainsEnd
    }
    
    override var description: String {
        "[\(rect)]"
    }
    
    // ============
    // MARK: - Init
    // ============
    
    init(
        rect: CGRect,
        containsStart: Bool = false,
        containsEnd: Bool = false
    ) {
        selectionRect = rect
        rectContainsStart = containsStart
        rectContainsEnd = containsEnd
    }
    
}
