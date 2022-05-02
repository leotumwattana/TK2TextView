//
//  TextLayoutFragmentLayer.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 23/4/2022.
//

import UIKit

class TextLayoutFragmentLayer: CALayer {
    
    // ==================
    // MARK: - Properties
    // ==================
    
    var layoutFragment: NSTextLayoutFragment
    var padding: CGFloat
    var showLayerFrames: Bool
    
    let strokeWidth: CGFloat = 2
    
    var renderingSurfaceBoundsStrokeColor: UIColor { .systemOrange }
    var typographicBoundsStrokeColor: UIColor { .systemPurple }
    
    // ============
    // MARK: - Init
    // ============
    
    init(layoutFragment: NSTextLayoutFragment, padding: CGFloat) {
        self.layoutFragment = layoutFragment
        self.padding = padding
        showLayerFrames = false
        super.init()
        contentsScale = 2
        updateGeometry()
        setNeedsDisplay()
    }
    
    override init(layer: Any) {
        let fragmentLayer = layer as! TextLayoutFragmentLayer
        layoutFragment = fragmentLayer.layoutFragment
        padding = fragmentLayer.padding
        showLayerFrames = fragmentLayer.showLayerFrames
        super.init(layer: layer)
        updateGeometry()
        setNeedsDisplay()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    required init?(coder: NSCoder) {
    //        layoutFragment = nil
    //        padding = 0
    //        showLayerFrames = false
    //        super.init(coder: coder)
    //    }
    
    // =================
    // MARK: - Overrides
    // =================
    
    override class func defaultAction(forKey event: String) -> CAAction? {
        // Suppress default opacity animations.
        return NSNull()
    }
    
    override func draw(in ctx: CGContext) {
        layoutFragment.draw(at: .zero, in: ctx)
    }
    
    // ===============
    // MARK: - Helpers
    // ===============
    
    func updateGeometry() {
        bounds = layoutFragment.renderingSurfaceBounds
        if showLayerFrames {
            var typographicBounds = layoutFragment.layoutFragmentFrame
            typographicBounds.origin = .zero
            bounds = bounds.union(typographicBounds)
        }
        // The (0, 0) point in layer space should be the anchor point.
        anchorPoint = CGPoint(
            x: -bounds.origin.x / bounds.size.width,
            y: -bounds.origin.y / bounds.size.height
        )
        
        position = layoutFragment.layoutFragmentFrame.origin
        position.x += padding
    }
    
}
