//
//  FSinteractiveTransition.swift
//  FSTransition
//
//  Created by allen_wu on 2019/7/11.
//  Copyright © 2019 Allen. All rights reserved.
//

import UIKit

class FSInteractiveTransition: UIPercentDrivenInteractiveTransition{
    
    var isPanGestureIneration = false
    public var eventBlock: (() -> ())?
    private weak var gestureView: UIView?
    
    func addEdgePageGesture(_ view: UIView, direction: [TransitionDirection]){
        let recognizer = InteractiveTransitionRecognizer.init(target: self, action: #selector(handlePopRecognizer(_:)))
        recognizer.directions = direction
        gestureView = view
        view.addGestureRecognizer(recognizer)
    }
    
    @objc func handlePopRecognizer(_ recognizer: InteractiveTransitionRecognizer){
        var progress:Float = 0.0
        
        switch recognizer.direction {
        case .left, .right:
            print("xxxxx:\(recognizer.translation(in: gestureView!).x)")
            progress = fabsf(Float(recognizer.translation(in: gestureView!).x)) / Float(gestureView!.bounds.width)
            break
        case .top, .bottom:
            progress = fabsf(Float(recognizer.translation(in: gestureView!).y)) / Float(gestureView!.bounds.height)
            break
        case .leftOffset(let offset):
            progress = Float(recognizer.translation(in: gestureView!).x - offset) / Float(gestureView!.bounds.width - offset)
            progress = 1 + progress
            break
        case .rightOffset(let offset):
            progress = Float(recognizer.translation(in: gestureView!).x) / Float(gestureView!.bounds.width - offset)
            progress = progress > 0 ? 0 : -progress
            break
        case .topOffset(let topset):
            progress = fabsf(Float(recognizer.translation(in: gestureView!).y)) / Float(gestureView!.bounds.height - topset)
            break
        case .bottomOffset(let bottomset):
            let yyyy = recognizer.translation(in: gestureView!).y
            progress = fabsf(Float(recognizer.translation(in: gestureView!).y)) / Float(gestureView!.bounds.height - bottomset)
            print("yyyy:\(yyyy)")
            
            break
        }
        
        print("progress: \(progress)")
        progress = min(1.0, max(0.0, progress))
        switch recognizer.state {
        case .began:
            isPanGestureIneration = true
            eventBlock?()
            print("begin")
            break
        case .changed:
            update(CGFloat(progress))
            break
        case .cancelled,.ended,.failed:
            isPanGestureIneration = false
            if progress > 0.5{
                finish()
            }else{
                cancel()
            }
            break
        default:
            break
        }
    }
}
