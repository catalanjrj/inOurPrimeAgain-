//
//  ViewController.m
//  inOurPrime
//
//  Created by Jorge Catalan on 7/27/16.
//  Copyright © 2016 Jorge Catalan. All rights reserved.
//

#import "ViewController.h"
#import "PrimeBrain.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *instructionsLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UIButton *doMathButton;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *primeNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *factorsButton;
@property (weak, nonatomic) IBOutlet UIButton *GreatestCommonFactorButton;

@property(strong,nonatomic)PrimeBrain *brain;

-(NSString *)formatString:(NSArray *)numbersArray;
-(void)checkForPrimeNumber:(NSString *)numbersString;
-(void)checkFactors:(NSString *)numbersString;
-(void)checkGreatesCommonFactor:(NSString *)numbersString;
-(void)displayError:(NSString *)title message:(NSString *)message;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initialize PrimeBrain
    self.brain = [[PrimeBrain alloc]init];
}
//create action that does math for selection
- (IBAction)doTheMath:(id)sender {
    if ([sender isEqual:self.primeNumberButton]) {
        [self checkForPrimeNumber:self.numberTextField.text];
        
    }else if ([sender isEqual:self.factorsButton]){
        [self checkFactors:self.numberTextField.text];
    
    }else if ([self.numberTextField.text componentsSeparatedByString:@" "].count >=2){
        [self checkGreatesCommonFactor:self.numberTextField.text];
        
    }else{
        [self displayError:@"Error!!" message:@"Enter two numbers seperated by a space"];
    
    }
    [self.numberTextField resignFirstResponder];
}

#pragma mark - calculations 

//check if number is prime
-(void)checkForPrimeNumber:(NSString *)numbersString{
    if([self.brain isPrimeNumber:[numbersString integerValue]]){
        self.answerLabel.text = [NSString stringWithFormat:@"%@ is a prime number",numbersString];
    }else{
        self.answerLabel.text = [NSString stringWithFormat:@"%@ is not a prime number",numbersString];
    
    }
}

// retrieve factors for number provided
-(void)checkFactors:(NSString *)numbersString{
    NSArray *factorsArray = [[NSArray alloc]init];
    factorsArray = [self.brain RetreiveFactorsForNumber:[numbersString integerValue]];
    if(factorsArray){
        self.answerLabel.text = [self formatString:factorsArray];
    }else{
        self.answerLabel.text = [NSString stringWithFormat:@"There are no factors for %@",numbersString];
    }
}
// calculate the greatest common factor between two number
-(void)checkGreatesCommonFactor:(NSString *)numbersString{
    NSArray *numbers = [[NSArray alloc]initWithArray:[numbersString componentsSeparatedByString:@" "]];
    NSUInteger firstNumber = [numbers[0] integerValue];
    NSUInteger seconNumber =[numbers[1]integerValue];
    NSInteger greatestCommonFactor = [self.brain getGreatestCommonFactor:firstNumber numberTwo:seconNumber];
    
    if(greatestCommonFactor > 0){
        self.answerLabel.text = [NSString stringWithFormat:@"The greatest common factor between %lu and %lu is %ld",(unsigned long)firstNumber,
        (unsigned long)seconNumber, (long)greatestCommonFactor];
    }else{
        self.answerLabel.text = [NSString stringWithFormat:@"There are no common factors"];
    
    }
}


@end
