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
