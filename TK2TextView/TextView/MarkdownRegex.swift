//
//  MarkdownRegex.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 24/4/2022.
//

import Foundation

public enum MarkdownRegex {
    
    // ======================
    // MARK: - Markdown Regex
    // ======================
    
    private static let headerPattern = "^(?<\(String.md.syntax)>(?<\(String.md.hash)>\\#{1,3}) ) *(\\S)(.*)\\n?"
    
    static let header = try! NSRegularExpression(
        pattern: headerPattern,
        options: [.anchorsMatchLines]
    )
    
    private static let emphasisPattern =
    "(?<\(String.md.leading)>\\*{1,})(?=\\S)([^\\*]+?)(?<\(String.md.trailing)>\\1)"
    
    static let emphasis = try! NSRegularExpression(
        pattern: emphasisPattern,
        options: [.allowCommentsAndWhitespace, .anchorsMatchLines]
    )
    
    private static let highlightPattern = "(?<\(String.md.leading)>::)(?=\\S)(.+?)(?<\(String.md.trailing)>\\1)"
    
    static let highlight = try! NSRegularExpression(
        pattern: highlightPattern,
        options: [.allowCommentsAndWhitespace, .anchorsMatchLines]
    )
    
    private static let strikethroughPattern = "(?<\(String.md.leading)>~~)(?=\\S)(.+?)(?<\(String.md.trailing)>\\1)"
    
    static let strikethrough = try! NSRegularExpression(
        pattern: strikethroughPattern,
        options: [.allowCommentsAndWhitespace, .anchorsMatchLines]
    )
    
    private static let underlinePattern = "(?<\(String.md.leading)>==)(?=\\S)(.+?)(?<\(String.md.trailing)>\\1)"
    
    static let underline = try! NSRegularExpression(
        pattern: underlinePattern,
        options: [.allowCommentsAndWhitespace, .anchorsMatchLines]
    )
    
    private static let inlineCodeblockPattern = "(?<\(String.md.leading)>`{1})[^`\n]+(?<\(String.md.trailing)>`{1})"
    
    static let inlineCodeblock = try! NSRegularExpression(
        pattern: inlineCodeblockPattern,
        options: [.anchorsMatchLines]
    )
    
    private static let codeblockPattern =
    "^(?<\(String.md.leading)>`{3})\\n(?<\(String.md.code)>[\\s\\S]*?)\\n?(?<\(String.md.trailing)>`{3}) *"
    
    static let codeblock = try! NSRegularExpression(
        pattern: codeblockPattern,
        options: [.anchorsMatchLines]
    )
    
    private static let checkboxPattern =
    "^(?<\(String.md.indent)> *)(?<\(String.md.markdownUnit)>(?<\(String.md.markdownSyntax)>-\\s\\[(?<\(String.md.checkboxState)>[ x-])\\])(?<\(String.md.checkbox)> ))(?<\(String.md.content)>.*)\\n?"
    
    static let checkbox = try! NSRegularExpression(
        pattern: checkboxPattern,
        options: [.anchorsMatchLines]
    )
    
    private static let listPattern =
    "^(?<\(String.md.indent)> *)((?<\(String.md.orderedList)>\\d*\\.)|(?<\(String.md.bullet)>\\*))(?<\(String.md.listSpace)> )(?<\(String.md.content)>.*)\\n?"
    
    static let list = try! NSRegularExpression(
        pattern: listPattern,
        options: [.anchorsMatchLines]
    )
    
    /**
     https://davidwells.io/snippets/regex-match-markdown-links
     Can change to the below if we want to detect empty square bracket for the
     title. Only difference is using * or +:
     "(?<!\\!)(?<\(String.md.leading)>\\[)(?<\(String.md.linkTitle)>[^\\[]*)(?<\(String.md.middle)>\\]\\()(?<\(String.md.linkURL)>.*)(?<\(String.md.trailing)>\\))"
     
     "(?<!\!)\[([^\[]+)(\]\()([^\(\n]*)(\))"
     */
    private static let markdownLinkPattern =
    "(?<!\\!)(?<\(String.md.leading)>\\[)(?<\(String.md.linkTitle)>[^\\[]+)(?<\(String.md.middle)>\\]\\()(?<\(String.md.linkURL)>[^\\(\\n]*)(?<\(String.md.trailing)>\\))"
    
    static let markdownLink = try! NSRegularExpression(
        pattern: markdownLinkPattern,
        options: []
    )
    
    // ![alt text](file://images/image.jpg)
    // ![alt text](https://sample.com/image.jpg) ???
    private static let markdownImagePattern =
    "!(?<\(String.md.leading)>\\[)(?<\(String.md.linkTitle)>[^\\[]+)(?<\(String.md.middle)>\\]\\()(?<\(String.md.linkURL)>[^\\(\\n]*)(?<\(String.md.trailing)>\\))"
    
    // TODO: Rename?
    static let markdownImage = try! NSRegularExpression(
        pattern: markdownImagePattern,
        options: [.anchorsMatchLines]
    )
    
    private static let inlineTagPattern =
    "(?<\(String.md.leading)> ?)(?<\(String.md.inlineTag)>(?<!\\S)#[^#\\s]\\S*)(?<\(String.md.trailing)> ?)"
    
    static let inlineTag = try! NSRegularExpression(
        pattern: inlineTagPattern,
        options: [.anchorsMatchLines]
    )
    
    static let dataDetector = try! NSDataDetector(
        types:
            NSTextCheckingResult.CheckingType.link.rawValue
        | NSTextCheckingResult.CheckingType.phoneNumber.rawValue
        | NSTextCheckingResult.CheckingType.phoneNumber.rawValue
    )
}

extension String {
    
    // =================
    // MARK: - String.md
    // =================
    
    enum md {
        @inlinable
        @inline(__always) static var leading: String {
            "leading"
        }
        
        @inlinable
        @inline(__always) static var trailing: String {
            "trailing"
        }
        
        @inlinable
        @inline(__always) static var middle: String {
            "middle"
        }
        
        @inlinable
        @inline(__always) static var syntax: String {
            "syntax"
        }
        
        @inlinable
        @inline(__always) static var code: String {
            "code"
        }
        
        @inlinable
        @inline(__always) static var checkboxState: String {
            "checkboxState"
        }
        
        @inlinable
        @inline(__always) static var checkbox: String {
            "checkbox"
        }
        
        @inlinable
        @inline(__always) static var indent: String {
            "indent"
        }
        
        @inlinable
        @inline(__always) static var content: String {
            "content"
        }
        
        @inlinable
        @inline(__always) static var markdownUnit: String {
            "markdownUnit"
        }
        
        @inlinable
        @inline(__always) static var markdownSyntax: String {
            "markdownSyntax"
        }
        
        @inlinable
        @inline(__always) static var hash: String {
            "hash"
        }
        
        @inlinable
        @inline(__always) static var bullet: String {
            "bullet"
        }
        
        @inlinable
        @inline(__always) static var dash: String {
            "dash"
        }
        
        @inlinable
        @inline(__always) static var orderedList: String {
            "orderedList"
        }
        
        @inlinable
        @inline(__always) static var listSpace: String {
            "listSpace"
        }
        
        @inlinable
        @inline(__always) static var linkTitle: String {
            "linkTitle"
        }
        
        @inlinable
        @inline(__always) static var linkURL: String {
            "linkURL"
        }
        
        @inlinable
        @inline(__always) static var inlineTag: String {
            "inlineTag"
        }
    }
}

