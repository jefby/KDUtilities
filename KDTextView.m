//
//  KDTextView.m
//  Xiaoyu
//
//  Created by Blankwonder on 1/8/16.
//  Copyright © 2016 Daxiang. All rights reserved.
//
#if 0

#import "KDTextView.h"
#import "KDUtilities.h"
#import "KDColorHelper.h"

@implementation KDTextView {
    UILabel *_placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self KDTextView_init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self KDTextView_init];
    }
    return self;
}

- (void)KDTextView_init {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KDTextView_textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

KDUtilRemoveNotificationCenterObserverDealloc

- (void)KDTextView_textDidChange {
    _placeholderLabel.hidden = self.text.length > 0;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    if (placeholder) {
        if (!_placeholderLabel) {
            _placeholderLabel = [[UILabel alloc] init];
            _placeholderLabel.textColor = [UIColor KD_colorWithCode:0xffB0B7C0];
            _placeholderLabel.font = self.font;
            _placeholderLabel.numberOfLines = 0;
            
            [self addSubview:_placeholderLabel];
        }
        
        _placeholderLabel.text = placeholder;
    } else {
        [_placeholderLabel removeFromSuperview];
        _placeholderLabel = nil;
    }
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    _placeholderLabel.font = font;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _placeholderLabel.frame = CGRectInset(CGRectEdgeInset(self.bounds, self.textContainerInset), 5, 0);

    [_placeholderLabel KD_resizeBaseOnTopWithMaxHeight:self.bounds.size.height];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self KDTextView_textDidChange];
}

@end
#endif
