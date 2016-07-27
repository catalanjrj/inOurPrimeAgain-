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


@end
