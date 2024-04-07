//
//  MorphTransitionAnimator.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 07/04/24.
//

import UIKit

class MorphTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshotView = fromVC.view.snapshotView(afterScreenUpdates: false) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(snapshotView)
        containerView.addSubview(toVC.view)
        
        // Determine the initial and final frames for the snapshot view
        let initialFrame = transitionContext.initialFrame(for: fromVC)
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        // Set the initial frame of the snapshot view to match the fromVC's view frame
        snapshotView.frame = initialFrame
        
        // Hide the original views
        fromVC.view.isHidden = true
        toVC.view.alpha = 0.4
        
        // Perform the animation
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // Slide the snapshot view offscreen horizontally
            snapshotView.frame = finalFrame
            toVC.view.alpha = 1.0
        }) { _ in
            snapshotView.removeFromSuperview()
            fromVC.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
