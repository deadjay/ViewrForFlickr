//
//  ADServerManager.m
//  ViewrForFlickr
//
//  Created by Артем Алексеев on 7/24/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import "ADServerManager.h"

@implementation ADServerManager

+ (ADServerManager*) sharedManager {
    
    static ADServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ADServerManager alloc] init];
    });
    
    return manager;
}

- (void) saveUserName:(NSString*) userName userID:(NSString*) userID fullName:(NSString*) fullName {
    
    NSUserDefaults* userInfo = [NSUserDefaults standardUserDefaults];
    
    [userInfo setObject:userName forKey:@"userNameKey"];
    [userInfo setObject:userID forKey:@"userIDKey"];
    [userInfo setObject:fullName forKey:@"fullNameKey"];
    
}

- (NSString*) getUserName {
    
    NSUserDefaults* userInfo = [NSUserDefaults standardUserDefaults];
    NSString* string = [userInfo stringForKey:@"userNameKey"];
    return string;
}

- (NSString*) getUserID {
    
    NSUserDefaults* userInfo = [NSUserDefaults standardUserDefaults];
    NSString* string = [userInfo stringForKey:@"userIDKey"];
    return string;
}

- (NSString*) getFullName {
    
    NSUserDefaults* userInfo = [NSUserDefaults standardUserDefaults];
    NSString* string = [userInfo stringForKey:@"fullNameKey"];
    return string;
}

@end
