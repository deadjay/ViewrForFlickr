//
//  NSLayoutConstraint_MyExt.h
//  ViewrForFlickr
//
//  Created by SuperDev on 7/30/16.
//  Copyright © 2016 Artyom Alexeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Description)

@end

@implementation NSLayoutConstraint (Description)

-(NSString *)description {
    return [NSString stringWithFormat:@"id: %@, constant: %f", self.identifier, self.constant];
}

@end
