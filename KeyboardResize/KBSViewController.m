//
//  KBSViewController.m
//  KeyboardResize
//
//  Created by Bill Kocik on 4/16/13.
//  Copyright (c) 2013 Bill Kocik. All rights reserved.
//

#import "KBSViewController.h"

@interface KBSViewController ()

@end

@implementation KBSViewController

@synthesize textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];

    CGRect keyboardFrame = [[self textField].superview convertRect:[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue] fromView:nil];
    CGRect statusBarFrame = [[self textField].superview convertRect:[UIApplication sharedApplication].statusBarFrame fromView:nil];
    
    CGRect bounds = [self textField].superview.bounds;    
    CGRect newFrame = CGRectMake(0.0, 0.0, bounds.size.width, keyboardFrame.origin.y + statusBarFrame.size.height);
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        [self textField].superview.frame = newFrame;
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
