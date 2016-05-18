//
//  KDEasyTouchButton.h
//  koudaixiang
//
//  Created by Liu Yachen on 6/24/12.
//  Copyright (c) 2012 Suixing Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface KDEasyTouchButton : UIButton {
    UIColor *_highlightMaskColor;
}

@property (nonatomic) IBInspectable BOOL adjustAllRectWhenHighlighted;
@property (nonatomic) IBInspectable BOOL animatedDismissAllRectHighlighted;

@property (nonatomic) IBInspectable UIColor *highlightMaskColor;

@property (nonatomic) IBInspectable BOOL masksToCircle;

@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
