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
-(NSArray*)RetreiveFactorsForNumber:(NSUInteger)number{
    int counter = 2;
    int range = sqrt((int)number);
    NSMutableArray *Factors = nil;
    
    while(counter <= range){
        if((number % counter == 0) && [self isPrimeNumber:counter]){
            if(!Factors){
                Factors = [[NSMutableArray alloc]init];
            }
            [Factors addObject:[NSString stringWithFormat:@"%d",counter]];
        }
        counter += 1;
    
    }
    return Factors;

}

-(NSInteger)getGreatestCommonFactor:(NSUInteger)firstNumber numberTwo:(NSUInteger)secondNumber{
    NSArray *firstNumberArray = [[NSArray alloc]initWithArray:[self RetreiveFactorsForNumber:firstNumber ]];
    NSArray *secondNumberArray = [[NSArray alloc]initWithArray:[self RetreiveFactorsForNumber:secondNumber]];
    NSInteger greatesCommonFactor = 0;
    
    if(firstNumberArray && secondNumberArray){
        for(NSString *first in firstNumberArray){
            for(NSString *second in secondNumberArray){
                if(([first integerValue] == [second integerValue]) &&([first integerValue] > greatesCommonFactor)) {
                    greatesCommonFactor = [first integerValue];
                }
            }
        }
    }
    return greatesCommonFactor;
}


@end
