//
//  Person.m
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "Person.h"
#import "Car.h"
#import "LSILog.h"

@implementation Person

- (instancetype)initWithCar:(Car *)car
{
    self = [super init];
    if (self) {
        NSLog(@"-[Person init]: %@", _car);
        _car = [car retain];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"-[Person dealloc]: %@", _car);
    [_car release];
    
    [super dealloc];
}

- (void)setCar:(Car *)car
{
    // No good!
    //    [_car release];
    //    _car = [car retain];
    
    // Great!
    [car retain];
    [_car release];
    _car = car;
    
    // Another great alternative!
//    if (_car != car) {
//        [_car release];
//        _car = [car retain];
//    }
}

@end
