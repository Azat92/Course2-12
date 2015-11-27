//
//  MyClass.m
//  Lesson13
//
//  Created by Azat Almeev on 27.11.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "MyClass.h"

@implementation MyClass
+ (instancetype)randomObject {
    MyClass *myClass = [MyClass new];
    myClass.title = [NSString stringWithFormat:@"%d", arc4random_uniform(100)];
    myClass.num = @(arc4random_uniform(100));
    return myClass;
}

- (NSString *)fullTitle {
    return [NSString stringWithFormat:@"%@ (%@)", self.title, self.num];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:NSStringFromSelector(@selector(title))];
    [aCoder encodeObject:self.num forKey:NSStringFromSelector(@selector(num))];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.title = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(title))];
    self.num = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(num))];
    return self;
}
@end
