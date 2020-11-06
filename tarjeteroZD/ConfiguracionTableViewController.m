//
//  ConfiguracionTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 19/05/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "ConfiguracionTableViewController.h"
#import "Configuracion.h"
//#import "CoreDataAyuda.h"
#import "CategoriasTableViewController.h"

@interface ConfiguracionTableViewController ()

@property (strong, nonatomic) NSMutableArray *configuracion;

@end

@implementation ConfiguracionTableViewController

@synthesize managedObjectContext = __managedObjectContext;

//auto instancia el arreglo
-(NSMutableArray *) configuracion{
    if (!_configuracion) {
        _configuracion = [[NSMutableArray alloc] init];
    }
    return _configuracion;
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

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSFetchRequest *datoSolicitado = [NSFetchRequest fetchRequestWithEntityName:@"Configuracion"];
    
    NSError *error = nil;
    NSArray *configuracionConsultada = [[self managedObjectContext] executeFetchRequest:datoSolicitado error:&error];
    self.configuracion = [configuracionConsultada mutableCopy];
    
    Configuracion *configSelect = self.configuracion[0];
    
    NSNumber *cero = @0;
    NSLog(@"cero: %@",cero);
    
    NSLog(@"contacto: %@",configSelect.agregarContacto);
    if ([configSelect.agregarContacto  isEqualToNumber:cero]) {
        self.contactosSwitch.on = NO;
    }else{
        self.contactosSwitch.on = YES;
    }
    NSLog(@"foto: %@",configSelect.agregarFoto);
    if ([configSelect.agregarFoto isEqualToNumber:cero]) {
        self.fotosSwitch.on = NO;
    }else{
        self.fotosSwitch.on = YES;
    }
    

    
}




#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/

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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        //ABRE DIRECCION ITUNES APP STORE
        if (indexPath.row == 0) {
           // NSLog(@"INdice %i",indexPath.row);
            [[UIApplication sharedApplication]
             openURL:[NSURL URLWithString:@"http://www.zarcodev.com"]];

        }
        //ABRE LA VISTA DE EMAIL
        else if (indexPath.row == 1) {
            // Email Subject
            NSString *emailTitle = @"Reporte Tarjetero ZD";
            // Email Content
            NSString *messageBody = @"Indique observaciones de la App TarjeteroZD";
            // To address
            NSArray *toRecipents = [NSArray arrayWithObject:@"zarcodev@gmail.com"];
            
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            [mc setToRecipients:toRecipents];
            
            // Present mail view controller on screen
            //[self presentViewController:mc animated:YES completion:nil];
            [self dismissViewControllerAnimated:YES completion:^{
                [self presentViewController:mc animated:YES completion:nil];
            }];
        }
    }
  //  NSLog(@"Section %i",indexPath.section);
  //  NSLog(@"INdice %i",indexPath.row);
    
}

#pragma mark - ENVIO EMAIL
//ACCIONES DESPUES DE ABRIR LA VISTA DE EMAIL
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"categorias"])
    {
         CategoriasTableViewController *categoriaTVC = segue.destinationViewController;
        categoriaTVC.managedObjectContext = self.managedObjectContext;
    }
}


- (IBAction)contactosChanged:(UISwitch *)sender {
    NSManagedObject *configSelec = self.configuracion[0];
    NSNumber *valor;
    
    if (self.contactosSwitch.on == YES){
        valor = @1;
    }else{
        valor = @0;
    }
    
    NSManagedObjectContext *contexto = [self managedObjectContext];
    
    if (configSelec) {
        [configSelec   setValue:valor forKey:@"agregarContacto"];
    }
    
    NSError *error = nil;
    if (![contexto save:&error]) {
        NSLog(@"No se puede actualizar %@",error);
    }
    
}

- (IBAction)fotosChanged:(UISwitch *)sender {
    NSManagedObject *configSelec = self.configuracion[0];
    NSNumber *valor;
    
    if (self.fotosSwitch.on == YES){
        valor = @1;
    }else{
        valor = @0;
    }
    
    NSManagedObjectContext *contexto = [self managedObjectContext];
    
    if (configSelec) {
        [configSelec   setValue:valor forKey:@"agregarFoto"];
    }
    
    NSError *error = nil;
    if (![contexto save:&error]) {
        NSLog(@"No se puede actualizar %@",error);
    }
}
@end
