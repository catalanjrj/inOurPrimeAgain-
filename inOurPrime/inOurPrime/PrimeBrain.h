//
//  PrimeBrain.h
//  inOurPrime
//
//  Created by Jorge Catalan on 7/27/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrimeBrain : NSObject
-(BOOL)isPrimeNumber:(NSUInteger)number;
-(NSArray*)RetreiveFactorsForNumber:(NSUInteger)number;
-(NSInteger)getGreatestCommonFactor:(NSUInteger)firstNumber numberTwo:(NSUInteger)secondNumber;

@end
