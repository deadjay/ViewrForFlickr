//
//  LoginScreenController.m
//  ViewrForFlickr
//
//  Created by Артем Алексеев on 7/2/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import "ADLoginScreenController.h"
#import "FLAnimatedImage.h"
#import "FlickrKit.h"
#import "ADServerManager.h"

@interface ADLoginScreenController ()

@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;

@end

@implementation ADLoginScreenController


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self showAnimatedBackgroundImage];
        
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self setNeedsStatusBarAppearanceUpdate];//Turn Status bar to light
    
    [self checkIfUserAlreadyAutorized];
    
}

/*
- (UIStatusBarStyle) preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}
*/

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.loadingImage.hidden = YES;

}

#pragma mark - Methods

- (void) showAnimatedBackgroundImage {
    
    FLAnimatedImage *image = [[FLAnimatedImage alloc]
                              initWithAnimatedGIFData:[NSData
                                                       dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"loginGif" ofType:@"gif"]]];
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    
    imageView.animatedImage = image;
    
    [self.view addSubview:imageView];
    
    [self.view sendSubviewToBack:imageView];
    
    [self initConstraintsForImageView:imageView];
    
}

- (void) initConstraintsForImageView:(UIImageView*) imageView {
    
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    id views = @{
                 @"imageView": imageView
                 };
    
    // picture constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:views]];
    
    
    // play button constraints
    /*
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];*/
    
}

- (void) checkIfUserAlreadyAutorized {
    
    self.checkAuthOp = [[FlickrKit sharedFlickrKit]
                        checkAuthorizationOnCompletion:^(NSString *userName,
                                                         NSString *userId,
                                                         NSString *fullName,
                                                         NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                
                NSLog(@"User is already logged in");
                
                [self performSegueWithIdentifier:@"showMainScreenSegue" sender:nil];
                
                //self.loadingImage.hidden = YES;
                
                ////////

                ////////
                
            } else {
                
                [self.loadingImage setHidden:YES];
                
                NSLog(@"User is not logged in");
                
            }
        });		
    }];
    
}

#pragma mark - Actions

- (IBAction) yahooLoginAction:(UIButton *) sender {
    
    [self performSegueWithIdentifier:@"loginWithYahooSegue" sender:nil];

}

- (IBAction) startWithoutLoginAction:(UIButton *) sender {
    
    [self performSegueWithIdentifier:@"startWithoutLoginSegue" sender:nil];
    
}

- (IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    
    
    
}
@end
