//
//  CustomLayoutFragment.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 24/4/2022.
//

import UIKit

class CustomLayoutFragment: NSTextLayoutFragment {
    
    // =============
    // MARK: - Enums
    // =============
    
    enum FragmentType {
        case regular
        case checklist
    }
    
    // ==================
    // MARK: - Properties
    // ==================
    
    let fragmentType: FragmentType
    
    override var leadingPadding: CGFloat { 32 }
    override var trailingPadding: CGFloat { 24 }
    override var topMargin: CGFloat { 8 }
    override var bottomMargin: CGFloat { 8 }
    
    override var renderingSurfaceBounds: CGRect {
        let lff = layoutFragmentFrame
        let rsb = super.renderingSurfaceBounds
        var result = rsb
            .offsetBy(dx: -rsb.minX, dy: 0)
            .extending(width: rsb.minX)
            
        result = result
            .with(width: max(rsb.width, lff.width))
            .with(height: max(rsb.height, lff.height))
        
        return result
    }
    
    // ============
    // MARK: - Init
    // ============
    
    init(
        fragmentType: FragmentType,
        textElement: NSTextElement,
        range: NSTextRange?
    ) {
        self.fragmentType = fragmentType
        super.init(textElement: textElement, range: range)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ===============
    // MARK: - Drawing
    // ===============
    
    override func draw(at point: CGPoint, in context: CGContext) {
        
        switch fragmentType {
        case .regular:
            break
        case .checklist:
            var config = UIImage.SymbolConfiguration(
//                paletteColors: [.white, .systemBlue]
                paletteColors: [.systemBlue]
            )
            config = config
                .applying(
                    UIImage.SymbolConfiguration(
                        font: UIFont.systemFont(
                            ofSize: 19, weight: .semibold
                        )
                    )
                )
            
            if let image = UIImage(
//                systemName: "checkmark.circle.fill"
                systemName: "circle"
            )?.withConfiguration(config) {
                
                UIGraphicsPushContext(context)
                
                if let typographicBounds = textLineFragments.first?.typographicBounds {
                    let drawingRect = CGRect(
                        origin: typographicBounds
                            .origin.offset(dx: -image.size.width)
                            .offset(dy: typographicBounds.height / 2)
                            .offset(dy: -image.size.height / 2)
                        ,
                        size: image.size
                    )
                    image.draw(in: drawingRect)
                }
                
                UIGraphicsPopContext()
            }
        }
        
        
//        if let typographicBounds = textLineFragments.first?.typographicBounds {
//            let font = UIFont.preferredFont(forTextStyle: .subheadline)
//                .monospaced(weight: .medium)
//
//            let str = NSAttributedString(
//                string: "1.",
//                attributes: [
//                    .font: font,
//                    .foregroundColor: UIColor.systemBlue
//                ]
//            )
//            let size = str.size()
//            let rect = typographicBounds
//                .offsetBy(dx: -size.width, dy: 0)
//                .offsetBy(dx: 0, dy: typographicBounds.height / 2)
//                .offsetBy(dx: 0, dy: -size.height / 2)
//                .with(size: size)
//
//            UIGraphicsPushContext(context)
//            str.draw(in: rect)
//            UIGraphicsPopContext()
//        }
        
        super.draw(at: point, in: context)
    }
}

extension CGRect {
    func with(x: CGFloat) -> Self {
        CGRect(x: x, y: minY, width: width, height: height)
    }
    
    func with(y: CGFloat) -> Self {
        CGRect(x: minX, y: y, width: width, height: height)
    }
    
    func with(origin: CGPoint) -> Self {
        CGRect(origin: origin, size: size)
    }
    
    func with(size: CGSize) -> Self {
        CGRect(origin: origin, size: size)
    }
    
    func with(width: CGFloat) -> Self {
        CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    func with(height: CGFloat) -> Self {
        CGRect(x: minX, y: minY, width: width, height: height)
    }
    
    func extending(width by: CGFloat) -> Self {
        CGRect(x: minX, y: minY, width: width + by, height: height)
    }
    
    func extending(height by: CGFloat) -> Self {
        CGRect(x: minX, y: minY, width: width, height: height + by)
    }
}

extension CGPoint {
    
    func with(x: CGFloat) -> Self {
        CGPoint(x: x, y: y)
    }
    
    func with(y: CGFloat) -> Self {
        CGPoint(x: x, y: y)
    }
    
    func offset(dx: CGFloat = 0, dy: CGFloat = 0) -> Self {
        CGPoint(x: x + dx, y: y + dy)
    }
}

extension UIImage {
    func withColor(_ color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        // 1
        let drawRect = CGRect(x: 0,y: 0,width: size.width,height: size.height)
        // 2
        color.setFill()
        UIRectFill(drawRect)
        // 3
        draw(in: drawRect, blendMode: .destinationIn, alpha: 1)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    var flippedVertically: UIImage {
        UIImage(cgImage: cgImage!, scale: 1, orientation: .downMirrored)
    }
}
