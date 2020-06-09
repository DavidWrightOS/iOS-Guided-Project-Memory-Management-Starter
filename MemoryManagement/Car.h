//
//  Car.h
//  MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *make; // copy gives ownership, just like retain does

- (instancetype)initWithMake:(NSString *)make;

+ (instancetype)car;
+ (instancetype)carWithMake:(NSString *)make;


@end
