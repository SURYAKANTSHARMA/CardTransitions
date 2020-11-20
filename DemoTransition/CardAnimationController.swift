//
//  CardViewController.swift
//  DemoTransition
//
//  Created by tokopedia on 08/11/20.
//

import UIKit

class CardAnimationController: NSObject {

  let isPresenting :Bool
  let duration: TimeInterval = 0.5

  init(isPresenting: Bool) {
    self.isPresenting = isPresenting

    super.init()
  }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension CardAnimationController: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
         guard let fromVC = transitionContext.viewController(forKey: .from),
           let toVC = transitionContext.viewController(forKey: .to),
           let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
           else {
             return
         }
         
         let containerView = transitionContext.containerView
         let finalFrame = transitionContext.finalFrame(for: toVC)

         snapshot.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20)
         snapshot.layer.cornerRadius = 5
         snapshot.layer.masksToBounds = true
         
         // 1
         UIView.animateKeyframes(
           withDuration: duration,
           delay: 0,
           options: .calculationModeCubic,
           animations: {
     //        // 2
     //        UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/3) {
     //          fromVC.view.layer.transform = AnimationHelper.yRotation(-.pi / 2)
     //        }
     //
     //        // 3
     //        UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) {
     //          snapshot.layer.transform = AnimationHelper.yRotation(0.0)
     //        }
     //
     //        // 4
     //        UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) {
     //          snapshot.frame = finalFrame
     //          snapshot.layer.cornerRadius = 0
     //        }
         },
           // 5
           completion: { _ in
             toVC.view.isHidden = false
             snapshot.removeFromSuperview()
             fromVC.view.layer.transform = CATransform3DIdentity
             transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
         })

    }
    

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return self.duration
  }

//  func animateTransition(using transitionContext: UIViewControllerContextTransitioning)  {
//    let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
//    let fromView = fromVC?.view
//    let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//    let toView = toVC?.view
//
//    let containerView = transitionContext.containerView
//
//    if isPresenting {
//      containerView.addSubview(toView!)
//    }
//
//    let bottomVC = isPresenting ? fromVC : toVC
//    let bottomPresentingView = bottomVC?.view
//
//    let topVC = isPresenting ? toVC : fromVC
//    let topPresentedView = topVC?.view
//    var topPresentedFrame = transitionContext.finalFrame(for: topVC!)
//    let topDismissedFrame = topPresentedFrame
//    topPresentedFrame.origin.y -= topDismissedFrame.size.height
//    let topInitialFrame = topDismissedFrame
//    let topFinalFrame = isPresenting ? topPresentedFrame : topDismissedFrame
//    topPresentedView?.frame = topInitialFrame
//
//    UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
//                   delay: 0,
//                   usingSpringWithDamping: 300.0,
//                   initialSpringVelocity: 5.0,
//                   options: [.allowUserInteraction, .beginFromCurrentState], //[.Alert, .Badge]
//      animations: {
////        topPresentedView?.frame = topFinalFrame
////        let scalingFactor : CGFloat = self.isPresenting ? 0.92 : 1.0
////        bottomPresentingView?.transform = CGAffineTransform.identity.scaledBy(x: scalingFactor, y: scalingFactor)
//
//    }, completion: {
//      (value: Bool) in
//      if !self.isPresenting {
//        fromView?.removeFromSuperview()
//      }
//    })
//
//
//    if isPresenting {
//      animatePresentationWithTransitionContext(transitionContext)
//    } else {
//      animateDismissalWithTransitionContext(transitionContext)
//    }
//  }

  

  func animateDismissalWithTransitionContext(_ transitionContext: UIViewControllerContextTransitioning) {

    let containerView = transitionContext.containerView
    guard
      let presentedControllerView = transitionContext.view(forKey: UITransitionContextViewKey.from)
      else {
        return
    }

    // Animate the presented view off the bottom of the view
    UIView.animate(withDuration: self.duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .allowUserInteraction, animations: {
      presentedControllerView.center.y += containerView.bounds.size.height
    }, completion: {(completed: Bool) -> Void in
      transitionContext.completeTransition(completed)
    })
  }
}




