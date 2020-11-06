//
//  EditTarjetaTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 08/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "EditTarjetaTableViewController.h"

@interface EditTarjetaTableViewController ()


@end

@implementation EditTarjetaTableViewController

//@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize categoriaSeleccionada;
@synthesize tarje;
@synthesize managedObjectContext = __managedObjectContext;

int indice;


/*- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Categorias"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"nombre"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.tarje.managedObjectContext sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    NSError *error;
    [self.fetchedResultsController performFetch:&error];
}
*/

//auto instancia el arreglo
-(NSMutableArray *) categorias{
    if (!_categorias) {
        _categorias = [[NSMutableArray alloc] init];
    }
    return _categorias;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.nombreTextField.delegate = self;
    self.apellidosTextField.delegate = self;
    self.empresaTextField.delegate = self;
    self.telefonoTextField.delegate = self;
    self.celularTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.webTextField.delegate = self;
    self.auxiliarTextField.delegate = self;
    
    self.categoriasPickerView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   // [self setupFetchedResultsController];
    
    NSFetchRequest *datosRequerido = [NSFetchRequest fetchRequestWithEntityName:@"Categorias"];
    //ordenados por
    datosRequerido.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    
    
    
    //asigna datos de entidad a arreglo
    NSError *error = nil;
    NSArray *categoriasConsultadas = [[self managedObjectContext] executeFetchRequest:datosRequerido error:&error];
    
    //copia datos arreglo de la funcion al arreglo de la vista
    self.categorias = [categoriasConsultadas mutableCopy];
    
    
    NSLog(@"Entro a editar");
    
    if (self.tarje)
    {
        [self.nombreTextField    setText:[self.tarje valueForKey:@"nombre"]];
        [self.apellidosTextField setText:[self.tarje valueForKey:@"apellidos"]];
        [self.empresaTextField   setText:[self.tarje valueForKey:@"empresa"]];
        [self.telefonoTextField  setText:[self.tarje valueForKey:@"telefono"]];
        [self.celularTextField   setText:[self.tarje valueForKey:@"celular"]];
        [self.emailTextField     setText:[self.tarje valueForKey:@"email"]];
        [self.webTextField       setText:[self.tarje valueForKey:@"web"]];
        [self.fotoImageView      setImage:[self.tarje valueForKey:@"fotofrente"]];
        
        
        
        NSString *cateTmp;
        cateTmp = [self.tarje valueForKeyPath:@"inCategoria.nombre"];
        NSLog(@"nombre categoria: %@", cateTmp);
        
        int indiceTmp = 0;
        //for (int i = 0; i < [[[self fetchedResultsController] fetchedObjects]  count]; i++)
        for (int i = 0; i < [self.categorias  count]; i++)
        {
            //NSManagedObject *catego = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:i];
            //NSString *categoriaRecorrida = (NSString *)[catego valueForKey:@"nombre"];
            
            Categorias *cateSel = self.categorias[i];
            NSString *categoriaRecorrida = cateSel.nombre;
            if ([cateTmp isEqualToString:categoriaRecorrida])
            {
                indiceTmp = i;
                indice = i;
            }
        }
        

        [self.categoriasPickerView selectRow:indiceTmp inComponent:0 animated:YES];

    }
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)guardarPressButtonBar:(UIBarButtonItem *)sender
{
    if ([self.nombreTextField.text isEqualToString:@""]) {
        [self valida:@"Nombre"];
    }
    else
    {
        if ([self.empresaTextField.text isEqualToString:@""]) {
            [self valida:@"Empresa"];
        }
        else
        {   NSLog(@"Voy a guardar 1");
           // NSManagedObjectContext *contexto = [CoreDataAyuda managedObjectContext];
            
            NSLog(@"Voy a guardar 2");
            if (self.tarje)
            {
                [self.tarje setValue:self.nombreTextField.text    forKey:@"nombre"];
                [self.tarje setValue:self.empresaTextField.text   forKey:@"empresa"];
                [self.tarje setValue:self.fotoImageView.image     forKey:@"fotofrente"];

                
                NSLog(@"Voy a guardar 4");
                //valido datos no obligatorios
                if (![self.apellidosTextField.text isEqualToString:@""]) {
                    [self.tarje setValue:self.apellidosTextField.text forKey:@"apellidos"];
                }
                if (![self.telefonoTextField.text isEqualToString:@""]) {
                    [self.tarje setValue:self.telefonoTextField.text  forKey:@"telefono"];
                }
                if (![self.celularTextField.text isEqualToString:@""]) {
                    [self.tarje setValue:self.celularTextField.text   forKey:@"celular"];
                }
                if (![self.emailTextField.text isEqualToString:@""]) {
                    [self.tarje setValue:self.emailTextField.text     forKey:@"email"];
                }
                if (![self.webTextField.text isEqualToString:@""]) {
                    [self.tarje setValue:self.webTextField.text       forKey:@"web"];
                }
                
                NSLog(@"Voy a guardar 3");
                
                
                //self.categoriaSeleccionada = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:indice];
                self.categoriaSeleccionada =  self.categorias[indice];
                NSLog(@"Cate selecc: %@ con indice: %i",self.categoriaSeleccionada.nombre, indice);
                //[self.tarje setValue:categoriaSeleccionada forKeyPath:@"inCategoria"];
                [self.tarje setInCategoria:self.categoriaSeleccionada];
            }
            NSLog(@"Voy a guardar 5");
            
            //[self.tarje.managedObjectContext reset];
            
            
            [self.tarje.managedObjectContext save:nil];
            
            NSLog(@"Voy a guardar 6");
            
           /* NSError *error = nil;
            
            if (![contexto save:&error]) {
                NSLog(@"No se puede actualizar %@",error);
            }
            */
            [self.navigationController popViewControllerAnimated:YES ];
        }
    }
}


# pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    indice = row;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.categorias count];
    //return [[[self fetchedResultsController] fetchedObjects] count];

}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    Categorias *categoriaSeleccionada = self.categorias[row];
    NSString *datos = categoriaSeleccionada.nombre;
    NSLog(@"datos: %@",categoriaSeleccionada.nombre);
    //NSManagedObject *catego = [[[self fetchedResultsController] fetchedObjects] objectAtIndex:row];
    //NSString *datos = (NSString *)[catego valueForKey:@"nombre"];
    return datos;
}

# pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.auxiliarTextField = textField;
    
    //Add tap recognizer to scroll view, user can tap other part of scroll view to
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [self.tableView addGestureRecognizer:tapRecognizer];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.auxiliarTextField = nil;
}

/*
 When user tap on the scroll view, the method is called to disable the keyboard
 */
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [self.auxiliarTextField resignFirstResponder];
    [self.tableView removeGestureRecognizer:tapRecognizer];
}

#pragma mark - AUXILIARES

- (void) valida:(NSString *)objeto
{
    NSString *mensaje;
    if ([objeto isEqualToString:@"Imagen"]) {
        mensaje = @"Falta la imagen de la tarjeta";
    }
    else if ([objeto isEqualToString:@"Nombre"]){
        mensaje = @"Falta el nombre";
    }
    else if ([objeto isEqualToString:@"Empresa"]){
        mensaje = @"Falta la empresa";
    }
    
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Falta Dato"
                                                     message:mensaje
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alerta show];
}



@end
