//
//  UITableView+KDUtilites.m
//  Xiaoyu
//
//  Created by Blankwonder on 1/9/16.
//  Copyright © 2016 Daxiang. All rights reserved.
//

#import "UITableView+KDUtilites.h"

@implementation UITableView (KDUtilites)
@end

@implementation UITableViewCell (KDUtilites)

- (UITextField *)KD_addTextFieldLeft {
    UITextField *textField = [[UITextField alloc] init];
    textField.textAlignment = NSTextAlignmentRight;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.contentView addSubview:textField];

    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:textField
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.f constant:0.f];
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:textField
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f constant:0.f];
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:textField
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.f constant:15];
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:self.textLabel
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:textField
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.f constant:-15.0f];

    [self.contentView addConstraints:@[c1, c2, c3, c4]];
    
    [self.contentView layoutIfNeeded];

    return textField;
}

@end


