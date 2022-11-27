//
//  DemoView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 19/11/2022.
//

import UIKit

class FilmNoteView: BaseCustomView {

    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var viewRemove: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewGenres: UIView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewVoteAvg: UIView!
    @IBOutlet weak var img: UIImageView!
    var path: UIBezierPath!
     
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        self.backgroundColor = UIColor.clear
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func draw(_ rect: CGRect) {
//        self.createRectangle()
//        UIColor.init(hex: "#3F4249").setStroke()
//        path.lineWidth = 2
//        path.stroke()
//
//    }

    func createRectangle() {
        // Initialize the path.
//        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 22)
        path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 22)
        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint(x: 0.0, y: 0.0))

        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))

        // Create the bottom line (bottom-left to bottom-right).
        path.addLine(to: CGPoint(x: self.frame.size.width * 1/3, y: self.frame.size.height))

        path.move(to: CGPoint(x: 114, y: 170))
        path.addCurve(to: CGPoint(x: 200, y: 130),
                      controlPoint1: CGPoint(x: 164, y: 170),
                      controlPoint2: CGPoint(x: 150, y: 135))
        path.move(to: CGPoint(x: 200, y: 130))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 130))
        // Close the path. This will create the last line automatically.
        path.close()
    }
    
    
    func drawArcView() {
        let path = UIBezierPath()
        path.addArc(withCenter: self.bounds.origin, radius: 20, startAngle: 3*(.pi)/2, endAngle: .pi/2, clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = APP_COLOR.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        self.layer.addSublayer(shapeLayer)
    }
}


fileprivate enum PathElement {
    case moveToPoint(CGPoint)
    case addLineToPoint(CGPoint)
    case addQuadCurveToPoint(CGPoint, CGPoint)
    case addCurveToPoint(CGPoint, CGPoint, CGPoint)
    case closeSubpath
}

fileprivate extension CGPath {
    
    private class Info {
        var pathElements = [PathElement]()
    }
    
    fileprivate var pathElements: [PathElement] {
        var info = Info()
        
        self.apply(info: &info) { (info, element) -> Void in
            
            if let infoPointer = UnsafeMutablePointer<Info>(OpaquePointer(info)) {
                switch element.pointee.type {
                case .moveToPoint:
                    let pt = element.pointee.points[0]
                    infoPointer.pointee.pathElements.append(.moveToPoint(pt))
                case .addLineToPoint:
                    let pt = element.pointee.points[0]
                    infoPointer.pointee.pathElements.append(.addLineToPoint(pt))
                case .addQuadCurveToPoint:
                    let pt1 = element.pointee.points[0]
                    let pt2 = element.pointee.points[1]
                    infoPointer.pointee.pathElements.append(.addQuadCurveToPoint(pt1, pt2))
                case .addCurveToPoint:
                    let pt1 = element.pointee.points[0]
                    let pt2 = element.pointee.points[1]
                    let pt3 = element.pointee.points[2]
                    infoPointer.pointee.pathElements.append(.addCurveToPoint(pt1, pt2, pt3))
                case .closeSubpath:
                    infoPointer.pointee.pathElements.append(.closeSubpath)
                }
            }
        }
        return info.pathElements
    }
}

public extension UIBezierPath {
    struct CornersRadii {
        let topLeft: CGFloat
        let topRight: CGFloat
        let bottomRight: CGFloat
        let bottomLeft: CGFloat
        
        public init(topLeft: CGFloat, topRight: CGFloat, bottomRight: CGFloat, bottomLeft: CGFloat) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomRight = bottomRight
            self.bottomLeft = bottomLeft
        }
    }

    convenience init(roundedRect rect: CGRect, cornersRadii: CornersRadii) {
        var topLeftCornerPathElements: [PathElement]
        var topRightCornerPathElements: [PathElement]
        var bottomRightCornerPathElements: [PathElement]
        var bottomLeftCornerPathElements: [PathElement]
        
        topLeftCorner: do {
            let cornerRadius = cornersRadii.topLeft <= (min(rect.width, rect.height) / 2) ? cornersRadii.topLeft : (min(rect.width, rect.height)) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rect = CGRect(origin: rect.origin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            topLeftCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .topLeft, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        topRightCorner: do {
            let cornerRadius = cornersRadii.topRight <= (min(rect.width, rect.height) / 2) ? cornersRadii.topRight : (min(rect.width, rect.height)) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rectOrigin = CGPoint(x: rect.origin.x + rect.size.width - (cornerRadius * 2), y: rect.origin.y)
            let rect = CGRect(origin: rectOrigin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            topRightCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .topRight, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        bottomRightCorner: do {
            let cornerRadius = cornersRadii.bottomRight <= (min(rect.width, rect.height) / 2) ? cornersRadii.bottomRight : (min(rect.width, rect.height)) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rectOrigin = CGPoint(x: rect.origin.x + rect.size.width - (cornerRadius * 2), y: rect.origin.y + rect.size.height - (cornerRadius * 2))
            let rect = CGRect(origin: rectOrigin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            bottomRightCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .bottomRight, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        bottomLeftCorner: do {
            let cornerRadius = cornersRadii.bottomLeft <= (min(rect.width, rect.height) / 2) ? cornersRadii.bottomLeft : (min(rect.width, rect.height)) / 2
            let cornerRadii = CGSize(width: cornerRadius, height: cornerRadius)
            let rectOrigin = CGPoint(x: rect.origin.x, y: rect.origin.y + rect.size.height - (cornerRadius * 2))
            let rect = CGRect(origin: rectOrigin, size: CGSize(width: cornerRadius * 2, height: cornerRadius * 2))
            bottomLeftCornerPathElements = UIBezierPath(roundedRect: rect, byRoundingCorners: .bottomLeft, cornerRadii: cornerRadii).cgPath.pathElements
        }
        
        let finalRoundedRectPathElements = [
            topLeftCornerPathElements[0],
            topRightCornerPathElements[1],
            topRightCornerPathElements[2],
            topRightCornerPathElements[3],
            topRightCornerPathElements[4],
            topRightCornerPathElements[5],
            bottomRightCornerPathElements[2],
            bottomRightCornerPathElements[3],
            bottomRightCornerPathElements[4],
            bottomRightCornerPathElements[5],
            bottomRightCornerPathElements[6],
            bottomLeftCornerPathElements[3],
            bottomLeftCornerPathElements[4],
            bottomLeftCornerPathElements[5],
            bottomLeftCornerPathElements[6],
            bottomLeftCornerPathElements[7],
            topLeftCornerPathElements[4],
            topLeftCornerPathElements[5],
            topLeftCornerPathElements[6],
            topLeftCornerPathElements[7],
            topLeftCornerPathElements[8],
            PathElement.closeSubpath
        ]
        
        self.init(pathElements: finalRoundedRectPathElements)
    }
    
    fileprivate convenience init(pathElements elements: [PathElement]) {
        self.init(cgPath: UIBezierPath.from(pathElements: elements).cgPath)
    }
    
    fileprivate static func from(pathElements elements: [PathElement]) -> UIBezierPath {
        let mutablePath = CGMutablePath()
        for element in elements {
            switch element {
            case .moveToPoint(let point):
                mutablePath.move(to: point)
            case .addLineToPoint(let point):
                mutablePath.addLine(to: point)
            case .addCurveToPoint(let control1, let control2, let point):
                mutablePath.addCurve(to: point, control1: control1, control2: control2)
            case .addQuadCurveToPoint(let point, let control):
                mutablePath.addQuadCurve(to: point, control: control)
            case .closeSubpath:
                mutablePath.closeSubpath()
            }
        }
        return UIBezierPath(cgPath: mutablePath)
    }
}

