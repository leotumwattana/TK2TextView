//
//  SortedTextContentStorage.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 26/4/2022.
//

import UIKit

final class SortedTextContentStorage: NSTextContentStorage {
    
    override func processEditing(
        for textStorage: NSTextStorage,
        edited editMask: NSTextStorage.EditActions,
        range newCharRange: NSRange,
        changeInLength delta: Int,
        invalidatedRange invalidatedCharRange: NSRange
    ) {
        super.processEditing(
            for: textStorage,
            edited: editMask,
            range: newCharRange,
            changeInLength: delta,
            invalidatedRange: invalidatedCharRange
        )
    }
    
}
