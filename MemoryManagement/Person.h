//
//  Person.h
//  iOS9-MemoryManagement
//
//  Created by Paul Solt on 11/13/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Car;

@interface Person : NSObject

// Establish ownership for the car with retain
@property (nonatomic, retain) Car *car; // MRC: assign (the default in MRC - aka weak), or retain (aka strong, the default in ARC)

- (instancetype)initWithCar:(Car *)car;

@end
