//
//  ADServerManager.h
//  ViewrForFlickr
//
//  Created by Артем Алексеев on 7/24/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADServerManager : NSObject

@property (strong, nonatomic) NSString* oauthToken;
@property (strong, nonatomic) NSString* oauthVerifier;

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* userID;
@property (strong, nonatomic) NSString* fullName;

+ (ADServerManager*) sharedManager;

- (void) saveUserName:(NSString*) userName userID:(NSString*) userID fullName:(NSString*) fullName;

- (NSString*) getUserName;
- (NSString*) getUserID;
- (NSString*) getFullName;

@end
