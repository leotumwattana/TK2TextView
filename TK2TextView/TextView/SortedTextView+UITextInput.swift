//
//  SortedTextView+UITextInput.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 25/4/2022.
//

import UIKit

extension TextUIView: UITextInput {
    func text(in range: UITextRange) -> String? {
        guard let range = range as? SortedTextRange else { fatalError() }
        guard !range.isEmpty else { return nil }
        
        guard let string = textContentStorage.textStorage?.string
        else { return nil }
        
        let nsRange = range.nsRange(in: string)
        
        return textContentStorage
            .textStorage?
            .attributedSubstring(from: nsRange)
            .string
    }
    
    func replace(_ range: UITextRange, withText text: String) {
        guard let range = range as? SortedTextRange
        else { fatalError() }
        
        guard let selectedTextRange = selectedTextRange as? SortedTextRange
        else { fatalError() }
        
        guard markedTextRange == nil else {
            fatalError("Current logic relies on the assumption that when this method is called, there's no marked area")
        }
        
        let insertionIndex = range.startPosition.index
        
        // after replacement is fulfilled, selected range might change
        // if the replaced range overlapses with selected range, selection
        // is cleared
        guard let textStorage = textContentStorage.textStorage else { return }
        
        textContentStorage.performEditingTransaction {
            textStorage.replaceCharacters(
                in: range.nsRange(in: textStorage.string),
                with: string
            )
        }
        
        if range.endPosition.index <= selectedTextRange.startPosition.index {
            // selected range should change
            let selectionOffset = selectedTextRange.startPosition.index
                - insertionIndex
            let newSelectionOffset = selectionOffset - range.length + text.count
            let newSelectionIndex = newSelectionOffset + insertionIndex
            self.selectedTextRange = SortedTextRange(
                from: SortedTextPosition(
                    index: newSelectionIndex
                ),
                to: SortedTextPosition(
                    index: newSelectionIndex + selectedTextRange.length
                )
            )
        } else if range.startPosition.index >= selectedTextRange.endPosition.index {
            // do nothing
        } else {
            // has intersection
            let insertionEndPosition = SortedTextPosition(
                index: insertionIndex + text.count
            )
            self.selectedTextRange = SortedTextRange(
                from: insertionEndPosition,
                to: insertionEndPosition
            )
        }
    }
    
    var selectedTextRange: UITextRange? {
        get {
            _selectedTextRange
        }
        set {
            if let range = newValue as? SortedTextRange {
                _selectedTextRange = range
            } else {
                fatalError()
            }
        }
    }
    
    var markedTextRange: UITextRange? {
        get {
            _markedTextRange
        }
        set {
            if let range = newValue as? SortedTextRange {
                _markedTextRange = range
            } else {
                fatalError()
            }
        }
    }
    
    var markedTextStyle: [NSAttributedString.Key : Any]? {
        get { _markedTextStyle }
        set { _markedTextStyle = newValue }
    }
    
    func setMarkedText(_ markedText: String?, selectedRange: NSRange) {
        // setMarkedText operation takes effect on current focus point
        // (marked or selected)
        // after marked text is updated, old selection or marked range is
        // replaced, new marked range is always updated and new selection
        // is always changed to a new range within.
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let rangeToReplace = _markedTextRange ?? _selectedTextRange
        else { return }
        
        let rangeStartPosition = rangeToReplace.startPosition
        
        if let markedText = markedText {
            textContentStorage.performEditingTransaction {
                textStorage.replaceCharacters(
                    in: rangeToReplace.nsRange(in: textStorage.string),
                    with: markedText
                )
            }
            let rangeStartIndex = rangeStartPosition.index
            if let swiftRange = Range(selectedRange, in: markedText) {
                
                let swiftRangeOffset = markedText.distance(
                    from: markedText.startIndex,
                    to: swiftRange.lowerBound
                )
                
                let swiftRangeLength = markedText.distance(
                    from: swiftRange.lowerBound,
                    to: swiftRange.upperBound
                )
                
                let selectionStartIndex = rangeStartIndex + swiftRangeOffset
                
                _markedTextRange = SortedTextRange(
                    from: rangeStartPosition,
                    maxIndex: markedText.count,
                    in: textStorage.string
                )
                
                _selectedTextRange = SortedTextRange(
                    from: SortedTextPosition(
                        index: selectionStartIndex
                    ),
                    to: SortedTextPosition(
                        index: selectionStartIndex + swiftRangeLength
                    )
                )
            }
        } else {
            textStorage.replaceCharacters(
                in: rangeToReplace.nsRange(in: textStorage.string),
                with: ""
            )
            _markedTextRange = nil
            _selectedTextRange = SortedTextRange(
                from: rangeStartPosition,
                to: rangeStartPosition
            )
        }
    }
    
    func unmarkText() {
        // unmarkText operation takes effect on current focus point
        // (marked or selected).
        
        // after unmark, marked range is cleared and selection range is
        // at end of previouly marked area.
        if let previousMarkedRange = _markedTextRange {
            let rangeEndPosition = previousMarkedRange.endPosition
            _selectedTextRange = SortedTextRange(
                from: rangeEndPosition,
                to: rangeEndPosition
            )
            _markedTextRange = nil
        }
    }
    
    var beginningOfDocument: UITextPosition {
        SortedTextPosition(index: 0)
    }
    
    var endOfDocument: UITextPosition {
        SortedTextPosition(
            index: textContentStorage.textStorage!.string.count
        )
    }
    
    // ======================================
    // MARK: - Computing Ranges and Positions
    // ======================================
    
    func textRange(
        from fromPosition: UITextPosition,
        to toPosition: UITextPosition
    ) -> UITextRange? {
        guard let from = fromPosition as? SortedTextPosition,
              let to = toPosition as? SortedTextPosition
        else { return nil }
        return SortedTextRange(from: from, to: to)
    }
    
    func position(
        from position: UITextPosition,
        offset: Int
    ) -> UITextPosition? {
        guard let position = position as? SortedTextPosition
        else {
            return nil
        }
        
        guard let textStorage = textContentStorage.textStorage
        else {
            return nil
        }
        
        let proposedIndex = position.index + offset
        // sometimes the system may want to know off-the-one positions,
        // we should just return boundary if we return nil, a guarded fatel
        // error will trigger somewhere else
//        let newOffset = max(min(from.index + offset, textStorage.string.count), 0)
        
        // return nil if proposed index is out of bounds, per documentation
        
        guard proposedIndex >= 0 && proposedIndex <= textStorage.string.count
        else {
            return nil
        }
        
        let result = SortedTextPosition(index: proposedIndex)
        print("*** position from position: \(result)")
        return result
    }
    
    func position(
        from position: UITextPosition,
        in direction: UITextLayoutDirection,
        offset: Int
    ) -> UITextPosition? {
        
        guard let position = position as? SortedTextPosition
        else {
            return nil
        }
        
        var proposedIndex: Int = position.index
        
        switch direction {
        case .left, .up:
            proposedIndex = position.index - offset
        case .right, .down:
            proposedIndex = position.index + offset
        @unknown default:
            fatalError()
        }
        
        // return nil if proposed index is out of bounds
        let count = textContentStorage.textStorage?.string.count ?? 0
        guard proposedIndex >= 0 && proposedIndex <= count
        else {
            return nil
        }
        
        return SortedTextPosition(index: proposedIndex)
    }
    
    func compare(
        _ position: UITextPosition,
        to other: UITextPosition
    ) -> ComparisonResult {
        guard let from = position as? SortedTextPosition,
              let to = other as? SortedTextPosition
        else { return .orderedSame }
        
        if from.index < to.index {
            return .orderedAscending
        } else if from.index > to.index {
            return .orderedDescending
        }
        return .orderedSame
    }
    
    func offset(
        from: UITextPosition,
        to toPosition: UITextPosition
    ) -> Int {
        guard let from = from as? SortedTextPosition,
              let to = toPosition as? SortedTextPosition
        else {
            return 0
        }
        return to.index - from.index
    }
    
    // ========================
    // MARK: - Layout Direction
    // ========================
    
    func position(
        within range: UITextRange,
        farthestIn direction: UITextLayoutDirection
    ) -> UITextPosition? {
        // TODO
        let isStartFirst = compare(range.start, to: range.end) == .orderedAscending
        
        switch direction {
        case .left, .up:
            return isStartFirst ? range.start : range.end
        case .right, .down:
            return isStartFirst ? range.end : range.start
        @unknown default:
            fatalError()
        }
    }
    
    func characterRange(
        byExtending position: UITextPosition,
        in direction: UITextLayoutDirection
    ) -> UITextRange? {
        
        // TODO
        guard let position = position as? SortedTextPosition
        else {
            return nil
        }
        
        switch direction {
        case .left, .up:
            return SortedTextRange(
                from: SortedTextPosition(index: 0),
                to: position
            )
        case .right, .down:
            return SortedTextRange(
                from: position,
                to: SortedTextPosition(index: textContentStorage.textStorage?.string.count ?? 0))
        @unknown default:
            fatalError()
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
    
    func firstRect(for range: UITextRange) -> CGRect {
        return bounds
        // TODO:
//        guard let range = range as? SortedTextRange else {
//            return .zero
//        }
//
//        let nsRange = range.nsRange(
//            in: textContentStorage.textStorage!.string
//        )
//
//        guard let textRange = NSTextRange(
//            nsRange,
//            in: textContentStorage
//        ) else {
//            return .zero
//        }
//
//        var rect = CGRect.zero
//
//        textLayoutManager.enumerateTextSegments(
//            in: textRange,
//            type: .selection
//        ) { _, textSegmentFrame, baselinePosition, textContainer in
//            rect = convert(textSegmentFrame, to: nil)
//            return false
//        }
//        print("*** firstRect: \(rect)")
//        return rect
    }
    
    var documentRange: NSTextRange {
        textContentStorage.documentRange
    }
    
    func caretRect(for position: UITextPosition) -> CGRect {
        // TODO:
        
        let loc = offset(from: beginningOfDocument, to: position)
        
        var selectionFrame: CGRect = .zero.with(
            size: CGSize(width: 3, height: 30)
        )
        
        print("*** loc: \(loc)")
        
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
        guard let range = range as? SortedTextRange else {
            fatalError()
        }
        
        let nsRange = range.nsRange(
            in: textContentStorage.textStorage?.string ?? ""
        )
        
        guard let textRange = NSTextRange(nsRange, in: textContentStorage) else {
            fatalError()
        }
        
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
        
        return rects
    }
    
    func closestPosition(to point: CGPoint) -> UITextPosition? {
        // TODO:
        
        let nav = textLayoutManager.textSelectionNavigation
        
        let selections = nav.textSelections(
            interactingAt: point,
            inContainerAt: textLayoutManager.documentRange.location,
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
        // TODO
        print("*** hehe: \(point)")
        guard let range = range as? SortedTextRange else {
            fatalError()
        }
        return range.startPosition
    }
    
    func characterRange(at point: CGPoint) -> UITextRange? {
        // TODO
        print("*** haha: \(point)")
        return SortedTextRange(
            from: SortedTextPosition(
                index: 0
            ),
            to: SortedTextPosition(
                index: textContentStorage.textStorage?.string.count ?? 0
            ))
    }
    
    var hasText: Bool {
        textContentStorage.textStorage?.string.isEmpty ?? false
    }
    
    func insertText(_ text: String) {
        // insert operation takes effect on current focus point (marked or selected)
        // after insertion, marked range is always cleared, and length of
        // selected range is always zero.
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let rangeToReplace = _markedTextRange ?? _selectedTextRange
        else { return }
        
        let rangeStartIndex = rangeToReplace.startPosition.index
        
        textContentStorage.performEditingTransaction {
            textStorage.replaceCharacters(
                in: rangeToReplace.nsRange(in: textStorage.string),
                with: text
            )
        }
        
        _markedTextRange = nil
        let insertedPosition = SortedTextPosition(
            index: rangeStartIndex + text.count
        )
        _selectedTextRange = SortedTextRange(
            from: insertedPosition,
            to: insertedPosition
        )
        
        textDidChange()
    }
    
    func deleteBackward() {
        // deleteBackward operation takes effect on current focus point
        // after backward deletion, marked range is always cleared, and
        // length of selected range is always zero.
        
        guard let textStorage = textContentStorage.textStorage
        else { fatalError() }
        
        guard let rangeToDelete = _markedTextRange ?? _selectedTextRange
        else { return }
        
        var rangeStartPosition = rangeToDelete.startPosition
        var rangeStartIndex = rangeStartPosition.index
        if rangeToDelete.isEmpty {
            guard rangeStartIndex != 0 else { return }
            rangeStartIndex -= 1
            textContentStorage.performEditingTransaction {
                textStorage.replaceCharacters(
                    in: NSRange(
                        location: rangeStartIndex,
                        length: 1
                    ),
                    with: ""
                )
            }
            rangeStartPosition = SortedTextPosition(index: rangeStartIndex)
        } else {
            textContentStorage.performEditingTransaction {
                textStorage.replaceCharacters(
                    in: rangeToDelete.nsRange(in: textStorage.string),
                    with: ""
                )
            }
        }
        
        _markedTextRange = nil
        _selectedTextRange = SortedTextRange(
            from: rangeStartPosition,
            to: rangeStartPosition
        )
        textDidChange()
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

//extension NSTextLayoutManager {
//
//    var insertionPointLocation: NSTextLocation? {
//        guard let textSelection = textSelections.first(
//            where: { !$0.isLogical }
//        ) else { return nil }
//
//        return textSelectionNavigation
//            .resolvedInsertionLocation(
//                for: textSelection,
//                writingDirection: .leftToRight
//            )
//    }
//}

final class SortedTextSelectionRect: UITextSelectionRect {
    
    override var rect: CGRect {
        return _rect
    }
    
    private let _rect: CGRect
    
    init(rect: CGRect) {
        self._rect = rect
        super.init()
    }
}
