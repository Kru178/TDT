//
//  ProgressView.swift
//  TDT
//
//  Created by Sergei Krupenikov on 03.04.2021.
//

import UIKit

class ProgressView: UIView {

    let shapeLayer = CAShapeLayer()
//    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
        let center = self.center
        
        let circleLayer = CAShapeLayer()
        let circularPath2 = UIBezierPath(arcCenter: center, radius: 25, startAngle: CGFloat(-1.0 * .pi / 2.0), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        circleLayer.path = circularPath2.cgPath
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.fillColor = UIColor.black.cgColor
        circleLayer.strokeEnd = 1.0
        self.layer.addSublayer(circleLayer)
        
        let trackLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: center, radius: 21, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 3
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        self.layer.addSublayer(trackLayer)
        
        let circularPath1 = UIBezierPath(arcCenter: center, radius: 21, startAngle: CGFloat(-1.0 * .pi / 2.0), endAngle: CGFloat(1.5 * .pi), clockwise: true)
        shapeLayer.path = circularPath1.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 3
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeStart = 0.0
        shapeLayer.strokeEnd = 0.75
        self.layer.addSublayer(shapeLayer)
    }
}
