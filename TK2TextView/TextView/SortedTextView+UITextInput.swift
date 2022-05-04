//
//  SortedTextView+UITextInput.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 25/4/2022.
//

import UIKit

extension TextUIView: UITextInput {
    
    // ====================================
    // MARK: - Replacing and Returning Text
    // ====================================
    
    func text(in range: UITextRange) -> String? {
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let textRange = range as? SortedTextRange
        else { return nil }
        
        guard let indexRange = textRange.range(in: textStorage.string)
        else { return nil }
        
        let string = String(textStorage.string[indexRange])
        print("*** \(#function): range = \(range), string = \(string)")
        return string
    }
    
    func replace(_ range: UITextRange, withText text: String) {
        print("\(#function): range = \(range), with text = \(text)")
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let textRange = range as? SortedTextRange,
              let nsRange = textRange.nsRange(in: textStorage.string)
        else { fatalError("\(#function): Failed to convert \(range) to a valid NSRange.") }
                
        /*
         Replace the characters in text storage and update the selectedTextRange.
         Notify inputDelegate before and after doing the change.
         Note that TextRange is a half-open range without including the upper bound.
         */
        
        inputDelegate?.textWillChange(self)
        textContentStorage.performEditingTransaction {
            textStorage.replaceCharacters(in: nsRange, with: text)
        }
        inputDelegate?.textDidChange(self)
        
        let newEnd = SortedTextPosition(
            position: textRange.start,
            offset: text.count
        )
        
        selectedTextRange = SortedTextRange(
            from: textRange.start,
            to: newEnd
        )
    }
    
    
    // =============================================
    // MARK: - Working with Marked and Selected Text
    // =============================================
    
    /*
     It seems like UITextInteraction doesn't support marked text cursor -
     Once markedTextRange has a value, the cursor view disappears.
     */
    
    func setMarkedText(_ markedText: String?, selectedRange: NSRange) {
        print("\(#function): markedText = \(String(describing: markedText)), selectedRange = \(selectedRange)")
        /*
         If marktedText is nil, use "" to clear the existing marked and
         selected text.
         Clear the existing marked text, or the selected text if no marked
         text exists.
         */
        
        guard let textStorage = textContentStorage.textStorage else {
            fatalError()
        }
        
        let rangeToReplace = markedTextRange ?? selectedTextRange
        
        if let rangeToReplace = rangeToReplace as? SortedTextRange,
            let nsRange = rangeToReplace.nsRange(in: textStorage.string)
        {
            inputDelegate?.textWillChange(self)
            
            let newMarkedText = markedText ?? ""
            
            textContentStorage.performEditingTransaction {
                textStorage.replaceCharacters(in: nsRange, with: newMarkedText)
            
                let newEnd = SortedTextPosition(
                    position: rangeToReplace.start,
                    offset: newMarkedText.count
                )
                
                markedTextRange = SortedTextRange(
                    from: rangeToReplace.start,
                    to: newEnd
                )
                
                if let nsRange = (markedTextRange as! SortedTextRange)
                    .nsRange(in: textStorage.string),
                   let markedTextStyle = markedTextStyle
                {
                    textStorage.addAttributes(markedTextStyle, range: nsRange)
                }
            }
            inputDelegate?.textDidChange(self)
        }
        
        /*
         Now that the marked text or selected text is replaced, update
         selectedTextRange with the selectedRange in the marked text.
         */
        
        if let markedText = markedText,
           let markedTextSelectedRange = Range(selectedRange, in: markedText),
           let rangeToReplace = rangeToReplace as? SortedTextRange
        {
            let offset = markedText.distance(
                from: markedText.startIndex,
                to: markedTextSelectedRange.lowerBound
            )
            
            let length = markedText.distance(
                from: markedTextSelectedRange.lowerBound,
                to: markedTextSelectedRange.upperBound
            )
            
            let newStart = SortedTextPosition(
                position: rangeToReplace.start,
                offset: offset
            )
            
            let newEnd = SortedTextPosition(
                position: newStart,
                offset: length
            )
            
            selectedTextRange = SortedTextRange(
                from: newStart,
                to: newEnd
            )
        }
        
        textDidChange()
        print("\(#function): markedTextRange = \(String(describing: markedTextRange))")
        print("\(#function): selectedTextRange = \(String(describing: selectedTextRange))")
    }
    
    func unmarkText() {
        // TODO
        print("\(#function): markedTextRange = \(String(describing: markedTextRange))")
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let markedTextRange = markedTextRange as? SortedTextRange
        else { return }
        
        if let nsRange = markedTextRange.nsRange(in: textStorage.string) {
            inputDelegate?.textWillChange(self)
            textContentStorage.performEditingTransaction {
                markedTextStyle?.keys.forEach { key in
                    textStorage.removeAttribute(key, range: nsRange)
                }
            }
            inputDelegate?.textDidChange(self)
        }
        
        /*
         Set insertion point to the end of the previously marked text,
         then clear markedTextRange
         */
        
        selectedTextRange = SortedTextRange(
            from: markedTextRange.end,
            to: markedTextRange.end
        )
        
        self.markedTextRange = nil
        textDidChange()
        
        /*
         BUG: UITextInteraction doesn't show the cursor after clearing
         markedTextRange. So replace the existing UITextInteraction object
         with a new one. This is most likely a bug.
         */
        
        interactions
            .filter { $0 is UITextInteraction }
            .forEach { removeInteraction($0) }
        
        let newInteraction = UITextInteraction(for: .editable)
        newInteraction.textInput = self
        addInteraction(newInteraction)
        self.textInteraction = newInteraction
    }
    
    // ================================================
    // MARK: - Computing Text Ranges and Text Positions
    // ================================================
    
    var beginningOfDocument: UITextPosition {
        SortedTextPosition(index: 0)
    }
    
    var endOfDocument: UITextPosition {
        return SortedTextPosition(
            index: textContentStorage.textStorage?.string.count ?? 0
        )
    }
    
    func textRange(
        from fromPosition: UITextPosition,
        to toPosition: UITextPosition
    ) -> UITextRange? {
        print("\(#function): from = \(fromPosition), to = \(toPosition)")
        
        guard let start = fromPosition as? SortedTextPosition,
              let end = toPosition as? SortedTextPosition
        else { fatalError("\(#function): The type of `fromPosition` or `toPosition` isn't SortedTextPosition.") }
        
        return start <= end
        ? SortedTextRange(from: start, to: end)
        : SortedTextRange(from: end, to: start)
    }
    
    func position(
        from position: UITextPosition,
        offset: Int
    ) -> UITextPosition? {
        print("\(#function): from = \(position), offset = \(offset)")
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }

        guard let position = position as? SortedTextPosition
        else { fatalError("\(#function): The type of `position` isn't SortedTextPosition") }
        
        let newPosition = SortedTextPosition(
            position: position,
            offset: offset
        )
        
        if newPosition.index >= textStorage.string.count {
            return endOfDocument
        } else if newPosition.index < 0 {
            return beginningOfDocument
        } else {
            return newPosition
        }
    }
    
    func position(
        from position: UITextPosition,
        in direction: UITextLayoutDirection,
        offset: Int
    ) -> UITextPosition? {
        
        print("\(#function): from = \(position), in = \(direction), offset = \(offset)")
        
        guard let position = position as? SortedTextPosition
        else { return nil }
        
        switch direction {
        case .right:
            let newPosition = SortedTextPosition(
                position: position,
                offset: offset
            )
            return newPosition > endOfDocument as! SortedTextPosition
            ? endOfDocument
            : newPosition
        case .left:
            let newPosition = SortedTextPosition(
                position: position,
                offset: -offset
            )
            return newPosition < beginningOfDocument as! SortedTextPosition
            ? beginningOfDocument
            : newPosition
        default:
            return nil
        }
    }
    
    // =================================
    // MARK: - Evaluating Text Positions
    // =================================
    
    func compare(
        _ position: UITextPosition,
        to other: UITextPosition
    ) -> ComparisonResult {
        print("*** \(#function): position = \(position), to = \(other)")
        
        guard let position = position as? SortedTextPosition,
              let other = other as? SortedTextPosition
        else { fatalError("\(#function): The type of `position` or `other` isn't SortedTextPosition") }
        
        if position < other {
            return .orderedAscending
        } else if position > other {
            return .orderedDescending
        }
        return .orderedSame
    }
    
    func offset(
        from: UITextPosition,
        to toPosition: UITextPosition
    ) -> Int {
        
        print("*** \(#function): from = \(from), to = \(toPosition)")
        
        // See from and toPosition can be <uninitailized> for macCalayst.
        // Return 0 in that case.
        guard let from = from as? SortedTextPosition,
              let to = toPosition as? SortedTextPosition
        else {
            print("*** \(#function): The type of `from` or `toPosition` isn't SortedTextPosition.")
            return 0
        }
        return to.index - from.index
    }
    
    // ===================================================================
    // MARK: - Text Layout, writing direction and position related methods
    // Note that this sample only supports left-to-right text direction.
    // ===================================================================
    
    func position(
        within range: UITextRange,
        farthestIn direction: UITextLayoutDirection
    ) -> UITextPosition? {
        
        print("*** \(#function): within range = \(range)")
        
        guard let range = range as? SortedTextRange else {
            fatalError("\(#function): The type of `range` isn't SortedTextRange.")
        }
        
        let isStartFirst = compare(range.start, to: range.end) == .orderedAscending
        
        switch direction {
        case .left, .up:
            return isStartFirst ? range.start : range.end
        case .right, .down:
            return isStartFirst ? range.end : range.start
        @unknown default:
            fatalError("\(#function): Direction `\(direction)` is unknown.")
        }
    }
    
    func characterRange(
        byExtending position: UITextPosition,
        in direction: UITextLayoutDirection
    ) -> UITextRange? {
        
        // TODO
        guard let position = position as? SortedTextPosition
        else { fatalError("\(#function): The type of `position` isn't SortedTextPosition") }
        
        switch direction {
        case .left, .up:
            var newStart = SortedTextPosition(position: position, offset: -1)
            let beginning = beginningOfDocument as! SortedTextPosition
            newStart = newStart < beginning ? beginning : newStart
            return SortedTextRange(from: newStart, to: position)
        case .right, .down:
            var newEnd = SortedTextPosition(position: position, offset: 1)
            let ending = endOfDocument as! SortedTextPosition
            newEnd = newEnd > ending ? ending : newEnd
            return SortedTextRange(from: position, to: newEnd)
        @unknown default:
            fatalError("\(#function): Direction `\(direction)` is unknown.")
        }
    }
    
    func baseWritingDirection(
        for position: UITextPosition,
        in direction: UITextStorageDirection
    ) -> NSWritingDirection {
        .leftToRight
    }
    
    func setBaseWritingDirection(
        _ writingDirection: NSWritingDirection,
        for range: UITextRange
    ) {
        // do nothing
    }
    
    // ========================
    // MARK: - Geometry Methods
    // ========================
    
    func firstRect(for range: UITextRange) -> CGRect {
        // TODO
        print("*** \(#function): range = \(range)")
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let textRange = range as? SortedTextRange else {
            fatalError("\(#function): The type of `range` isn't SortedTextRange.")
        }
        
        guard let nsRange = textRange.nsRange(in: textStorage.string) else {
            print("!!! \(#function): SortedTextRange.nsRange returned nil for \(textRange)")
            return .zero
        }
    
        guard let nsTextRange = NSTextRange(nsRange, in: textContentStorage)
        else{ return .zero }

        // @TextKit2
        var rect = CGRect.zero
        textLayoutManager.enumerateTextSegments(
            in: nsTextRange,
            type: .selection
        ) { _, textSegmentFrame, baselinePosition, textContainer in
            rect = convert(textSegmentFrame, to: nil)
            return false
        }

        return rect
    }
    
    var documentRange: NSTextRange {
        textContentStorage.documentRange
    }
    
    func caretRect(for position: UITextPosition) -> CGRect {
        
        print("*** \(#function): position = \(position)")
        
        let loc = offset(from: beginningOfDocument, to: position)

        var selectionFrame: CGRect = .zero.with(
            size: CGSize(width: 3, height: 30)
        )

        textLayoutManager.enumerateTextSegments(
            in: NSTextRange(NSRange(location: loc, length: 0), in: textContentStorage)!,
            type: .selection
        ) { segmentRange, textSegmentFrame, baselinePosition, textContainer in

            selectionFrame = textSegmentFrame
            if segmentRange == documentRange {
                let font = UIFont.preferredFont(forTextStyle: .body)
                let lineHeight = font.lineHeight
                * NSParagraphStyle.default.lineHeightMultiple
                selectionFrame = CGRect(
                    origin: selectionFrame.origin,
                    size: CGSize(
                        width: selectionFrame.width,
                        height: lineHeight
                    )
                )
            }

            return false
        }

        let result = selectionFrame
            .with(width: 2)
            .offsetBy(dx: padding, dy: 0)

        return result
    }
    
    func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let range = range as? SortedTextRange else { fatalError() }
        
        guard let nsRange = range.nsRange(in: textStorage.string)
        else { return [] }
        
        guard let textRange = NSTextRange(nsRange, in: textContentStorage)
        else { return [] }
        
        var rects = [SortedTextSelectionRect]()
        
        textLayoutManager.enumerateTextSegments(
            in: textRange,
            type: .selection
        ) { textRange, textSegmentFrame, baselineOffset, textContainer in
            let rect = textSegmentFrame.offsetBy(dx: padding, dy: 0)
            let selectionRect = SortedTextSelectionRect(rect: rect)
            rects.append(selectionRect)
            return true
        }
        
        rects.first?.rectContainsStart = true
        rects.last?.rectContainsEnd = true
        
        return rects
    }
    
    func closestPosition(to point: CGPoint) -> UITextPosition? {
        // TODO:
        
        let nav = textLayoutManager.textSelectionNavigation
        
        let selections = nav.textSelections(
            interactingAt: point.offset(dx: -padding, dy: 0),
            inContainerAt: textLayoutManager.documentRange.endLocation,
            anchors: [],
            modifiers: [],
            selecting: true,
            bounds: .zero
        )
        
        guard let s = selections.first else {
            return nil
        }
        
        guard let location = nav.resolvedInsertionLocation(
            for: s,
            writingDirection: .leftToRight
        ) else {
            return nil
        }
        
        let index = textContentStorage.offset(
            from: textLayoutManager.documentRange.location,
            to: location
        )
        
        let position = SortedTextPosition(index: index)
        
        print("*** closestPostion to point: \(point) position: \(position)")
        return position
    }
    
    func closestPosition(
        to point: CGPoint,
        within range: UITextRange
    ) -> UITextPosition? {
        print("*** \(#function): point = \(point), within range = \(range)")
        guard let textRange = range as? SortedTextRange,
              let closestPosition = closestPosition(to: point) as? SortedTextPosition
        else { return nil }
        
        if closestPosition < textRange.start {
            return textRange.start
        } else if closestPosition >= textRange.end {
            return textRange.end
        } else {
            return closestPosition
        }
    }
    
    func characterRange(at point: CGPoint) -> UITextRange? {
        print("*** \(#function): point = \(point)")
        guard let start = closestPosition(to: point) as? SortedTextPosition
        else { return nil }
        
        var end = SortedTextPosition(position: start, offset: 1)
        if let endOfDocument = endOfDocument as? SortedTextPosition,
           endOfDocument < end
        {
            end = endOfDocument
        }
        return SortedTextRange(from: start, to: end)
    }
}

extension SortedTextView {
    func shouldChangeText(
        in range: UITextRange,
        replacementText text: String
    ) -> Bool {
        return true
    }
}
