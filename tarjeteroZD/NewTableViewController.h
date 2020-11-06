//
//  NewTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 08/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Categorias.h"
#import "Configuracion.h"
#import "Tarjetas.h"
//#import "CoreDataAyuda.h"
#import <TesseractOCR/TesseractOCR.h>
#import <AddressBook/AddressBook.h>


@interface NewTableViewController : UITableViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate, UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *nombreTextField;
@property (strong, nonatomic) IBOutlet UITextField *apellidosTextField;
@property (strong, nonatomic) IBOutlet UITextField *empresaTextField;
@property (strong, nonatomic) IBOutlet UITextField *telefonoTextField;
@property (strong, nonatomic) IBOutlet UITextField *celularTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *webTextField;
//solo se usa para validar el tap y reregsar el scroll 
@property (strong, nonatomic) IBOutlet UITextField *auxiliar;

@property (strong, nonatomic) IBOutlet UIPickerView *categoriasPickerView;

@property (strong, nonatomic) IBOutlet UIImageView *fotoImageView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *miActivityIndicatorView;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)camaraPressButtonBar:(UIBarButtonItem *)sender;
- (IBAction)cancelarPressButton:(UIButton *)sender;
- (IBAction)agregarPressButton:(UIButton *)sender;

@end
