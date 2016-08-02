//
//  ADAuthViewController.h
//  ViewrForFlickr
//
//  Created by Артем Алексеев on 7/24/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADAuthViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *authWebView;
@property (weak, nonatomic) IBOutlet UIButton *goForwardButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissViewControllerButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (IBAction)dismissViewControllerAction:(UIButton *)sender;
- (IBAction)goForwardAction:(UIButton *)sender;

@end
