//
//  KDAutoMaxLayoutWidthLabel.m
//  Xiaoyu
//
//  Created by Blankwonder on 1/14/16.
//  Copyright © 2016 Daxiang. All rights reserved.
//

#import "KDAutoMaxLayoutWidthLabel.h"

@implementation KDAutoMaxLayoutWidthLabel

- (void)layoutIfNeeded {
    self.preferredMaxLayoutWidth = self.frame.size.width;
    [super layoutIfNeeded];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.preferredMaxLayoutWidth = frame.size.width;
}

@end
