//
//  CodeBlockLayoutFragment.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 27/4/2022.
//

import UIKit

class CodeBlockLayoutFragment: NSTextLayoutFragment {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let segment: CodeBlockSegmentType
    
    override var leadingPadding: CGFloat { 36 }
    override var trailingPadding: CGFloat { 24 }
    
    override var topMargin: CGFloat {
        switch segment {
        case .leading:
            return 8
        case .content:
            return 0
        case .trailing:
            return 8
        }
    }
    override var bottomMargin: CGFloat {
        switch segment {
        case .leading:
            return 0
        case .content:
            return 0
        case .trailing:
            return 8
        }
    }
    
    override var renderingSurfaceBounds: CGRect {
        if let textContainer = textLayoutManager?.textContainer {
            
            let rsb = super.renderingSurfaceBounds
            
            let width = textContainer.size.width
                - leadingPadding
                - trailingPadding
            
            switch segment {
            case .content:
                let minHeight = max(rsb.height, UIFont.code.xHeight)
                print("*** minHeight: \(minHeight)")
                return rsb
                    .with(x: 0)
                    .with(y: 0)
                    .with(width: width)
                    .with(height: minHeight)
                    .offsetBy(
                        dx: leadingPadding,
                        dy: -topMargin
                    )
                    .extending(height: topMargin + bottomMargin + rsb.minY)
            case .leading:
                return rsb
                    .with(x: 0)
                    .with(size: rsb.size)
                    .with(width: width)
                    .offsetBy(dx: leadingPadding, dy: -4)
                    .extending(height: 4)
            case .trailing:
                return rsb
                    .with(x: 0)
                    .with(size: rsb.size)
                    .with(width: width)
                    .offsetBy(
                        dx: leadingPadding,
                        dy: -topMargin
                    )
                    .extending(height: 4)
            }
        }
        return super.renderingSurfaceBounds
    }
    
    // ============
    // MARK: - Init
    // ============
    
    init(
        segment: CodeBlockSegmentType,
        textElement: NSTextElement,
        range: NSTextRange?
    ) {
        self.segment = segment
        super.init(textElement: textElement, range: range)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ===============
    // MARK: - Drawing
    // ===============
    
    override func draw(at point: CGPoint, in context: CGContext) {
        // Draw background
        
        let cornerRadii = CGSize(width: 8, height: 8)
        let corners: UIRectCorner
        
        switch segment {
        case .leading:
            corners = [.topLeft, .topRight]
        case .content:
            corners = []
        case .trailing:
            corners = [.bottomLeft, .bottomRight]
        }
        
        context.saveGState()
        let backgroundPath = UIBezierPath(
            roundedRect: renderingSurfaceBounds,
            byRoundingCorners: corners,
            cornerRadii: cornerRadii
        ).cgPath
        context.addPath(backgroundPath)
        context.setFillColor(UIColor.systemGray5.cgColor)
        context.fillPath()
        context.restoreGState()
        
        context.saveGState()
        let lineWidth: CGFloat = 0.5
        let strokePath = UIBezierPath()
        let strokeBounds = renderingSurfaceBounds
            .insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        switch segment {
        case .leading:
            strokePath.move(to: strokeBounds.bottomLeading)
            strokePath.addLine(
                to: strokeBounds.topLeading
                    .offset(dy: cornerRadii.height)
            )
            strokePath.addQuadCurve(
                to: strokeBounds.topLeading
                    .offset(dx: cornerRadii.width),
                controlPoint: strokeBounds.topLeading
            )
            strokePath.addLine(
                to: strokeBounds.topTrailing
                    .offset(dx: -cornerRadii.width)
            )
            strokePath.addQuadCurve(
                to: strokeBounds.topTrailing
                    .offset(dy: cornerRadii.height),
                controlPoint: strokeBounds.topTrailing
            )
            strokePath.addLine(
                to: strokeBounds.bottomTrailing
            )
        case .content:
            strokePath.move(to: strokeBounds.topLeading)
            strokePath.addLine(to: strokeBounds.bottomLeading)
            strokePath.move(to: strokeBounds.topTrailing)
            strokePath.addLine(to: strokeBounds.bottomTrailing)
        case .trailing:
            strokePath.move(
                to: strokeBounds.topLeading
            )
            strokePath.addLine(
                to: strokeBounds.bottomLeading
                    .offset(dy: -cornerRadii.height)
            )
            strokePath.addQuadCurve(
                to: strokeBounds.bottomLeading
                    .offset(dx: cornerRadii.width),
                controlPoint: renderingSurfaceBounds.bottomLeading
            )
            strokePath.addLine(
                to: strokeBounds.bottomTrailing
                    .offset(dx: -cornerRadii.width)
            )
            strokePath.addQuadCurve(
                to: strokeBounds.bottomTrailing
                    .offset(dy: -cornerRadii.height),
                controlPoint: renderingSurfaceBounds.bottomTrailing
            )
            strokePath.addLine(
                to: strokeBounds.topTrailing
            )
        }
        context.setStrokeColor(UIColor.systemGray3.cgColor)
        context.setLineWidth(lineWidth)
        context.addPath(strokePath.cgPath)
        context.strokePath()
        
        context.restoreGState()
        
        // Draw the text on top
        super.draw(at: point, in: context)
    }
}

extension CGRect {
    var top: CGPoint {
        CGPoint(x: midX, y: minY)
    }
    
    var bottom: CGPoint {
        CGPoint(x: midX, y: maxY)
    }
    
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    var topLeading: CGPoint {
        CGPoint(x: minX, y: minY)
    }
    
    var centerLeading: CGPoint {
        CGPoint(x: minX, y: midY)
    }
    
    var bottomLeading: CGPoint {
        CGPoint(x: minX, y: maxY)
    }
    
    var topTrailing: CGPoint {
        CGPoint(x: maxX, y: minY)
    }
    
    var centerTrailing: CGPoint {
        CGPoint(x: maxX, y: midY)
    }
    
    var bottomTrailing: CGPoint {
        CGPoint(x: maxX, y: maxY)
    }
}
