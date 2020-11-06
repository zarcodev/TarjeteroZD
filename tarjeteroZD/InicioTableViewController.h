//
//  InicioTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 08/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

//#import "Configuracion.h"
//#import "CoreDataAyuda.h"
//#import "Categorias.h"

@interface InicioTableViewController : UITableViewController<ABPeoplePickerNavigationControllerDelegate,ABPersonViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)contactosPressButton:(UIButton *)sender;

@end
