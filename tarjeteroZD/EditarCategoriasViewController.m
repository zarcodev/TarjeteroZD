//
//  EditarCategoriasViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 25/05/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "EditarCategoriasViewController.h"


@interface EditarCategoriasViewController ()

@end

@implementation EditarCategoriasViewController
@synthesize catego;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.categoriaTextField.delegate = self;
    
    if (self.catego) {
        [self.categoriaTextField setText:[self.catego valueForKey:@"nombre"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelarButtonPress:(UIButton *)sender {
    NSLog(@"cancela");
    [self.navigationController popViewControllerAnimated:YES ];
}

- (IBAction)guardarButtonPress:(UIButton *)sender {
    NSLog(@"guarda");
    
    //NSManagedObjectContext *contexto = [CoreDataAyuda managedObjectContext];
    
    if (self.catego) {
        [self.catego setValue:self.categoriaTextField.text forKey:@"nombre"];
    }
    
    [self.catego.managedObjectContext save:nil];
    
    /*NSError *error = nil;
    if (![contexto save:&error]) {
        NSLog(@"No se puede actualizar %@",error);
    }*/
    
    
    [self.navigationController popViewControllerAnimated:YES ];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
