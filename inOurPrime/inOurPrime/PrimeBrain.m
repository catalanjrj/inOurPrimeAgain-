//
//  PrimeBrain.m
//  inOurPrime
//
//  Created by Jorge Catalan on 7/27/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import "PrimeBrain.h"

@implementation PrimeBrain
-(BOOL)isPrimeNumber:(NSUInteger)number{
    int counter = 2;
    int range = sqrt((int)number);
    
    while(counter <= range){
        if((number % counter == 0)&& (number / counter > 1)){
            return NO;
        }
        counter += 1;
    }
    return YES;
    
}


@end
