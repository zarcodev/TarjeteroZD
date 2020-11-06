//
//  EditTarjetaTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 08/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tarjetas.h"
#import "Categorias.h"
//#import "CoreDataAyuda.h"
//#import "CoreDataTableViewController.h" // so we can fetch


@interface EditTarjetaTableViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

//@property (strong) NSManagedObject *tarje;
@property (strong, nonatomic) Tarjetas *tarje;
@property (strong, nonatomic) Categorias *categoriaSeleccionada;
@property (strong, nonatomic) NSMutableArray *categorias;
//@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property (strong, nonatomic) IBOutlet UITextField *nombreTextField;
@property (strong, nonatomic) IBOutlet UITextField *apellidosTextField;
@property (strong, nonatomic) IBOutlet UITextField *empresaTextField;
@property (strong, nonatomic) IBOutlet UITextField *telefonoTextField;
@property (strong, nonatomic) IBOutlet UITextField *celularTextField;
@property (strong, nonatomic) IBOutlet UITextField *webTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
//solo se usa para habilitar el tap y scroll numerico
@property (strong, nonatomic) IBOutlet UITextField *auxiliarTextField;

@property (strong, nonatomic) IBOutlet UIPickerView *categoriasPickerView;
@property (strong, nonatomic) IBOutlet UIImageView *fotoImageView;

- (IBAction)guardarPressButtonBar:(UIBarButtonItem *)sender;

@end
