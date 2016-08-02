//
//  ADMainScreenController.m
//  ViewrForFlickr
//
//  Created by SuperDev on 7/28/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import "ADMainScreenController.h"
#import "FlickrKit.h"
#import "ADMyAlbumsController.h"
#import "ADLoginScreenController.h"
#import "UIImage+UIImageCategory.h"

@interface ADMainScreenController ()

@end

@implementation ADMainScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customizeUITabBar];
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) customizeUITabBar {
    
    UITabBarItem* myAlbums = [self.tabBar.items objectAtIndex:0];
    UITabBarItem* favourites = [self.tabBar.items objectAtIndex:1];
    UITabBarItem* explore = [self.tabBar.items objectAtIndex:2];
    UITabBarItem* trending = [self.tabBar.items objectAtIndex:3];
    UITabBarItem* more = [self.tabBar.items objectAtIndex:4];
    
    self.tabBar.barTintColor = [UIColor colorWithRed:29/255.0 green:19/255.0 blue:80/255.0 alpha:1.f];
    
    // set the selected colors
    [self.tabBar setTintColor:[UIColor redColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    UIColor * unselectedColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    
    // set color of unselected text
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:unselectedColor, NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateNormal];
    
    
    myAlbums.image = [UIImage imageNamed:@"myAlbums"];
    myAlbums.selectedImage = [UIImage imageNamed:@"myAlbumsPressed"];
    myAlbums.image = [[myAlbums.image imageWithColor:unselectedColor]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myAlbums.selectedImage = [[myAlbums.selectedImage imageWithColor:[UIColor redColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    favourites.image = [UIImage imageNamed:@"favourites"];
    favourites.selectedImage = [UIImage imageNamed:@"favouritesPressed"];
    favourites.image = [[favourites.image imageWithColor:unselectedColor]
                        imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    favourites.selectedImage = [[favourites.selectedImage imageWithColor:[UIColor redColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    explore.image = [UIImage imageNamed:@"explore"];
    explore.selectedImage = [UIImage imageNamed:@"explorePressed"];
    explore.image = [[explore.image imageWithColor:unselectedColor]
                     imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    explore.selectedImage = [[explore.selectedImage imageWithColor:[UIColor redColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    trending.image = [UIImage imageNamed:@"trending"];
    trending.selectedImage = [UIImage imageNamed:@"trendingPressed"];
    trending.image = [[trending.image imageWithColor:unselectedColor]
                      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    trending.selectedImage = [[trending.selectedImage imageWithColor:[UIColor redColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    more.image = [UIImage imageNamed:@"more"];
    more.selectedImage = [UIImage imageNamed:@"morePressed"];
    more.image = [[more.image imageWithColor:unselectedColor]
                  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    more.selectedImage = [[more.selectedImage imageWithColor:[UIColor redColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
}

@end
