//
//  DetTarjetasTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 06/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "DetTarjetasTableViewController.h"

@interface DetTarjetasTableViewController ()



@end

int opcion = 0;
NSMutableArray *secciones;

@implementation DetTarjetasTableViewController

@synthesize managedObjectContext = __managedObjectContext;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //[secciones removeAllObjects];
    
//    if ([secciones count] > 0) {
//        [secciones removeAllObjects];
//        NSLog(@"Borro Datos, ahora quedan: %i",[secciones count]);
//    }
//    else
//    {
        secciones = [[NSMutableArray alloc]init];
        NSLog(@"Inicializo datos, ahora queda:%i",[secciones count]);
//    }
    
    int secc= 0;
    
    if (self.tarjeta.fotofrente != NULL)
    {
        [secciones insertObject:@"Tarjeta" atIndex:secc];
        secc++;
    }
    NSString *valor;
    valor =self.tarjeta.inCategoria.nombre;
    
    if ( valor != NULL) {
        [secciones insertObject:@"Categoria" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.nombre ;
    if ( valor != NULL) {
        [secciones insertObject:@"Nombre" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.apellidos ;
    if ( valor != NULL) {
        [secciones insertObject:@"Apellidos" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.empresa;
    if ( valor != NULL) {
        [secciones insertObject:@"Empresa" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.telefono;
    if ( valor != NULL) {
        [secciones insertObject:@"Telefono" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.celular ;
    if ( valor != NULL) {
        [secciones insertObject:@"Celular" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.email ;
    if ( valor != NULL) {
        [secciones insertObject:@"Email" atIndex:secc];
        secc++;
    }
    valor = self.tarjeta.web;
    if ( valor != NULL) {
        [secciones insertObject:@"Web" atIndex:secc];
    }
    NSLog(@"Inicializo datos, son: %i",[secciones count]);
    
    [self.tableView reloadData];
}


-(void) viewWillDisappear:(BOOL)animated{
    [secciones removeAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    NSLog(@"Secciones: %i",[secciones count]);
    return [secciones count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
  //  if ([secciones count] >= section) {
        return [secciones objectAtIndex:section];
  //  }
  //  else{
    //    return nil;
   // }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *celdaID = @"CeldaTarj";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celdaID  forIndexPath:indexPath];
    
    // Configure the cell...

    NSString *etiqueta;
    NSString *valor = [secciones objectAtIndex:indexPath.section];
    
            if ([valor  isEqualToString:@"Nombre"]) {
                etiqueta = self.tarjeta.nombre;
            }
            else if ([valor isEqualToString:@"Apellidos"]){
                 etiqueta = self.tarjeta.apellidos;
            }
            else if ([valor isEqualToString:@"Empresa"]){
                etiqueta = self.tarjeta.empresa;
            }
            else if ([valor isEqualToString:@"Telefono"]){
                etiqueta = self.tarjeta.telefono;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if ([valor isEqualToString:@"Celular"]){
                etiqueta = self.tarjeta.celular;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if ([valor isEqualToString:@"Email"]){
                etiqueta = self.tarjeta.email;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if ([valor isEqualToString:@"Web"]){
                etiqueta = self.tarjeta.web;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if ([valor isEqualToString:@"Categoria"]){
                etiqueta = self.tarjeta.inCategoria.nombre;
            }
            else if ([valor isEqualToString:@"Tarjeta"]){
                cell.imageView.image = self.tarjeta.fotofrente;
            }
            cell.textLabel.text = etiqueta;

    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if ([secciones count] >= indexPath.section)
   // {
        NSString *valor = [secciones objectAtIndex:indexPath.section];
        if ([valor isEqualToString:@"Tarjeta"])
        {
            return 250;
        }
        else
        {
            return 44;
        }
   // }
   // else
   // {
     //       return 44;
       // }
        
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *valor = [secciones objectAtIndex:indexPath.section];
    NSString *titulo;
    NSString *descripcion;
    if ([valor isEqualToString:@"Telefono"]){
       opcion = 1;
       titulo =@"Llamada Telefonica";
       descripcion =@"Llamar telefono";
    }
    else if ([valor isEqualToString:@"Celular"]){
        opcion = 2;
        titulo =@"Llamada Telefonica";
        descripcion =@"Llamar Celular";
    }
    else if ([valor isEqualToString:@"Email"]){
        opcion = 3;
        titulo =@"Correo";
        descripcion =@"Enviar correo";
    }
    else if ([valor isEqualToString:@"Web"]){
        opcion = 4;
        titulo =@"Sitio Web";
        descripcion =@"Ir al sitio Web";
    }
    else
    {
        opcion = 0;
    }
    if (opcion > 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:titulo delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:descripcion, nil];
        
        actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
        [actionSheet showInView:self.view];
    }

    
}
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
    if ([segue.identifier isEqualToString:@"EditarTarjeta"])
    {   NSLog(@"Voy a editar");
        if ([segue.destinationViewController isKindOfClass:[EditTarjetaTableViewController class]])
        {
            NSLog(@"Voy casi a editar");
            //NSManagedObject *tarjetaSelec = self.tarjeta;
            
            EditTarjetaTableViewController *destinoVC = segue.destinationViewController;
            //destinoVC.tarje = tarjetaSelec;
            destinoVC.tarje = self.tarjeta;
            destinoVC.managedObjectContext = self.managedObjectContext;
            NSLog(@"Voy paso dato a editar");
        }
    }
}

#pragma mark - metodos UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            if (opcion == 4) {
                //ir navegador
                [[UIApplication sharedApplication]
                 openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.tarjeta.web]]];
                break;
            }
            else if (opcion == 3){
                //enviar correo
                // Email Subject
                NSString *emailTitle = @"Asunto";
                // Email Content
                NSString *messageBody = @"Contenido";
                // To address
                NSArray *toRecipents = [NSArray arrayWithObject:self.tarjeta.email];
                
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
                break;
                
            }
            else if (opcion == 2){
                //llamar celular
                [self MarcarNumero:self.tarjeta.celular];
                break;
            }
            else if (opcion == 1){
                //llamar telefono
                [self MarcarNumero:self.tarjeta.telefono];
                break;
            }
            else
            {
                break;}
            
            
    }
}

#pragma mark - FUNCIONES AUXILIARES

-(BOOL)MarcarNumero:(NSString *)tel_num
{
    NSString *s = [NSString stringWithFormat:@"tel:%@",tel_num];
    NSURL *tel = [NSURL URLWithString:s] ;
    if([[UIApplication sharedApplication] canOpenURL:tel])
    {
        [[UIApplication sharedApplication] openURL:tel];
        return YES;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No es posible realizar llamada en el dispositivo" delegate:nil cancelButtonTitle:@"Cancelar" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
}

#pragma mark - ENVIO EMAIL - MFMailComposeViewControllerDelegate

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

@end
