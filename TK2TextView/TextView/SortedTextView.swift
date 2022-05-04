//
//  SortedTextView.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 23/4/2022.
//

import UIKit
import SwiftUI

//let sampleText = "- [ ] Testing"

let sampleText = "Hello world\nThis is another line."

//let sampleText = "# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n```\n```\n```\n\n```\n```\nThis is a sample code block. This is a sample code block. This is a sample code block. \n```\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n- [ ] [Apple](https://apple.com)\n## Description\n- [ ] **Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\n# This is a title.\n[Apple](https://apple.com)\n## Description\n**Hello world 1 Hello world 2** *Hello world 3 Hello world 4* ***Hello world 5 Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5*** Hello world 1 Hello world 2 Hello world 3 Hello world 4 Hello world 5\n\nThe End"

struct SortedTextView: UIViewRepresentable {
    
    typealias UIViewType = TextUIView
    
    func makeUIView(context: Context) -> TextUIView {
        let view = TextUIView(frame: .zero)
        return view
    }
    
    func updateUIView(_ uiView: TextUIView, context: Context) { }
}

class TextUIView: UIScrollView {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    /**
     Boolean value that controls whether the text view allow the
     user to edit text.
     */
    var isEditable: Bool = true {
        didSet {
            isSelectable = isEditable
        }
    }
    
    /**
     Boolean value that controls whether the text view allow
     selection of text.
     */
    var isSelectable: Bool = true {
        didSet {
            // TODO
        }
    }
    
    /**
     Getter on whether we draw insertion caret or not.
     */
    var shouldDrawInsertionPoint: Bool {
        isFirstResponder && isSelectable
    }
    
    /**
     TextKit 2 NSTextContentStorage component.
     */
    let textContentStorage: NSTextContentStorage
    
    /**
     TextKit 2 NSTextLayoutManager component.
     */
    let textLayoutManager: NSTextLayoutManager
    
    /**
     Text selection color
     */
    let selectionColor: UIColor = .systemBlue
    
    /**
     Caret color
     */
    let caretColor: UIColor = .systemRed
    
    /**
     The amount to overscroll at the bottom of all content.
     */
    var overscrollBottom: CGFloat = 60
    
    override var canBecomeFirstResponder: Bool {
        true
    }
    
    override var canBecomeFocused: Bool {
        true
    }
    
    
    
    /**
     Text content
     */
//    var string: String {
//        get { textContentStorage.attributedString?.string ?? "" }
//        set { setString(newValue) }
//    }
    
    private var contentLayer: CALayer = TextLayer()
    private var selectionLayer: CALayer = TextLayer()
    private var fragmentLayerMap: NSMapTable<NSTextLayoutFragment, CALayer>
    let padding: CGFloat = 5
    
        
    // ==============================
    // MARK: - UITextInput properties
    // ==============================
    
    var inputDelegate: UITextInputDelegate?
    
    var selectedTextRange: UITextRange? {
        willSet {
            print("\(#function): current = \(String(describing: selectedTextRange))")
            print("\(#function): new = \(String(describing: newValue))")
            inputDelegate?.selectionWillChange(self)
        }
        didSet {
            inputDelegate?.selectionDidChange(self)
        }
    }
    
    var markedTextRange: UITextRange?
    
    var markedTextStyle: [NSAttributedString.Key : Any]?
    
    lazy var tokenizer: UITextInputTokenizer = {
        UITextInputStringTokenizer(textInput: self)
    }()
    
    // =========================
    // MARK: - UITextInteraction
    // =========================
    
    var textInteraction = UITextInteraction(for: .editable)

    // ============
    // MARK: - Init
    // ============
    
    override init(frame: CGRect) {
        fragmentLayerMap = .weakToWeakObjects()
        textLayoutManager = NSTextLayoutManager()
        textContentStorage = SortedTextContentStorage()
        
        super.init(frame: frame)
        
        layer.backgroundColor = UIColor.white.cgColor
        selectionLayer.backgroundColor = UIColor.red.cgColor
        contentLayer.backgroundColor = UIColor.systemPurple.cgColor
        
        layer.addSublayer(selectionLayer)
        layer.addSublayer(contentLayer)
        
        textContentStorage.delegate = self
        textContentStorage.textStorage?.delegate = self
        textContentStorage.addTextLayoutManager(textLayoutManager)
        
        textLayoutManager.delegate = self
        textLayoutManager.textViewportLayoutController.delegate = self
        
        let textContainer = NSTextContainer(size: .zero)
        textContainer.widthTracksTextView = true
        textLayoutManager.textContainer = textContainer
        
        textInteraction.textInput = self
        addInteraction(textInteraction)
//        backgroundColor = .systemGray
        
        print("*** sv: \(subviews)")
        setString(sampleText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ==============
    // MARK: - Layout
    // ==============
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("*** ****bounds: \(bounds)")
        updateTextContainerSize()
        textLayoutManager
            .textViewportLayoutController
            .layoutViewport()
        updateContentSizeIfNeeded()
    }
}

// ===============
// MARK: - Helpers
// ===============

extension TextUIView {
    
    private func setString(_ string: String) {
        // TODO: Undo Manager stuff
        textContentStorage.performEditingTransaction {
            let str = NSAttributedString(string: string)
            textContentStorage.textStorage?.setAttributedString(str)
        }
        textDidChange()
    }
    
    func textDidChange() {
//        layoutIfNeeded()
        updateTextContainerSize()
        updateContentSizeIfNeeded()
    }
    
    private func updateTextContainerSize() {
        guard let textContainer = textLayoutManager.textContainer,
              textContainer.size.width != bounds.width
        else { return }
        textContainer.size = CGSize(width: bounds.size.width, height: 0)
        layer.setNeedsLayout()
    }
    
    func updateContentSizeIfNeeded() {
        let currentHeight = bounds.height
        var height: CGFloat = 0
        
        textLayoutManager.enumerateTextLayoutFragments(
            from: textLayoutManager.documentRange.endLocation,
            options: [.reverse, .ensuresLayout]
        ) { layoutFragment in
            height = layoutFragment.layoutFragmentFrame.maxY
            return false // stop
        }
        
        height += overscrollBottom
        
        if abs(currentHeight - height) > 1e-10 {
            contentSize = CGSize(width: bounds.width, height: height)
        }
    }
}

// ====================================
// MARK: - NSTextContentManagerDelegate
// ====================================

extension TextUIView: NSTextContentManagerDelegate {
    /*
     The text content manager calls this method to determine whether each
     text element should be enumerated for layout.
     To hide comments, tell the text content manager not to enumerate this
     element if it's a comment.
     */
    func textContentManager(
        _ textContentManager: NSTextContentManager,
        shouldEnumerate textElement: NSTextElement,
        options: NSTextContentManager.EnumerationOptions = []
    ) -> Bool {
        return true
    }
}

/**
 Note: This doesn't seem to do anything. It seems NSTextStorageDelegate doesn't
 get called in TextKit 2.
 */
extension TextUIView: NSTextStorageDelegate {
    
    func textStorage(
        _ textStorage: NSTextStorage,
        willProcessEditing editedMask: NSTextStorage.EditActions,
        range editedRange: NSRange,
        changeInLength delta: Int
    ) {
        MarkdownRegex.codeblock.matches(
            in: textStorage.string,
            range: textStorage.string.fullNSRange
        ).forEach { match in
            let leadingRange = match.range(withName: .md.leading)
            let trailingRange = match.range(withName: .md.trailing)
//            let codeRange = match.range(withName: .md.code)
            
            textStorage.addAttributes(
                [
                    .font: UIFont.code,
                    .foregroundColor: UIColor.systemGray,
                    .codeBlock: CodeBlockSegmentType.content
                ],
                range: match.range
            )
   
            textStorage.addAttributes(
                [
                    .foregroundColor: UIColor.systemGray,
                    .codeBlock: CodeBlockSegmentType.leading
                ],
                range: leadingRange
            )
            
            textStorage.addAttributes(
                [
                    .foregroundColor: UIColor.systemGray,
                    .codeBlock: CodeBlockSegmentType.trailing
                ],
                range: trailingRange
            )
        }
    }
    
    func textStorage(
        _ textStorage: NSTextStorage,
        didProcessEditing editedMask: NSTextStorage.EditActions,
        range editedRange: NSRange,
        changeInLength delta: Int
    ) {
        print("*** didProcessEditing: \(editedMask) range: \(editedRange) changeInLength: \(delta)")
    }
}

// ====================================
// MARK: - NSTextContentStorageDelegate
// ====================================

extension TextUIView: NSTextContentStorageDelegate {
    /*
     In this method, we'll inject some attributes for display, without
     modifying the text storage directly.
     */
    func textContentStorage(
        _ textContentStorage: NSTextContentStorage,
        textParagraphWith range: NSRange
    ) -> NSTextParagraph? {
        
        
        guard let text = textContentStorage
            .attributedString?
            .attributedSubstring(from: range)
        else { return nil }
        
        let str = NSMutableAttributedString(attributedString: text)
        str.addAttributes(
            [
                .font: UIFont.preferredFont(forTextStyle: .body)
            ],
            range: str.string.fullNSRange
        )
        
        let string = str.string
        let fullNSRange = string.fullNSRange
        
        MarkdownRegex.header.matches(
            in: string,
            range: fullNSRange
        ).forEach { match in
            let syntaxRange = match.range(withName: .md.syntax)
            let hashRange = match.range(withName: .md.hash)

            let font: UIFont

            /*
             Note: Using the trick to set font size to 0.0001 seems
             to throw off content height estimate calculation.
             So in order to hide these syntax characters, we are going
             to replace them with Unicode Zero Width Space.
             */

            str.replaceCharacters(
                in: syntaxRange,
                with: .zeroWidthSpaces(count: syntaxRange.length)
            )

            switch hashRange.length {
            case 1:
                font = UIFont.preferredFont(
                    for: .title1,
                    weight: .medium
                )
            case 2:
                font = UIFont.preferredFont(
                    for: .title2,
                    weight: .medium
                )
            case 3:
                font = UIFont.preferredFont(
                    for: .title3,
                    weight: .medium
                )
            default:
                return
            }

            str.addAttributes(
                [
                    .font: font,
                    .foregroundColor: UIColor.systemBlue
                ],
                range: match.range)
        }
        
        
        let markdownCheckbox = "- [ ] "
        if string.hasPrefix(markdownCheckbox) {
            let syntaxLength = markdownCheckbox
                .nsString
                .length
            
            let syntaxRange = fullNSRange
                .with(length: syntaxLength)
            
            str.replaceCharacters(
                in: syntaxRange,
                with: .zeroWidthSpaces(count: syntaxLength)
            )
            
            str.addAttributes(
                [
                    .checklistItem: true
                ],
                range: fullNSRange
            )
        }
        
        MarkdownRegex.emphasis.matches(
            in: string,
            range: fullNSRange
        ).forEach { match in
            let matchRange = match.range
            let leadingRange = match.range(withName: .md.leading)
            let trailingRange = match.range(withName: .md.trailing)

            var font: UIFont = str.font(
                at: matchRange.lowerBound
            ) ?? UIFont.preferredFont(forTextStyle: .body)

            /*
             Hide characters by replacing them with Unicode Zero
             Width Space.
             */
            str.replaceCharacters(
                in: leadingRange,
                with: .zeroWidthSpaces(count: leadingRange.length)
            )
            
            /*
             Hide characters by replacing them with Unicode Zero
             Width Space.
             */
            str.replaceCharacters(
                in: trailingRange,
                with: .zeroWidthSpaces(count: trailingRange.length)
            )
            
            switch leadingRange.length {
            case 1:
                font = font.italic
            case 2:
                font = font.bold
            case 3:
                font = font.boldItalic
            default:
                break
            }

            str.addAttributes([.font: font], range: matchRange)
        }
        
        MarkdownRegex.markdownLink.matches(
            in: string,
            options: [.withoutAnchoringBounds],
            range: fullNSRange
        ).forEach { match in
            
            let titleRange = match.range(withName: .md.linkTitle)
            
            let titleString = string
                .nsString
                .substring(with: titleRange)

            let urlRange = match.range(withName: .md.linkURL)
            
            let urlString = string
                .nsString
                .substring(with: urlRange)

            let hiddenRange = urlRange.extending(length: -1)
            
            str.replaceCharacters(
                in: hiddenRange,
                with: .zeroWidthSpaces(count: hiddenRange.length)
            )
            
            let linkSymbolRange = hiddenRange
                .offset(location: hiddenRange.length)
                .with(length: 1)
            
            str.replaceCharacters(
                in: linkSymbolRange,
                with: .linkSymbol
            )
            
            str.addAttributes(
                [
                    .foregroundColor: UIColor.systemBlue
                ],
                range: match.range)
            
            str.addAttributes(
                [
                    .foregroundColor: UIColor.systemGray
                ],
                to: [
                    match.range(withName: .md.leading),
                    match.range(withName: .md.middle),
                    match.range(withName: .md.trailing)
                ])
        }
        
        return NSTextParagraph(attributedString: str)
    }
}





// ==============================================
// MARK: - NSTextViewportLayoutControllerDelegate
// ==============================================

extension TextUIView: NSTextViewportLayoutControllerDelegate {
    
    /**
     NSTextViewportLayoutControllerDelegate Required
     */
    func viewportBounds(
        for textViewportLayoutController: NSTextViewportLayoutController
    ) -> CGRect {
        
        let visibleRect = CGRect(
            origin: contentOffset,
            size: bounds.size
        )
        
        return visibleRect.insetBy(dx: 0, dy: -100)
    }
    
    /**
     NSTextViewportLayoutControllerDelegate Required
     */
    func textViewportLayoutController(
        _ textViewportLayoutController: NSTextViewportLayoutController,
        configureRenderingSurfaceFor textLayoutFragment: NSTextLayoutFragment
    ) {
        if let fragmentLayer = fragmentLayerMap.object(
            forKey: textLayoutFragment
        ) as? TextLayoutFragmentLayer {
            let oldFrame = fragmentLayer.frame
            fragmentLayer.updateGeometry()
            if oldFrame != fragmentLayer.frame {
                fragmentLayer.setNeedsDisplay()
            }
            contentLayer.addSublayer(fragmentLayer)
        } else {
            let fragmentLayer = TextLayoutFragmentLayer(
                layoutFragment: textLayoutFragment,
                padding: padding
            )
            contentLayer.addSublayer(fragmentLayer)
            fragmentLayerMap.setObject(
                fragmentLayer,
                forKey: textLayoutFragment
            )
        }
    }
    
    /*
     NSTextViewportLayoutControllerDelegate Optional
     */
    func textViewportLayoutControllerWillLayout(
        _ textViewportLayoutController: NSTextViewportLayoutController
    ) {
        contentLayer.sublayers = nil
        CATransaction.begin()
    }
    
    /*
     NSTextViewportLayoutControllerDelegate Optional
     */
    func textViewportLayoutControllerDidLayout(
        _ textViewportLayoutController: NSTextViewportLayoutController
    ) {
        CATransaction.commit()
        updateSelectionHighlights()
        updateContentSizeIfNeeded()
        adjustViewportOffsetIfNeeded()
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    private func animate(
        _ layer: CALayer,
        from source: CGPoint,
        to destination: CGPoint
    ) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = source
        animation.toValue = destination
        animation.duration = 0.3
        layer.add(animation, forKey: nil)
    }
    
    private func adjustViewportOffsetIfNeeded() {
        let viewportLayoutController = textLayoutManager
            .textViewportLayoutController
        
        let contentOffset = bounds.minY
        
        let order = viewportLayoutController.viewportRange!.location
            .compare(textLayoutManager.documentRange.location)
        
        if contentOffset < bounds.height && order == .orderedDescending {
            // Nearing top, see if we need to adjust and make room above.
            adjustViewportOffset()
        } else if order == .orderedSame {
            // At top, see if we need to adjust and reduce space above.
            adjustViewportOffset()
        }
    }
    
    private func adjustViewportOffset() {
        let viewportLayoutController = textLayoutManager
            .textViewportLayoutController
        var layoutYPoint: CGFloat = 0
        textLayoutManager.enumerateTextLayoutFragments(
            from: viewportLayoutController.viewportRange!.location,
            options: [.reverse, .ensuresLayout]
        ) { layoutFragment in
            layoutYPoint = layoutFragment.layoutFragmentFrame.origin.y
            return true
        }
        
        if layoutYPoint != 0 {
            let adjustmentDelta = bounds.minY - layoutYPoint
            viewportLayoutController.adjustViewport(
                byVerticalOffset: adjustmentDelta
            )
            let point = CGPoint(
                x: contentOffset.x,
                y: contentOffset.y + adjustmentDelta
            )

            setContentOffset(point, animated: true)
        }
    }
    
    private func updateSelectionHighlights() {
//        guard !textLayoutManager.textSelections.isEmpty else { return }
//
//        selectionLayer.sublayers = nil
//
//        for textSelection in textLayoutManager.textSelections {
//            for textRange in textSelection.textRanges {
//                textLayoutManager.enumerateTextSegments(
//                    in: textRange,
//                    type: .highlight,
//                    options: []
//                ) { textSegmentRange, textSegmentFrame, baselinePosition, textContainer in
//
//                    var highlightFrame = textSegmentFrame
//                    highlightFrame.origin.x += padding
//                    let highlight = TextLayer()
//                    if highlightFrame.size.width > 0 {
//                        highlight.backgroundColor = selectionColor.cgColor
//                    } else {
//                        highlightFrame.size.width = 1 // Fatten up the cursor.
//                        highlight.backgroundColor = caretColor.cgColor
//                    }
//                    highlight.frame = highlightFrame
//                    selectionLayer.addSublayer(highlight)
//                    return true // Keep going
//                }
//            }
//        }
    }
}

extension TextUIView: NSTextLayoutManagerDelegate {
    func textLayoutManager(
        _ textLayoutManager: NSTextLayoutManager,
        textLayoutFragmentFor location: NSTextLocation,
        in textElement: NSTextElement
    ) -> NSTextLayoutFragment {
        
        let index = textLayoutManager.offset(
            from: textLayoutManager.documentRange.location,
            to: location
        )
        
        if let str = textContentStorage.attributedString(for: textElement),
           !str.string.isEmpty
        {
            if let _ = str.attribute(
                .checklistItem,
                at: 0,
                effectiveRange: nil
            ) {
                return CustomLayoutFragment(
                    fragmentType: .checklist,
                    textElement: textElement,
                    range: textElement.elementRange
                )
            } else if let segmentType = str.attribute(
                .codeBlock,
                at: 0,
                effectiveRange: nil
            ) as? CodeBlockSegmentType {
                return CodeBlockLayoutFragment(
                    segment: segmentType,
                    textElement: textElement,
                    range: textElement.elementRange
                )
            }
        }
        
        return CustomLayoutFragment(
            fragmentType: .regular,
            textElement: textElement,
            range: textElement.elementRange
        )
    }
}


