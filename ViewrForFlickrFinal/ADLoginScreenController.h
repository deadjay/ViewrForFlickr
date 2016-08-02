//
//  LoginScreenController.h
//  ViewrForFlickr
//
//  Created by Артем Алексеев on 7/2/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADLoginScreenController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *loadingImage;

- (IBAction)yahooLoginAction:(UIButton *)sender;
- (IBAction)startWithoutLoginAction:(UIButton *)sender;

- (IBAction)prepareForUnwind:(UIStoryboardSegue *)segue;



@end
