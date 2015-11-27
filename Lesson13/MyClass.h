//
//  MyClass.h
//  Lesson13
//
//  Created by Azat Almeev on 27.11.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject <NSCoding>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *num;
@property (nonatomic, readonly) NSString *fullTitle;

+ (instancetype)randomObject;
@end
