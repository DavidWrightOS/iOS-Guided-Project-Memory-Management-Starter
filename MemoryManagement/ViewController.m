//
//  ViewController.m
//  MemoryManagement
//
//  Created by Paul Solt on 1/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "LSILog.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // array's retain count = 1
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (NSInteger index = 0; index < 10; index += 1) {
        // string's retain count = 1
        NSMutableString *string = [[NSMutableString alloc] initWithString:@"Starting Value"];
        
        // string's retain count += 1; (2)
        [array addObject:string];
        
        // string's retain count -= 1; (1)
        [string release];
    }
    
    NSMutableString *firstString = [array objectAtIndex:0];
    // string's retain count += 1; (2)
    [firstString retain];
    NSLog(@"The string is: %@", firstString);
    
    // string's retain count -= 1; (1)
    // array's retain count -= 1; (0)
    [array release];
    
    NSLog(@"The string is still: %@", firstString);
    // string's retain count -= 1; (0)
    [firstString release];
    
    NSLog(@"Hi");
    
    
    
    Person *me = [[Person alloc] init];
    
    NSMutableString *make = [[NSMutableString alloc] initWithString:@"Civic Si"];
    Car *honda = [[Car alloc] initWithMake:make];
    [make release];
    
    Car *toyota = [Car car]; // uses a convenience initializer so it is autoreleased (no need to release memory when done using honda2)
    NSLog(@"%@", toyota);
    
    me.car = honda;
    [honda release];
    
    me.car = me.car;
//    NSLog(@"The make for my car is: %@", me.car.make);
//
//    [make replaceOccurrencesOfString:@"Si" withString:@"Sport" options:0 range:NSMakeRange(0, make.length)];
    
    NSLog(@"The make for my car is: %@", me.car.make);

    [me release];
}


@end

/*
 
 // Is the object autoreleased? Why?
 
 NSString *name = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
 Autoreleased
 
 NSDate *today = [NSDate date];
 Autoreleased
 
 NSDate *now = [NSDate new];
 Not Autoreleased
 
 NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
 Autoreleased
 
 NSDate *nextTomorrow = [tomorrow2 copy]; // retain: 1
 Not Autoreleased
 
 NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
 Autoreleased
 
 NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
 Not Autoreleased
 
 Car *redCar = [Car car];
 Autoreleased
 
 NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
 Autoreleased
 
 NSString *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
 Not Autoreleased
 [idea3 autorelease];
 Autoreleased
 
 */
