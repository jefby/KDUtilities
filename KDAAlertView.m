//
//  KDAAlertView.m
//  Surge Dashboard
//
//  Created by Blankwonder on 7/30/16.
//  Copyright © 2016 Yach. All rights reserved.
//
#if TARGET_OS_MAC

#import "KDAAlertView.h"

@implementation KDAAlertView {
    NSTextField *_titleLabel;
    NSView *_accessoryView;
    
    NSButton *_okButton, *_cancelButton;
}

static const CGFloat kButtonWidth = 90;
static const CGFloat kButtonHeight = 32;

- (instancetype)initWithTitle:(NSString *)title accessoryView:(NSView *)accessoryView {
    self = [super initWithContentRect:NSMakeRect(0, 0, accessoryView.frame.size.width + 40, 20 + 20 + 5 + accessoryView.frame.size.height + 20 + 20 + 20) styleMask:NSTitledWindowMask backing:NSBackingStoreBuffered defer:YES];
    if (self) {
        _accessoryView = accessoryView;
        self.hasShadow = YES;
        
        [self.contentView addSubview:accessoryView];
        
        _titleLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
        _titleLabel.drawsBackground = NO;
        _titleLabel.bordered = NO;
        _titleLabel.selectable = NO;
        _titleLabel.editable = NO;
        _titleLabel.stringValue = title;
        _titleLabel.font = [NSFont boldSystemFontOfSize:[NSFont systemFontSize]];

        [self.contentView addSubview:_titleLabel];
        
        _okButton = [[NSButton alloc] initWithFrame:NSZeroRect];
        _okButton.bezelStyle = NSRoundedBezelStyle;
        _okButton.keyEquivalent = @"\r";
        _okButton.keyEquivalentModifierMask = 0;
        _cancelButton = [[NSButton alloc] initWithFrame:NSZeroRect];
        _cancelButton.bezelStyle = NSRoundedBezelStyle;
        _cancelButton.keyEquivalent = @"\e";
        _cancelButton.keyEquivalentModifierMask = 0;

        _okButton.title = @"OK";
        _cancelButton.title = @"Cancel";
        
        [_okButton setTarget:self];
        [_okButton setAction:@selector(okButtonPressed)];
        [_cancelButton setTarget:self];
        [_cancelButton setAction:@selector(cancelButtonPressed)];

        [self.contentView addSubview:_okButton];
        [self.contentView addSubview:_cancelButton];
        
        [self layout];
        [self displayIfNeeded];
    }
    return self;
}

- (void)layout {
    [_accessoryView setFrameOrigin:CGPointMake(20, 60)];
    [_titleLabel setFrame:NSMakeRect(20, _accessoryView.frame.size.height + _accessoryView.frame.origin.y + 5, _accessoryView.frame.size.width, 20)];
    [_okButton setFrame:NSMakeRect(self.frame.size.width - kButtonWidth - 10, 14, kButtonWidth, kButtonHeight)];
    [_cancelButton setFrame:NSMakeRect(_okButton.frame.origin.x - 5 - kButtonWidth, 14, kButtonWidth, kButtonHeight)];
}

- (void)setFrame:(NSRect)frameRect display:(BOOL)displayFlag animate:(BOOL)animateFlag {
    [super setFrame:frameRect display:displayFlag animate:animateFlag];
    
    [self layout];
}

- (void)okButtonPressed {
    if (self.validateBlock) {
        if (!self.validateBlock()) return;
    }
    
    [self.sheetParent endSheet:self returnCode:NSModalResponseOK];
    
    self.validateBlock = nil;
    [_accessoryView removeFromSuperview];
}

- (void)cancelButtonPressed {
    [self.sheetParent endSheet:self returnCode:NSModalResponseCancel];
    
    self.validateBlock = nil;
    [_accessoryView removeFromSuperview];
}

+ (void)requestInputTextInWindow:(NSWindow *)window
                           title:(NSString *)title
                     placeholder:(NSString *)placeholer
                        initText:(NSString *)initText
               completionHandler:(void (^)(NSString *text))completionHandler {
    NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 300, 24)];
    textField.placeholderString = placeholer;
    if (initText) {
        textField.stringValue = initText;
    }
    
    KDAAlertView *av = [[KDAAlertView alloc] initWithTitle:title accessoryView:textField];
    
    [window beginSheet:av completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSModalResponseOK) {
            completionHandler(textField.stringValue ?: @"");
        } else {
            completionHandler(nil);
        }
    }];
    
}

@end
#endif
