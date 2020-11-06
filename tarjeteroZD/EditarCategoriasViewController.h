//
//  EditarCategoriasViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 25/05/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categorias.h"
//#import "CoreDataAyuda.h"

@interface EditarCategoriasViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) Categorias *catego;

@property (strong, nonatomic) IBOutlet UITextField *categoriaTextField;

- (IBAction)cancelarButtonPress:(UIButton *)sender;
- (IBAction)guardarButtonPress:(UIButton *)sender;

@end
