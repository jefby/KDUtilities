//
//  KDAlertView.m
//  KDBlockAlert
//
//  Created by Blankwonder on 11/20/12.
//

#import "KDAlertView.h"
#import "KDUtilities.h"

static NSMutableArray *__ActiveInstances = nil;


#if TARGET_OS_IOS

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface KDAlertView(){
    NSMutableArray *_buttonTitleArray;
    NSMutableArray *_buttonActionBlockArray;
    
    NSString *_cancelButtonTitle;

    UIAlertView *_systemAlertView;
}
@end


@implementation KDAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
                 cancelAction:(void ( ^)(KDAlertView *alertView))cancelAction {

    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        __ActiveInstances = [NSMutableArray array];
    });

    self = [self init];
    if (self) {
        _buttonTitleArray = [NSMutableArray array];
        _buttonActionBlockArray = [NSMutableArray array];

        if (cancelButtonTitle) {
            _cancelButtonTitle = [cancelButtonTitle copy];
            [_buttonActionBlockArray addObject:cancelAction ? [cancelAction copy]: [NSNull null]];
        }

        _systemAlertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    }
    return self;
}

- (void)addButtonWithTitle:(NSString * _Nonnull)title action:(void ( ^)(KDAlertView *alertView))action {
    [_buttonTitleArray addObject:title];
    [_buttonActionBlockArray addObject:action ? [action copy] : [NSNull null]];
}

- (void)show {
    [__ActiveInstances addObject:self];
    if (_cancelButtonTitle) {
        _systemAlertView.cancelButtonIndex = [_systemAlertView addButtonWithTitle:_cancelButtonTitle];
    }
    for (NSString *title in _buttonTitleArray) {
        [_systemAlertView addButtonWithTitle:title];
    }

    [_systemAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    id actionBlock = _buttonActionBlockArray[buttonIndex];
    if (actionBlock && actionBlock != [NSNull null]) {
        void (^block)(KDAlertView *) = actionBlock;
        block(self);
    }

    _buttonActionBlockArray = nil;
    alertView.delegate = nil;
    [__ActiveInstances removeObject:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (alertView.alertViewStyle != UIAlertViewStyleDefault) {
            [[alertView textFieldAtIndex:0] resignFirstResponder];
        }
    });
}

- (UIAlertView *)systemAlertView {
    return _systemAlertView;
}

+ (void)showMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle{
    KDAlertView *av = [[KDAlertView alloc] initWithTitle:message message:nil cancelButtonTitle:cancelButtonTitle cancelAction:nil];
    [av show];
}

+ (KDAlertView *)presentingAlertView {
    return __ActiveInstances.lastObject;
}

- (NSString *)title {
    return _systemAlertView.title;
}

- (NSString *)message {
    return _systemAlertView.message;
}

- (void)setTitle:(NSString *)title {
    _systemAlertView.title = title;
}

- (void)setMessage:(NSString *)message {
    _systemAlertView.message = message;
}

+ (void)showErrorMessage:(NSString *)message {
    KDAlertView *av = [[KDAlertView alloc] initWithTitle:@"Error" message:message cancelButtonTitle:@"OK" cancelAction:nil];
    [av show];
}

@end

#pragma clang diagnostic pop

#else

@implementation KDAlertView {
    NSMutableArray *_buttonTitleArray;
    NSMutableArray *_buttonActionBlockArray;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
                 cancelAction:(void ( ^)(KDAlertView *alertView))cancelAction {
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        __ActiveInstances = [NSMutableArray array];
    });

    self = [super init];
    if (self) {
        _buttonTitleArray = [NSMutableArray array];
        _buttonActionBlockArray = [NSMutableArray array];

        _title = [title copy];
        _message = [message copy];
        
        if (cancelButtonTitle) {
            [_buttonTitleArray addObject:cancelButtonTitle];
            [_buttonActionBlockArray addObject:cancelAction ? [cancelAction copy]: [NSNull null]];
        }

    }
    return self;
}

- (void)addButtonWithTitle:(NSString *)title action:(void ( ^)(KDAlertView *alertView))action {
    [_buttonTitleArray addObject:title];
    [_buttonActionBlockArray addObject:action ? [action copy] : [NSNull null]];
}

- (void)show {
    [__ActiveInstances addObject:self];
    
    NSAlert *alert = [[NSAlert alloc] init];
    if (_title) {
        [alert setMessageText:_title];
    }
    if (_message) {
        [alert setInformativeText:_message];
    }
    
    for (NSString *button in _buttonTitleArray) {
        [alert addButtonWithTitle:button];
    }
    
    alert.alertStyle = self.alertStyle;
    
    NSWindow *window = [NSApplication sharedApplication].keyWindow ?: [NSApplication sharedApplication].mainWindow;
    
    if (window) {
        [alert beginSheetModalForWindow:window completionHandler:^(NSModalResponse response) {
            long idx = response - NSAlertFirstButtonReturn;
            if (idx >= 0) {
                id actionBlock = _buttonActionBlockArray[idx];
                if (actionBlock != [NSNull null]) {
                    void (^block)(KDAlertView *) = actionBlock;
                    block(self);
                }
            }
            
            [__ActiveInstances removeObject:self];
        }];
    } else {
        NSModalResponse response = [alert runModal];
        long idx = response - NSAlertFirstButtonReturn;
        if (idx >= 0) {
            id actionBlock = _buttonActionBlockArray[idx];
            if (actionBlock != [NSNull null]) {
                void (^block)(KDAlertView *) = actionBlock;
                block(self);
            }
        }
        
        [__ActiveInstances removeObject:self];

    }
}

+ (void)showMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle {
    KDAlertView *av = [[KDAlertView alloc] initWithTitle:message message:nil cancelButtonTitle:cancelButtonTitle cancelAction:nil];
    [av show];
}

+ (void)showErrorMessage:(NSString *)message {
    KDAlertView *av = [[KDAlertView alloc] initWithTitle:@"Error" message:message cancelButtonTitle:@"OK" cancelAction:nil];
    av.alertStyle = NSCriticalAlertStyle;
    [av show];
}

+ (KDAlertView *)presentingAlertView {
    return __ActiveInstances.lastObject;
}


@end

#endif
