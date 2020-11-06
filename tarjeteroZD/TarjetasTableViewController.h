//
//  TarjetasTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 30/03/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>
#import "Categorias.h"
//#import "CoreDataAyuda.h"
#import "Tarjetas.h"
#import "DetTarjetasTableViewController.h"
#import "CoreDataTableViewController.h"

@interface TarjetasTableViewController : CoreDataTableViewController <NSFetchedResultsControllerDelegate, UISearchDisplayDelegate, UISearchBarDelegate, UISearchControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fectchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, retain) NSMutableArray *resultadoBusqueda;
@property (strong, nonatomic) Tarjetas *tarjetaSeleccionada;

//@property (strong, nonatomic) Categorias *selectedCategoria;

//@property (strong, nonatomic) NSMutableArray *categorias;
//@property (strong, nonatomic) NSMutableArray *tarjetas;
@property (strong, nonatomic) IBOutlet UISearchBar *buscarSearchBar;

@end
