//
//  TextUIView+UIKeyInput.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 4/5/2022.
//

import UIKit

extension TextUIView: UIKeyInput {
    var hasText: Bool {
        textContentStorage.textStorage?.string.isEmpty ?? false
    }
    
    func insertText(_ text: String) {
        print("\(#function)")
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let rangeToReplace = (markedTextRange ?? selectedTextRange) as? SortedTextRange
        else { fatalError() }
        
        guard let nsRangeToReplace = rangeToReplace.nsRange(in: textStorage.string)
        else { return }
        
        let attributedText = NSAttributedString(string: text)
        inputDelegate?.textWillChange(self)
        
        textContentStorage.performEditingTransaction {
            textStorage.replaceCharacters(in: nsRangeToReplace, with: attributedText)
        }
        
        markedTextRange = nil
        
        let newCursorPosition = SortedTextPosition(
            position: rangeToReplace.start,
            offset: text.count
        )
        
        selectedTextRange = SortedTextRange(
            from: newCursorPosition,
            to: newCursorPosition
        )
        
        inputDelegate?.textDidChange(self)
        
        textDidChange()
    }
    
    func deleteBackward() {
        print("\(#function)")
        
        guard let textStorage = textContentStorage.textStorage,
              !textStorage.string.isEmpty
        else { fatalError() }
        
        guard let rangeToDelete = (markedTextRange ?? selectedTextRange) as? SortedTextRange
        else { return }
        
        guard let nsRangeToDelete = rangeToDelete.nsRange(in: textStorage.string)
        else { return }
        
        inputDelegate?.textWillChange(self)
        textContentStorage.performEditingTransaction {
            textStorage.deleteCharacters(in: nsRangeToDelete)
        }
        markedTextRange = nil //?? Support the case of deleting a character of the marked text?
        selectedTextRange = SortedTextRange(
            from: rangeToDelete.start,
            to: rangeToDelete.start
        )
        inputDelegate?.textDidChange(self)
        textDidChange()
    }
}
