//
//  CategoriasTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 16/04/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "CategoriasTableViewController.h"
#import "Categorias.h"
//#import "CoreDataAyuda.h"
#import "EditarCategoriasViewController.h"

@interface CategoriasTableViewController () <UIAlertViewDelegate>

//arreglo de la vista usado para los datos de la tabla
@property (strong, nonatomic) NSMutableArray *categorias;

@end

@implementation CategoriasTableViewController

@synthesize managedObjectContext = __managedObjectContext;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//carga los datos registrados al abrir la vista
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //entidad consultada
    NSFetchRequest *datosRequerido = [NSFetchRequest fetchRequestWithEntityName:@"Categorias"];
    //ordenados por
    datosRequerido.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    
    //asigna datos de entidad a arreglo
    NSError *error = nil;
    NSArray *categoriasConsultadas = [[self managedObjectContext] executeFetchRequest:datosRequerido error:&error];
    //copia datos arreglo de la funcion al arreglo de la vista
    self.categorias = [categoriasConsultadas mutableCopy];
    
    //refresca datos
    [self.tableView reloadData];
    
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.categorias count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *celdaID = @"Celda";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celdaID forIndexPath:indexPath];
    
    // Configure the cell...
    Categorias *categoriaSeleccionada = self.categorias[indexPath.row];
    cell.textLabel.text = categoriaSeleccionada.nombre;
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // BORRO DATOS DEL CORE DATA
        NSManagedObjectContext *contexto = [self managedObjectContext];
        [contexto deleteObject:[self.categorias objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if (![contexto save:&error]) {
            NSLog(@"No se puede borrar! %@ %@",error, [error localizedDescription]);
            return;
        }
        //borro el registro del arreglo
        [self.categorias removeObjectAtIndex:indexPath.row];
        
        //borro de la tabla vista
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
          
    }

    
}

/*- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Puedo editar");
    UIAlertView *editarCategoriaAlerta =[[UIAlertView alloc] initWithTitle:@"Modifica el nombre de la categoria" message:nil delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Modificar", nil];
    //indico que debe pedir texto
    [editarCategoriaAlerta setAlertViewStyle:UIAlertViewStylePlainTextInput];

    //muestro
    [editarCategoriaAlerta show];
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
    NSLog(@"Aqui voy");
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"EditarCategoria"]){
        NSLog(@"Aqui voy 2");
        if ([segue.destinationViewController isKindOfClass:[EditarCategoriasViewController class]]) {
            NSLog(@"Aqui voy 3");
            Categorias *categoSelec = [self.categorias objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
            EditarCategoriasViewController *destinoVC = segue.destinationViewController;
            destinoVC.catego = categoSelec;

        }
    }
}




- (IBAction)agregarCategoriaPressBarButton:(UIBarButtonItem *)sender {
    //declaro alerta
    UIAlertView *nuevaCategoriaAlerta =[[UIAlertView alloc] initWithTitle:@"Introduce el nombre de la categoria" message:nil delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Agregar", nil];
    //indico que debe pedir texto
    [nuevaCategoriaAlerta setAlertViewStyle:UIAlertViewStylePlainTextInput];
    //muestro
    [nuevaCategoriaAlerta show];
}

#pragma mark - metodos ayuda
- (Categorias *) categoriaNombre:(NSString *)nombre{
    
    //NSManagedObjectContext *contexto = [self managedObjectContext];
    
    Categorias *categoria = [NSEntityDescription insertNewObjectForEntityForName:@"Categorias" inManagedObjectContext:self.managedObjectContext];
    
    categoria.nombre = nombre;
    
    /*
     NSError *error = nil;
    if (![contexto save:&error]) {
        NSLog(@"No se puede agregar %@",error);
    }
     */
    [categoria.managedObjectContext save:nil];
    
    return categoria;
}


#pragma mark - delegado Alert

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString *textoDeAlerta = [alertView textFieldAtIndex:0].text;
        [self.categorias addObject:[self categoriaNombre:textoDeAlerta]];
        NSIndexPath *indice = [NSIndexPath indexPathForRow:[self.categorias count]-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indice] withRowAnimation:UITableViewRowAnimationFade];
        
    }
}
    
@end
