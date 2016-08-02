//
//  ADAuthViewController.m
//  ViewrForFlickr
//
//  Created by Артем Алексеев on 7/24/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import "ADAuthViewController.h"
#import "FlickrKit.h"
#import "ADServerManager.h"

@interface ADAuthViewController () <UIWebViewDelegate>

@property (nonatomic, retain) FKDUNetworkOperation *authOp;

@property (nonatomic, retain) FKDUNetworkOperation* completeAuthOp;

@property (nonatomic, retain) FKDUNetworkOperation *checkAuthOp;

@property (nonatomic, retain) NSString *userID;

@end

@implementation ADAuthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.authWebView.scrollView.bounces = NO;
    
    self.authWebView.scrollView.scrollEnabled = NO;
    
    self.authWebView.delegate = self;
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startAuthentication];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.authOp cancel];
    
}

#pragma mark - Methods

- (void) startAuthentication {
    
    NSString *callbackURLString = @"viewrforflickr://";
    
    // Begin the authentication process
    NSLog(@"Begin");
    self.authOp = [[FlickrKit sharedFlickrKit]
                   beginAuthWithCallbackURL:[NSURL URLWithString:callbackURLString]
                   permission:FKPermissionDelete
                   completion:^(NSURL *flickrLoginPageURL, NSError *error) {
                       
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if (!error) {
                 
                 NSMutableURLRequest *urlRequest = [NSMutableURLRequest
                                                    requestWithURL:flickrLoginPageURL
                                                    cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                    
                                                    timeoutInterval:30];
                 
                 [self.authWebView loadRequest:urlRequest];
                 
             } else { NSLog(@"Error");
                 
                 UIAlertController* alert = [UIAlertController
                                             alertControllerWithTitle:@"Error"
                                             message:error.localizedDescription
                                             preferredStyle:UIAlertControllerStyleAlert];
                 
                 [self presentViewController:alert animated:YES completion:nil];
                 
             }
         });
     }];
    
}



- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = [request URL];
    
    NSLog(@"URL = %@", url);
    
    
    //If logout link pressed - open it in app
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        
        if ([[url absoluteString] localizedStandardContainsString:@"https://m.flickr.com/logout"] ||
            [[url absoluteString] localizedStandardContainsString:@"https://m.flickr.com/?iosauthlogout"]) {
            
            return YES;
            
        } else {
            //If other link pressed - open in Safari
            [[UIApplication sharedApplication] openURL:[request URL]]; //Open external links in Safari.
            return NO;
        }
        
    }
    
    
    //If "No, Thanks" Button pressed - dismissing viewcontroller
    if ([[url absoluteString] isEqual:@"https://m.flickr.com/#/home"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

    
    // If it's the callback url, then lets trigger that
    if (![url.scheme isEqual:@"http"] && ![url.scheme isEqual:@"https"]) {
        
        self.completeAuthOp = [[FlickrKit sharedFlickrKit]
                               completeAuthWithURL:url
                               completion:^(NSString *userName, NSString *userId, NSString *fullName, NSError *error) {
                                   
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error) {
                                    
                    [[ADServerManager sharedManager]
                     saveUserName:userName
                     userID:userId
                     fullName:fullName];

                } else {
                    /////////
                }
                                
                [self performSegueWithIdentifier:@"showMainControllerSegue" sender:nil];
                
            });
        }];
            return NO;
    }
    
    
    
    return YES;
    
}



- (void) webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString* currentURL = [self.authWebView stringByEvaluatingJavaScriptFromString:@"window.location.href"];
    
    if ([currentURL localizedStandardContainsString:@"https://m.flickr.com/?iosauthlogout"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    self.loadingIndicator.hidesWhenStopped = YES;
    [self.loadingIndicator stopAnimating];
    
    self.authWebView.scrollView.scrollEnabled = YES;
    
}

#pragma mark - Actions

- (IBAction) dismissViewControllerAction:(UIButton *) sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction) goForwardAction:(UIButton *) sender {
    
    if (self.authWebView.canGoBack == YES) {
        
        [self.authWebView goBack]; NSLog(@"going back");
        
    }
    
}

@end
