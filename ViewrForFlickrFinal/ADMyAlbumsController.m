//
//  ADMyAlbumsController.m
//  ViewrForFlickr
//
//  Created by SuperDev on 7/28/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import "ADMyAlbumsController.h"
#import "ADServerManager.h"
#import "FlickrKit.h"

@interface ADMyAlbumsController ()

@property (nonatomic, retain) FKFlickrNetworkOperation *myPhotostreamOp;
@property (strong, nonatomic) NSArray* photoURLs;

@end

@implementation ADMyAlbumsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runMyPhotostream];
    NSLog(@"viewDidLoad!!");
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.myPhotostreamOp cancel];
    
}

-(void)dealloc {
    
    [self.myPhotostreamOp cancel];
            
}

#pragma mark - Methods

- (void) runMyPhotostream {
    
    if ([FlickrKit sharedFlickrKit].isAuthorized) {
    
    self.myPhotostreamOp = [[FlickrKit sharedFlickrKit]
                            call:@"flickr.photos.search"
                            args:@{@"user_id": [[ADServerManager sharedManager] getUserID], @"per_page": @"15"}
                            maxCacheAge:FKDUMaxAgeOneHour
                            completion:^(NSDictionary *response, NSError *error) {
                                
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (response) {
                
                // extract images from the response dictionary
                
                NSLog(@"Loading Photos!!");
                
                NSMutableArray* photoURLs = [NSMutableArray array];
                
                for (NSDictionary* photoDictionary in [response valueForKeyPath:@"photos.photo"]) {
                    
                    NSURL* url = [[FlickrKit sharedFlickrKit]
                                  photoURLForSize:FKPhotoSizeSmall240
                                  fromPhotoDictionary:photoDictionary];
                    [photoURLs addObject:url];
                }
                
                self.photoURLs = photoURLs;
                
                [self requestForImage];
                
            } else {
                
                UIAlertController* alert = [UIAlertController
                                            alertControllerWithTitle:@"Error"
                                            message:error.localizedDescription
                                            preferredStyle:UIAlertControllerStyleAlert];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        });
    }];
        
    } else {
        
        UIAlertController* alert = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Pleaselogin first"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void) requestForImage {
    
    NSLog(@"urls = %@", self.photoURLs);
    
    for (NSURL* url in self.photoURLs) {
        NSLog(@"URL = %@", [url absoluteString]);
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        
        [NSURLConnection sendAsynchronousRequest:request
                        queue:[NSOperationQueue mainQueue]
                        completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
                            UIImage* image = [[UIImage alloc] initWithData:data];
                            
                            NSLog(@"Requesting for photos!!");
                            
                            [self addImageToView:image];
                            
        }];
    }
}

- (void) addImageToView:(UIImage*) image {
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CGFloat width = CGRectGetWidth(self.imageScrollView.frame);
    CGFloat imageRatio = image.size.width / image.size.height;
    CGFloat height = width / imageRatio;
    CGFloat x = 0;
    CGFloat y = self.imageScrollView.contentSize.height;
    
    imageView.frame = CGRectMake(x, y, width, height);
    
    CGFloat newHeight = self.imageScrollView.contentSize.height + height;
    self.imageScrollView.contentSize = CGSizeMake(320, newHeight);
    
    NSLog(@"Adding images toScroll View!!");
    
    [self.imageScrollView addSubview:imageView];
    
}

@end
