//
//  Car.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Car.h"
#import "LSILog.h"

@implementation Car

- (instancetype)initWithMake:(NSString *)make
{
    self = [super init];
    if (self) {
        NSLog(@"-[Car init]: %@", make);
        _make = [make copy];
    }
    return self;
}

+ (instancetype)car
{
    return [self carWithMake:@"Toyota"];
}

+ (instancetype)carWithMake:(NSString *)make
{
    Car *car = [[self alloc] initWithMake:make];
    return [car autorelease];
}

- (void)dealloc
{
    NSLog(@"-[Car dealloc]: %@", self);
    [_make release];
    
    [super dealloc];
}

- (NSString *)description
{
    NSString *description = [[NSString alloc] initWithFormat:@"Car: %@", self.make];
    // autorelease will clean up the memory in the near future (when convenient
    return [description autorelease];
}

@end
