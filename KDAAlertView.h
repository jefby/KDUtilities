//
//  KDAAlertView.h
//  Surge Dashboard
//
//  Created by Blankwonder on 7/30/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KDAAlertView : NSWindow

+ (void)requestInputTextInWindow:(NSWindow *)window
                           title:(NSString *)title
                     placeholder:(NSString *)placeholer
                        initText:(NSString *)initText
               completionHandler:(void (^)(NSString *text))completionHandler;

- (instancetype)initWithTitle:(NSString *)title accessoryView:(NSView *)accessoryView;

@property (nonatomic) NSView *accessoryView;

@property (nonatomic, copy) BOOL (^validateBlock)();

@end
