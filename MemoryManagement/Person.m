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
        _car = [car retain]; // need to retain car because in the header file we declared the property as retain
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"-[Person dealloc]: %@", _car);
    [_car release]; // release the car property
    
    [super dealloc];
}

- (void)setCar:(Car *)car
{
    // MARK: No good!
//    [_car release]; // release old car
//    _car = [car retain]; // retain new car (does not work if oldCar = newCar, we already released oldCar to 0)
    
    // MARK: Great!
    [car retain]; // retain new car
    [_car release]; // release old car
    _car = car;
    
    // MARK: Another great alternative!
//    if (_car != car) {
//        [_car release]; // release old car
//        _car = [car retain]; // retain new car
//    }
}

@end
