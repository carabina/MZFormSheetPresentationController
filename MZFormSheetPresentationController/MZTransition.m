//
//  MZTransition.m
//  MZFormSheetPresentationController
//
//  Created by Michał Zaborowski on 21.12.2013.
//  Copyright (c) 2013 Michał Zaborowski. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MZTransition.h"
#import "MZFormSheetPresentationController.h"

NSString *const MZTransitionExceptionMethodNotImplemented = @"MZTransitionExceptionMethodNotImplemented";

CGFloat const MZTransitionDefaultBounceDuration = 0.4;
CGFloat const MZTransitionDefaultDropDownDuration = 0.4;

@implementation MZTransition

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    [NSException raise:MZTransitionExceptionMethodNotImplemented format:@"-[%@ entryFormSheetControllerTransition:completionHandler:] must be implemented", NSStringFromClass([self class])];
}
- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    [NSException raise:MZTransitionExceptionMethodNotImplemented format:@"-[%@ exitFormSheetControllerTransition:completionHandler:] must be implemented", NSStringFromClass([self class])];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    void (^completionHandler)(void) = [anim valueForKey:@"completionHandler"];
    if (completionHandler) {
        completionHandler();
    }
}

@end

@interface MZSlideFromTopTransition : MZTransition
@end

@implementation MZSlideFromTopTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromTop];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    CGRect originalFormSheetRect = formSheetRect;
    formSheetRect.origin.y = -formSheetRect.size.height;
    formSheetController.contentViewController.view.frame = formSheetRect;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = originalFormSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    formSheetRect.origin.y = -formSheetController.view.bounds.size.height;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = formSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end

@interface MZSlideFromBottomTransition : MZTransition
@end

@implementation MZSlideFromBottomTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromBottom];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromBottom];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    CGRect originalFormSheetRect = formSheetRect;
    formSheetRect.origin.y = formSheetController.view.bounds.size.height;
    formSheetController.contentViewController.view.frame = formSheetRect;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = originalFormSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    formSheetRect.origin.y = formSheetController.view.bounds.size.height;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseIn
        animations:^{
                         formSheetController.contentViewController.view.frame = formSheetRect;
        }
        completion:^(BOOL finished) {
                        completionHandler();
        }];
}
@end

@interface MZSlideFromLeftTransition : MZTransition
@end

@implementation MZSlideFromLeftTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromLeft];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromLeft];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    CGRect originalFormSheetRect = formSheetRect;
    formSheetRect.origin.x = -formSheetController.view.bounds.size.width;
    formSheetController.contentViewController.view.frame = formSheetRect;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = originalFormSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    formSheetRect.origin.x = -formSheetController.view.bounds.size.width;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = formSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end

@interface MZSlideFromRightTransition : MZTransition
@end

@implementation MZSlideFromRightTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromRight];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideFromRight];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    CGRect originalFormSheetRect = formSheetRect;
    formSheetRect.origin.x = formSheetController.view.bounds.size.width;
    formSheetController.contentViewController.view.frame = formSheetRect;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = originalFormSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    formSheetRect.origin.x = formSheetController.view.bounds.size.width;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = formSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end

@interface MZSlideBounceFromLeftTransition : MZTransition
@end

@implementation MZSlideBounceFromLeftTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideAndBounceFromLeft];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideAndBounceFromLeft];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGFloat x = formSheetController.contentViewController.view.center.x;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.values = @[ @(x - formSheetController.view.bounds.size.width), @(x + 20), @(x - 10), @(x) ];
    animation.keyTimes = @[ @(0), @(0.5), @(0.75), @(1) ];
    animation.timingFunctions = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
    animation.duration = MZTransitionDefaultDropDownDuration;
    animation.delegate = self;
    [animation setValue:completionHandler forKey:@"completionHandler"];
    [formSheetController.contentViewController.view.layer addAnimation:animation forKey:@"bounceLeft"];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    formSheetRect.origin.x = -formSheetController.view.bounds.size.width;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = formSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end

@interface MZSlideBounceFromRightTransition : MZTransition
@end

@implementation MZSlideBounceFromRightTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideAndBounceFromRight];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleSlideAndBounceFromRight];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGFloat x = formSheetController.contentViewController.view.center.x;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    animation.values = @[ @(x + formSheetController.view.bounds.size.width), @(x - 20), @(x + 10), @(x) ];
    animation.keyTimes = @[ @(0), @(0.5), @(0.75), @(1) ];
    animation.timingFunctions = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
    animation.duration = MZTransitionDefaultBounceDuration;
    animation.delegate = self;
    [animation setValue:completionHandler forKey:@"completionHandler"];
    [formSheetController.contentViewController.view.layer addAnimation:animation forKey:@"bounceRight"];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGRect formSheetRect = formSheetController.contentViewController.view.frame;
    formSheetRect.origin.x = formSheetController.view.bounds.size.width;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.frame = formSheetRect;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end

@interface MZFadeTransition : MZTransition
@end

@implementation MZFadeTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleFade];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleFade];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    formSheetController.contentViewController.view.alpha = 0;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.alpha = 1;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        animations:^{
                         formSheetController.contentViewController.view.alpha = 0;
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end

@interface MZBounceTransition : MZTransition
@end

@implementation MZBounceTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleBounce];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleBounce];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    bounceAnimation.fillMode = kCAFillModeBoth;
    bounceAnimation.duration = MZTransitionDefaultBounceDuration;
    bounceAnimation.removedOnCompletion = YES;
    bounceAnimation.values = @[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 0.01f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.1f)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 0.9f)],
        [NSValue valueWithCATransform3D:CATransform3DIdentity]
    ];
    bounceAnimation.keyTimes = @[ @0.0f, @0.5f, @0.75f, @1.0f ];
    bounceAnimation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];
    bounceAnimation.delegate = self;
    [bounceAnimation setValue:completionHandler forKey:@"completionHandler"];
    [formSheetController.contentViewController.view.layer addAnimation:bounceAnimation forKey:@"bounce"];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    formSheetController.contentViewController.view.transform = CGAffineTransformMakeScale(0.01, 0.01);

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[ @(1), @(1.2), @(0.01) ];
    animation.keyTimes = @[ @(0), @(0.4), @(1) ];
    animation.timingFunctions = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
    animation.duration = MZFormSheetPresentationControllerDefaultAnimationDuration;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    [animation setValue:completionHandler forKey:@"completionHandler"];
    [formSheetController.contentViewController.view.layer addAnimation:animation forKey:@"bounce"];

    formSheetController.contentViewController.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
}
@end

@interface MZDropDownTransition : MZTransition
@end

@implementation MZDropDownTransition
+ (void)load {
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleDropDown];
    [MZFormSheetPresentationController registerTransitionClass:self forTransitionStyle:MZFormSheetTransitionStyleDropDown];
}

- (void)entryFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGFloat y = formSheetController.contentViewController.view.center.y;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.values = @[ @(y - formSheetController.view.bounds.size.height), @(y + 20), @(y - 10), @(y) ];
    animation.keyTimes = @[ @(0), @(0.5), @(0.75), @(1) ];
    animation.timingFunctions = @[ [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut] ];
    animation.duration = MZTransitionDefaultDropDownDuration;
    animation.delegate = self;
    [animation setValue:completionHandler forKey:@"completionHandler"];
    [formSheetController.contentViewController.view.layer addAnimation:animation forKey:@"dropdown"];
}

- (void)exitFormSheetControllerTransition:(MZFormSheetPresentationController *)formSheetController completionHandler:(MZTransitionCompletionHandler)completionHandler {
    CGPoint point = formSheetController.contentViewController.view.center;
    point.y += formSheetController.view.bounds.size.height;
    [UIView animateWithDuration:MZFormSheetPresentationControllerDefaultAnimationDuration
        delay:0
        options:UIViewAnimationOptionCurveEaseIn
        animations:^{
                         formSheetController.contentViewController.view.center = point;
                         CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                         formSheetController.contentViewController.view.transform = CGAffineTransformMakeRotation(angle);
        }
        completion:^(BOOL finished) {
                         completionHandler();
        }];
}
@end