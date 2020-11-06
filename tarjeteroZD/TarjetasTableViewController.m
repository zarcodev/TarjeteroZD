//
//  TarjetasTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 30/03/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "TarjetasTableViewController.h"

@interface TarjetasTableViewController ()

@end

@implementation TarjetasTableViewController



@synthesize resultadoBusqueda;
@synthesize tarjetaSeleccionada;
//@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;


/*- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Tarjetas"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Person.name = Blah"];
    
    // 4 - Sort it if you want
    request.sortDescriptors = @[[NSSortDescriptor  sortDescriptorWithKey:@"inCategoria" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:@"inCategoria.nombre"
                                                                                   cacheName:nil];
    [self performFetch];
}
*/

- (NSFetchedResultsController *) fectchedResultsController{
    if (_fectchedResultsController != nil) {
        return _fectchedResultsController;
    }
    NSFetchRequest *tarjetasRequeridas = [NSFetchRequest fetchRequestWithEntityName:@"Tarjetas"];

    
    tarjetasRequeridas.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor  sortDescriptorWithKey:@"inCategoria.nombre" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)], nil];
    
    
    _fectchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:tarjetasRequeridas managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"inCategoria.nombre" cacheName:nil];
    
    _fectchedResultsController.delegate = self;
    
    return _fectchedResultsController;
}


//carga los datos registrados al abrir la vista
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //[self setupFetchedResultsController];
    
    
    [self.fectchedResultsController performFetch:nil];
    self.resultadoBusqueda = [NSMutableArray arrayWithCapacity:[[self.fectchedResultsController fetchedObjects]count]];


    [self.tableView reloadData];



}

- (void) viewWillDisappear:(BOOL)animated
{
    //VACIO RESULTADOS DE BUSQUEDAS PARA NO SE AFECTE CUANDO SE ACTUALIZA A UNA NUEVA CATEGORIA Y ESTA NO ESTABA ASIGNADO A ALGUN REGISTRO
    
     self.fectchedResultsController = NULL;
    [self.resultadoBusqueda removeAllObjects];
    

    self.buscarSearchBar.text = NULL;
    

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*NSError *error;
    if (![self.fectchedResultsController performFetch:&error])
    {
        NSLog(@"Error: %@, %@",error, [error userInfo] );
        abort();
    }
    */

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    //return [self.tarjetas. count];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
       return [[self.fectchedResultsController sections] count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.resultadoBusqueda count];
    } else {
        if ([[self.fectchedResultsController sections] count] > 0) {
            return [[[self.fectchedResultsController sections] objectAtIndex:section] numberOfObjects];
        } else {return 0;}
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return @"Resultado";
    }
    else{
        if ([[self.fectchedResultsController sections] count] > 0)
        {
        
            return [[[self.fectchedResultsController sections] objectAtIndex:section] name];
        }
        else{
          return nil;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celdaID = @"CeldaTarjeta";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celdaID]; //forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celdaID];
    }
    // Configure the cell...
    Tarjetas *miTarjeta = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        miTarjeta = [self.resultadoBusqueda objectAtIndex:indexPath.row];
    }
    else
    {
        miTarjeta = [self.fectchedResultsController objectAtIndexPath:indexPath];
    }
    if (miTarjeta.apellidos == NULL) {
        cell.textLabel.text =miTarjeta.nombre;
    }
    else{
        cell.textLabel.text =[NSString stringWithFormat:@"%@ %@",miTarjeta.nombre, miTarjeta.apellidos];
    }
    
    
    cell.imageView.image = miTarjeta.fotofrente;

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self performSegueWithIdentifier:@"Detalle Tarjeta" sender:self];
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}





// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
            NSLog(@"Borro busqueda");
            
            NSManagedObjectContext *contexto = [self managedObjectContext];
            [contexto deleteObject:[self.resultadoBusqueda objectAtIndex:indexPath.row]];
            NSError *error = nil;
            
            if (![contexto save:&error]) {
                NSLog(@"No se puede borrar! %@ %@",error, [error localizedDescription]);
                return;
            }
            //borro el registro del arreglo
            [self.resultadoBusqueda removeObjectAtIndex:indexPath.row];
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"fin");
            [self.tableView endUpdates];
            
        }
        else
        {
            [self.tableView beginUpdates]; // Avoid  NSInternalInconsistencyException
 
            NSLog(@"Borro resultados");
            Tarjetas *tarjetaBorrar = [self.fectchedResultsController objectAtIndexPath:indexPath];
            NSLog(@"1");
            NSManagedObjectContext *contexto = [self managedObjectContext];
            NSLog(@"2");
            [contexto deleteObject:tarjetaBorrar];
            NSLog(@"3");
            NSError *error = nil;
            
            if (![contexto save:&error]) {
                NSLog(@"No se puede borrar! %@ %@",error, [error localizedDescription]);
                return;
            }
            NSLog(@"4");
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            NSLog(@"despues de borrar");
            //[self performFetch];
            NSLog(@"fin");
            [self.tableView endUpdates];
        }

    }
}


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
    if ([segue.identifier isEqualToString:@"Detalle Tarjeta"])
    {
        if ([segue.destinationViewController isKindOfClass:[DetTarjetasTableViewController class]])
        {
           DetTarjetasTableViewController *destinoVC = segue.destinationViewController;
           

            
            if ([self.searchDisplayController isActive]) {
                NSIndexPath *indice = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
                self.tarjetaSeleccionada = [resultadoBusqueda objectAtIndex:indice.row];
            }
            else
            {
                NSIndexPath *indice = [[self.tableView indexPathsForSelectedRows] lastObject];
                self.tarjetaSeleccionada = [self.fectchedResultsController objectAtIndexPath:indice];
            }
            destinoVC.managedObjectContext = self.managedObjectContext;
            destinoVC.tarjeta = self.tarjetaSeleccionada;
        }
    }
}

#pragma mark - Busqueda

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.resultadoBusqueda removeAllObjects];
    
    
    for (Tarjetas *tarjeta in [self.fectchedResultsController fetchedObjects])
    {
        if ([scope isEqualToString:@"All"] || [tarjeta.nombre isEqualToString:scope])
        {
            NSComparisonResult resultado = [tarjeta.nombre compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0,[searchText length])];
            
            if (resultado == NSOrderedSame)
            {
                [self.resultadoBusqueda addObject:tarjeta];
            }
        }
    }
}


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:@"All"];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:@"All"];
    
    return YES;
}
//se corrije el error donde abortaba si despues de buscar se ponia en modo edicion un acelda y despues se cancelaba la busqueda
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"presiono cancel");
    if (self.tableView.editing == YES) {
        NSLog(@"esta en modo edicion");
        [self.tableView setEditing:NO animated:YES ];
    }else{
        NSLog(@"No esta en modo edicion");
        
    }
}



@end
