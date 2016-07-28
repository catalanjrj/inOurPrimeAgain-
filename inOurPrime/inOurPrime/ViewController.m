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
//creat Alert for error 
- (void)displayError:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okBUtton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okBUtton];
    [self presentViewController:alertController animated:YES completion:nil];
}
//create action that does math for selection
- (IBAction)doTheMath:(UIButton*)sender {
    switch (sender.tag) {
        case 0:
            [self checkForPrimeNumber:self.numberTextField.text];
            break;
        case 1:
            [self checkFactors:self.numberTextField.text];
            break;
        case 2:
             if ([self.numberTextField.text componentsSeparatedByString:@" "].count >=2){
                  [self checkGreatesCommonFactor:self.numberTextField.text];
             }else{
                 [self displayError:@"Error!!" message:@"Enter two numbers seperated by a space"];

             }
            [self.numberTextField resignFirstResponder];

            break;
        case 3:
            break;
        default:

            break;
    }
}

//    if ((sender.tag + 1)) {
//        [self checkForPrimeNumber:self.numberTextField.text];
//        
//    }else if (sender.tag + 1){
//        [self checkFactors:self.numberTextField.text];
//    
//    }else if ([self.numberTextField.text componentsSeparatedByString:@" "].count >=2){
//        [self checkGreatesCommonFactor:self.numberTextField.text];
//        
//    }else{
//        [self displayError:@"Error!!" message:@"Enter two numbers seperated by a space"];
//    
//    }
//    [self.numberTextField resignFirstResponder];
//}

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
// format array into readable sentances for answers
-(NSString *)formatString:(NSArray *)numbersArray{
NSString *answerString = @"";
    if(numbersArray.count > 1){
        answerString = [NSString stringWithFormat:@"The factors for %@ are", self.numberTextField.text];
    }else{
        answerString = [NSString stringWithFormat:@"The factor for %@ is", self.numberTextField.text];
    }
    
    for (NSString *factor in numbersArray){
        if(numbersArray.count == 1){
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@",factor]];
        }else if ((numbersArray.count == 2) && (factor == [numbersArray firstObject])){
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@",factor]];
        }else if(factor == [numbersArray lastObject]){
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"and %@",factor]];
        }else{
            answerString = [answerString stringByAppendingString:[NSString stringWithFormat:@"%@",factor]];
        
        }
        
        }
    answerString = [answerString stringByAppendingString:@"."];
    return answerString;
        }
- (IBAction)chooseCalculation:(UIButton*)sender {
    self.doMathButton.tag = (sender.tag);
    switch (sender.tag) {
        case 0:
            self.instructionsLabel.text = @"enter a number to check if is prime";
            break;
        case 1:
            self.instructionsLabel.text = @"Enter a number to see all factors for that number";
            break;
        case 2:
            self.instructionsLabel.text = @"Enter two numbers seperated by a space to see the greates common factor";
            break;
                default:
            self.instructionsLabel.text = @"";
            self.doMathButton.enabled = NO;
            break;
    }
}




@end
