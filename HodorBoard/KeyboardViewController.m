//
//  KeyboardViewController.m
//  HodorBoard
//
//  Created by Matthew Andersen on 9/18/14.
//  Copyright (c) 2014 Matthew Andersen. All rights reserved.
//

#import "KeyboardViewController.h"
#import "UIColor+MASystemColors.h"

@interface KeyboardViewController ()
@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) UIButton *hodorButton;
@property (nonatomic, strong) UIButton *shiftButton;

@property (nonatomic) BOOL isShiftPressed;

- (void)insertHodor;
- (void)toggleShift;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isShiftPressed = NO;
    
    [self defineNextKeyboardButton];
    [self defineHodorButton];
    [self defineShiftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

- (void)insertHodor
{
    if ( self.isShiftPressed ) {
        [self.textDocumentProxy insertText:@"HODOR "];
    } else {
        [self.textDocumentProxy insertText:@"hodor "];
    }
}

- (void)toggleShift
{
    self.isShiftPressed = !self.isShiftPressed;
    self.shiftButton.selected = self.isShiftPressed;
    
    UIColor *backgroundColor = (self.isShiftPressed) ? [UIColor whiteColor] : [UIColor keyboardFunctionButtonBackgroundColor];
    [self.shiftButton setBackgroundColor:backgroundColor];
    
    [self.hodorButton setTitle:(self.isShiftPressed) ? @"HODOR" : @"hodor" forState:UIControlStateNormal];
    [self.hodorButton sizeToFit];
}

- (void)defineNextKeyboardButton
{
    // Perform custom UI setup here
    self.nextKeyboardButton = [self makeButtonWithText:nil];
    
    [self.nextKeyboardButton setImage:[UIImage imageNamed:@"Globe"] forState:UIControlStateNormal];
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextKeyboardButton.backgroundColor = [UIColor keyboardFunctionButtonBackgroundColor];
    [self.nextKeyboardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextKeyboardButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [self.view addSubview:self.nextKeyboardButton];
    
    NSLayoutConstraint *nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5.0];
    NSLayoutConstraint *nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-5.0];
    [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
}

- (void)defineHodorButton
{
    // Perform custom UI setup here
    self.hodorButton = [self makeButtonWithText:NSLocalizedString(@"hodor", @"Hodor Hodor Hodor")];
    
    [self.hodorButton addTarget:self action:@selector(insertHodor) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.hodorButton];
    
    NSLayoutConstraint *hodorButtonCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.hodorButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *hodorButtonCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.hodorButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[hodorButtonCenterXConstraint, hodorButtonCenterYConstraint]];
}
- (void)defineShiftButton
{
    // Perform custom UI setup here
    self.shiftButton = [self makeButtonWithText:@"⬆︎"];
    
    self.shiftButton.contentEdgeInsets = UIEdgeInsetsMake(8.0, 5.0, 0, 5.0);
    
    self.shiftButton.backgroundColor = [UIColor keyboardFunctionButtonBackgroundColor];
    [self.shiftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.shiftButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    self.shiftButton.titleLabel.font = [UIFont fontWithName:@"Symbol" size:24];
    
    [self.shiftButton addTarget:self action:@selector(toggleShift) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.shiftButton];

    NSLayoutConstraint *buttonCenterXConstraint = [NSLayoutConstraint constraintWithItem:self.shiftButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:5.0];
    NSLayoutConstraint *buttonCenterYConstraint = [NSLayoutConstraint constraintWithItem:self.shiftButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    [self.view addConstraints:@[buttonCenterXConstraint, buttonCenterYConstraint]];
}

- (UIButton *)makeButtonWithText:(NSString *)titleText
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:titleText forState:UIControlStateNormal];
    

    button.contentEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0, 5.0);

    
    [button sizeToFit];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    button.titleLabel.font = [UIFont fontWithName:@"IowanOldStyle-Roman" size:36];
    
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor defaultButtonTextColor] forState:UIControlStateHighlighted];
    
    button.layer.cornerRadius = 10.0f;
    
    return button;
}
@end
