//
//  ADMainScreenController.h
//  ViewrForFlickr
//
//  Created by SuperDev on 7/28/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADMainScreenController : UITabBarController

@property (strong, nonatomic) UIButton *btn1;
@property (strong, nonatomic) UIButton *btn2;
@property (strong, nonatomic) UIButton *btn3;
@property (strong, nonatomic) UIButton *btn4;
@property (strong, nonatomic) UIButton *btn5;
@property (weak, nonatomic) UIButton *lastSender;

@property (strong, nonatomic) UIView *tabBarView;

@end
