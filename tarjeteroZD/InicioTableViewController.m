//
//  InicioTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 08/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "InicioTableViewController.h"
#import "ConfiguracionTableViewController.h"
#import "TarjetasTableViewController.h"
#import "NewTableViewController.h"

@interface InicioTableViewController ()

//@property (strong, nonatomic) NSMutableArray *configuracion;
//@property (strong, nonatomic) NSMutableArray *categorias;

@property (nonatomic, assign) ABAddressBookRef addressBook;
@end

@implementation InicioTableViewController

@synthesize managedObjectContext = __managedObjectContext;

//auto instancia el arreglo
/*-(NSMutableArray *) configuracion{
    if (!_configuracion) {
        _configuracion = [[NSMutableArray alloc] init];
    }
    return _configuracion;
}

-(NSMutableArray *) categorias{
    if (!_categorias) {
        _categorias = [[NSMutableArray alloc] init];
    }
    return _categorias;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // [self iniciaDatos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"configuracion"])
    {
        ConfiguracionTableViewController *configuraTVC = segue.destinationViewController;
        configuraTVC.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"tarjetas"])
    {
        TarjetasTableViewController *tarjetasTVC = segue.destinationViewController;
        tarjetasTVC.managedObjectContext = self.managedObjectContext;
    }
    else if ([segue.identifier isEqualToString:@"nuevo"])
    {
        NewTableViewController *nuevoTVC = segue.destinationViewController;
        nuevoTVC.managedObjectContext = self.managedObjectContext;
    }
    
}

/*
#pragma mark - INICIO DATOS

- (void) iniciaDatos {
    //CONFIGURACION
    NSFetchRequest *datoSolicitado = [NSFetchRequest fetchRequestWithEntityName:@"Configuracion"];
    
    NSError *error = nil;
    NSArray *configuracionConsultada = [[CoreDataAyuda managedObjectContext] executeFetchRequest:datoSolicitado error:&error];
    self.configuracion = [configuracionConsultada mutableCopy];
    
    
    
    if (self.configuracion.count == 0 ) {
        NSManagedObjectContext *contexto = [CoreDataAyuda managedObjectContext];
        
        Configuracion *config = [NSEntityDescription insertNewObjectForEntityForName:@"Configuracion" inManagedObjectContext:contexto];
        
        config.agregarContacto = @1;
        config.agregarFoto = @0;
        NSError *error = nil;
        if (![contexto save:&error]) {
            NSLog(@"No se puede agregar configuracion inicial %@",error);
        }
    }
    //CATEGORIAS INICIALES
    NSFetchRequest *datosRequerido = [NSFetchRequest fetchRequestWithEntityName:@"Categorias"];
    error = nil;
    NSArray *categoriasConsultadas = [[CoreDataAyuda managedObjectContext] executeFetchRequest:datosRequerido error:&error];
    

    
    //copia datos arreglo de la funcion al arreglo de la vista
    self.categorias = [categoriasConsultadas mutableCopy];
    
    if (self.categorias.count == 0) {
        NSManagedObjectContext *contexto = [CoreDataAyuda managedObjectContext];
        
        Categorias *categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Categorias" inManagedObjectContext:contexto];
        
        categoria.nombre = @"Categoria 1";
        NSError *error = nil;
        if (![contexto save:&error]) {
            NSLog(@"No se puede agregar categoria inicial %@",error);
        }
        categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Categorias" inManagedObjectContext:contexto];
        categoria.nombre = @"Categoria 2";
        error = nil;
        if (![contexto save:&error]) {
            NSLog(@"No se puede agregar categoria inicial %@",error);
        }
        categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Categorias" inManagedObjectContext:contexto];
        categoria.nombre = @"Categoria 3";
        error = nil;
        if (![contexto save:&error]) {
            NSLog(@"No se puede agregar categoria inicial %@",error);
        }
        categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Categorias" inManagedObjectContext:contexto];
        categoria.nombre = @"Categoria 4";
        error = nil;
        if (![contexto save:&error]) {
            NSLog(@"No se puede agregar categoria inicial %@",error);
        }
    }
}
*/


- (IBAction)contactosPressButton:(UIButton *)sender
{
    NSLog(@"cargo");
    [self checkAddressBookAccess];
    NSLog(@"termina cargo");
}

#pragma mark Address Book Access
// Check the authorization status of our application for Address Book
-(void)checkAddressBookAccess
{   NSLog(@"checa acceso");
    switch (ABAddressBookGetAuthorizationStatus())
    {
            // Update our UI if the user has granted access to their Contacts
        case  kABAuthorizationStatusAuthorized:
            NSLog(@"opc1");
            [self accessGrantedForAddressBook];
            break;
            // Prompt the user for access to Contacts if there is no definitive answer
        case  kABAuthorizationStatusNotDetermined :
            NSLog(@"opc2");
            [self requestAddressBookAccess];
            break;
            // Display a message if the user has denied or restricted access to Contacts
        case  kABAuthorizationStatusDenied:
        case  kABAuthorizationStatusRestricted:
            NSLog(@"opc3");
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Advertencia de Privacidad"
                                                            message:@"No se tienen permisos para acceder a contactos."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [self dismissViewControllerAnimated:YES completion:NULL];
        }
            break;
        default:
            break;
    }
}

// Prompt the user for access to their Address Book data
-(void)requestAddressBookAccess
{  NSLog(@"entre pedir permiso");
    InicioTableViewController * __weak weakSelf = self;
    
    ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (granted)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [weakSelf accessGrantedForAddressBook];
                                                         
                                                     });
                                                 }
                                             });
}

// This method is called when the user has granted access to their address book data.
-(void)accessGrantedForAddressBook
{
    // Load data from the plist file
    // NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Menu" ofType:@"plist"];
    // self.menuArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    // [self.tableView reloadData];
    NSLog(@"entre mostrar");
    [self showPeoplePickerController];
}

#pragma mark Show all contacts
// Called when users tap "Display Picker" in the application. Displays a list of contacts and allows users to select a contact from that list.
// The application only shows the phone, email, and birthdate information of the selected contact.
-(void)showPeoplePickerController
{
    NSLog(@"deberia empezar mostrar contactos");
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    // Display only a person's phone, email, and birthdate
    NSArray *displayedItems = [NSArray arrayWithObjects:[NSNumber numberWithInt:kABPersonPhoneProperty],
                               [NSNumber numberWithInt:kABPersonEmailProperty],
                               [NSNumber numberWithInt:kABPersonBirthdayProperty],
                               [NSNumber numberWithInt:kABPersonImageFormatThumbnail],nil];
    
    
    picker.displayedProperties = displayedItems;
    // Show the picker
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark ABPeoplePickerNavigationControllerDelegate methods
// Displays the information of a selected person
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

// Does not allow users to perform default actions such as dialing a phone number, when they select a person property.
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

// Dismisses the people picker and shows the application when users tap Cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker;
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ABPersonViewControllerDelegate methods
// Does not allow users to perform default actions such as dialing a phone number, when they select a contact property.
- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person
                    property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifierForValue
{
    return NO;
}


#pragma mark ABNewPersonViewControllerDelegate methods
// Dismisses the new-person view controller.
- (void)newPersonViewController:(ABNewPersonViewController *)newPersonViewController didCompleteWithNewPerson:(ABRecordRef)person
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark ABUnknownPersonViewControllerDelegate methods
// Dismisses the picker when users are done creating a contact or adding the displayed person properties to an existing contact.
- (void)unknownPersonViewController:(ABUnknownPersonViewController *)unknownPersonView didResolveToPerson:(ABRecordRef)person
{
    [self.navigationController popViewControllerAnimated:YES];
}

// Does not allow users to perform default actions such as emailing a contact, when they select a contact property.
- (BOOL)unknownPersonViewController:(ABUnknownPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

@end
