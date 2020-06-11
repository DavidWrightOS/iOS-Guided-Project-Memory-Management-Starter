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
    
    // MARK: - Guided Project: Part 2
    
    NSString *name = [[NSString alloc] initWithString:@"David"]; // (alloc/init = +1) retain: 1
    
    // Two methods for Manual Reference Counting (MRC)
    // Only exist with ARC disabled
    // retain
    // release
    
    [name retain]; // (retain = +1) retain: 2
    [name retain]; // (retain = +1) retain: 3
    
    [name release]; // (retain = -1) retain: 2
    [name release]; // (retain = -1) retain: 1
    
    [name release]; // (retain = -1) retain: 0 -> automatically cleaned up
    name = nil; // position zero in memory
    // No longer safe to use name as a variable with what it's pointing at
    
    // Dangling pointer if we release to 0, and try to use (always set to nil when finished)
    // Bug to use it here: May crash, unexpected behaviors - undefined behaviors
    NSLog(@"Name: %@", name.description);
    
    
    // All Collection types will take ownership of the memory you pass them (objects)
    
    NSMutableArray *colors = [[NSMutableArray alloc] init]; // colors: 1
    
    NSLog(@"Colors: %@", colors);
    
    NSString *favoriteColor = [[NSString alloc] initWithString:@"Blue"]; // favoriteColor: 1
    [colors addObject:favoriteColor]; // favoriteColor: 2 (addObject +1)
    [favoriteColor release]; // favoriteColor: 1 -> transfering object ownership to the array
    
    NSString *color2 = [[[NSString alloc] initWithString:@"Red"] autorelease];
    [colors addObject:color2];
    
    
    [colors release]; // colors: 0 -> automatic cleanup of memory (other variables can now use this space)
    // favoriteColor: 0
    colors = nil; // Prevent bugs with using invalid memory (Protecting my future self from making a mistake)
    
    // using colors after setting it to nil is a no-op and will be predictable ... without it ... anything can happen
    
    Car *honda = [[[Car alloc] initWithMake:@"Civic"] autorelease]; // honda: ~0
    
    Person *person = [[Person alloc] initWithCar:honda]; // person: 1, honda: 1
    
    // person.car will retain
    // alloc/init will retain
    person.car = [[[Car alloc] initWithMake:@"Forester"] autorelease]; // unnamedCar: ~0 + 1
    
    // cleanup person now, or I need to hold onto it
    // self.person = person; // -> need to release in the dealloc
    
    [person release]; // person: 0
    person = nil; // prevents future issues (protects my future self)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Guided Project
    
    /*
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

    
    
//    __block ViewController *weakSelf = self;
    __block __weak ViewController *weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES
                  block:^(NSTimer * _Nonnull timer) { // [weak self] in
        [weakSelf doSomething];
        NSLog(@"Person is: %@", me);
    }];
    
    
    
    NSDictionary *myDict = @{@"Key": @"Value"};
    
    CFDictionaryRef dictionaryRef = CFBridgingRetain(myDict);
    
    myDict = CFBridgingRelease(dictionaryRef);
    CFRelease(dictionaryRef);
    
    
    
    [me release];
    */
}

- (void)doSomething
{
    NSLog(@"Did something!");
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
