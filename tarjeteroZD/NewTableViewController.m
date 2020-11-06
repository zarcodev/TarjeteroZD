//
//  NewTableViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 08/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "NewTableViewController.h"

@interface NewTableViewController ()

@property (strong, nonatomic) NSMutableArray *tarjetas;
@property (strong, nonatomic) NSMutableArray *categorias;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (strong, nonatomic) NSMutableArray *configuracion;

@property (nonatomic, strong) UIView *overlay;

@end

@implementation NewTableViewController

@synthesize managedObjectContext = __managedObjectContext;

int indice;
bool agregarLibretaContactos;
bool agregarFotoAlbumRollo;

- (NSMutableArray *) tarjetas{
    if (!_tarjetas) {
        _tarjetas = [[NSMutableArray alloc]init];
    }
    return _tarjetas;
}
//auto instancia el arreglo
-(NSMutableArray *) categorias{
    if (!_categorias) {
        _categorias = [[NSMutableArray alloc] init];
    }
    return _categorias;
}

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
    self.categoriasPickerView.delegate = self;
    
    self.nombreTextField.delegate = self;
    self.apellidosTextField.delegate = self;
    self.empresaTextField.delegate = self;
    self.telefonoTextField.delegate = self;
    self.celularTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.webTextField.delegate = self;
    self.auxiliar.delegate = self;
    
    // Create a queue to perform recognition operations
    self.operationQueue = [[NSOperationQueue alloc] init];
    /*
     */
   // [self registerForKeyboardNotifications];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.auxiliar = nil;
  //  self.fondoScrollView = nil;
  //  [self unregisterForKeyboardNotifications];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //carga las categorias
    NSFetchRequest *datosRequerido = [NSFetchRequest fetchRequestWithEntityName:@"Categorias"];
    //ordenados por
    datosRequerido.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"nombre" ascending:YES]];
    
    //asigna datos de entidad a arreglo
    NSError *error = nil;
    NSArray *categoriasConsultadas = [[self managedObjectContext] executeFetchRequest:datosRequerido error:&error];
    //copia datos arreglo de la funcion al arreglo de la vista
    self.categorias = [categoriasConsultadas mutableCopy];
    
    //carga la configuracion
    NSFetchRequest *datoSolicitado = [NSFetchRequest fetchRequestWithEntityName:@"Configuracion"];
    
    error = nil;
    NSArray *configuracionConsultada = [[self managedObjectContext] executeFetchRequest:datoSolicitado error:&error];
    self.configuracion = [configuracionConsultada mutableCopy];
    
    Configuracion *configSelect = self.configuracion[0];
    
    NSNumber *cero = @0;
    NSLog(@"cero: %@",cero);
    
    NSLog(@"contacto: %@",configSelect.agregarContacto);
    if ([configSelect.agregarContacto  isEqualToNumber:cero]) {
        agregarLibretaContactos = NO;
        
    }else{
        agregarLibretaContactos = YES;
    }
    NSLog(@"foto: %@",configSelect.agregarFoto);
    if ([configSelect.agregarFoto isEqualToNumber:cero]) {
        agregarFotoAlbumRollo = NO;
    }else{
        agregarFotoAlbumRollo = YES;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Metodos ayuda
- (Tarjetas *) tarjetaNuevaDesdeVista{
    
    Tarjetas *tarjeta = [NSEntityDescription insertNewObjectForEntityForName:@"Tarjetas" inManagedObjectContext:[self managedObjectContext]];
    //imagen, nombre y empresa son obligatorios
    tarjeta.nombre = self.nombreTextField.text;
    tarjeta.fotofrente = self.fotoImageView.image;
    tarjeta.empresa = self.empresaTextField.text;
    tarjeta.fecha = [NSDate date];
    
    Categorias *categoriaSeleccionada = self.categorias[indice];
    tarjeta.inCategoria = self.categorias[indice];
    
    
    //valido datos no obligatorios
    if (![self.apellidosTextField.text isEqualToString:@""]) {
        tarjeta.apellidos = self.apellidosTextField.text;
    }
    if (![self.telefonoTextField.text isEqualToString:@""]) {
        tarjeta.telefono = self.telefonoTextField.text;
    }
    if (![self.celularTextField.text isEqualToString:@""]) {
        tarjeta.celular = self.celularTextField.text;
    }
    if (![self.emailTextField.text isEqualToString:@""]) {
        tarjeta.email = self.emailTextField.text;
    }
    if (![self.webTextField.text isEqualToString:@""]) {
        tarjeta.web = self.webTextField.text;
    }
    
    
    NSError *error = nil;
    if (![[tarjeta managedObjectContext] save:&error]) {
        NSLog(@"%@",error);
        
    }
    
    if (agregarFotoAlbumRollo == YES)
    {   //guardo imagen en rollo
        UIImageWriteToSavedPhotosAlbum(self.fotoImageView.image, nil, nil, nil);
    }
    
    return tarjeta;
}

- (IBAction)camaraPressButtonBar:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Capturar Tarjeta" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Camara",@"Rollo Fotografico", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:{
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
                picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                //picker.accessibilityFrame = CGRectMake(10, 10, 300, 300);
                picker.showsCameraControls = YES;
                //picker.navigationBarHidden = YES;
                //picker.toolbarHidden = YES;
                picker.allowsEditing = YES;
                
            
            }
            else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
            
        case 1:{
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.delegate = self;
            
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            [self presentViewController:picker animated:YES completion:nil];
            break;
        }
    }
}


- (IBAction)cancelarPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES ];
}

- (IBAction)agregarPressButton:(UIButton *)sender
{
    NSLog(@"Salvar");
    if (self.fotoImageView.image == NULL) {
        [self valida:@"Imagen"];
    }
    else
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
            {
                [self.tarjetas addObject:[self tarjetaNuevaDesdeVista]];
                
                if (agregarLibretaContactos == YES)
                {
                    [self addContacto];
                }
                [self.navigationController popViewControllerAnimated:YES ];
                NSLog(@"Salvado");
            }
        }
    }
}

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

# pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *imagen = info[UIImagePickerControllerEditedImage];
    if (!imagen) {
        imagen = info[UIImagePickerControllerOriginalImage];
    }
    self.fotoImageView.image = imagen;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self recognizeImageWithTesseract:imagen];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    indice = row;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.categorias count];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    Categorias *categoriaSeleccionada = self.categorias[row];
    NSString *datos = categoriaSeleccionada.nombre;
    //NSLog(@"datos: %@",categoriaSeleccionada.nombre);
    return datos;
}

#pragma mark - Reconocimiento Imgen
-(void)recognizeImageWithTesseract:(UIImage *)image
{
    // Preprocess the image so Tesseract's recognition will be more accurate
    UIImage *bwImage = [image g8_blackAndWhite];
    
    // Animate a progress activity indicator
    [self.miActivityIndicatorView startAnimating];
    
    // Display the preprocessed image to be recognized in the view
    //self.imagenFrenteImageView.image  = bwImage;
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"spa"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = bwImage;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        
        NSString *recognizedText = tesseract.recognizedText;
        // NSLog(@"Texto resuntado:  %@", recognizedText);
        //////////////////////////////////////////////////////////////////////
        //PRUEBA RECONOCIMIENTOS DE CADENAS
        //////////////////////////////////////////////////////////////////////
        
        /// WEB Y MAIL CON DATADETECTOR
        NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
        
        NSArray *matches = [linkDetector matchesInString:recognizedText options:0 range:NSMakeRange(0, [recognizedText length])];
        
        for (NSTextCheckingResult *match in matches) {
            if ([match resultType] == NSTextCheckingTypeLink) {
                if ([match.URL.absoluteString rangeOfString:@"mailto:"].location != NSNotFound )
                {
                    //email
                    //quito la palabra mailto
                    NSRange rangoReemplazar = [match.URL.absoluteString rangeOfString:@"mailto:"];
                    self.emailTextField.text = [match.URL.absoluteString stringByReplacingCharactersInRange:rangoReemplazar withString:@""];
                }
                else
                { //web
                    NSRange rangoReemplazar = [match.URL.absoluteString rangeOfString:@"http://"];
                    self.webTextField.text = [match.URL.absoluteString stringByReplacingCharactersInRange:rangoReemplazar withString:@""];
                }
                //NSURL *url = [match URL];
                //NSLog(@"found URL: %@", url);
            }
        }
        
        /// TELEFONOS CON DATA DETECTOR (si hay parentesis o guiones no los detecta)
        NSDataDetector *telefonoDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber error:nil];
        NSArray *coincidencias = [telefonoDetector matchesInString:recognizedText options:0 range:NSMakeRange(0, [recognizedText length])];
        
        for (NSTextCheckingResult *coincide in coincidencias)
        {
            if ([coincide resultType] == NSTextCheckingTypePhoneNumber)
            {
                if ([self.telefonoTextField.text isEqualToString:@""])
                {
                    self.telefonoTextField.text = [coincide phoneNumber];
                }
                else
                {
                    self.celularTextField.text = [coincide phoneNumber];
                }
                NSString *telefono = [coincide phoneNumber];
                NSLog(@"Telefono Data: %@",telefono);
            }
        }
        
        ///// DETECCION MANUAL CON ARREGLOS
        NSMutableArray *listaCadenas = [[recognizedText componentsSeparatedByString:@"\n"] mutableCopy];
        //NSLog(@"Cadenitas: %@", listaCadenas);
        for (int i = 0; i < [listaCadenas count]; i++)
        {
            NSString *cade = [listaCadenas objectAtIndex:i];
            if ([self.telefonoTextField.text isEqualToString:@""])
            {
                //NSLog(@"entro tel");
                if ([cade rangeOfString:@"Tel"].location != NSNotFound || [cade rangeOfString:@"TEL"].location != NSNotFound )
                {
                    
                    
                    self.telefonoTextField.text = [self obtenerSoloNumerosDeLaCadena:cade];
                    
                }
            }
            
            if ([self.celularTextField.text isEqualToString:@""])
            {  NSLog(@"entro cel");
                if ([cade rangeOfString:@"Cel"].location != NSNotFound || [cade rangeOfString:@"CEL"].location != NSNotFound )
                {
                    self.celularTextField.text = [self obtenerSoloNumerosDeLaCadena:cade];
                }
            }
            
        }
        //borro las cadenas pequeñas o con numeros
        for (int i = 0; i < [listaCadenas count]; i++)
        {
            NSString *cade = [listaCadenas objectAtIndex:i];
            
            
            
            NSScanner *scaner = [NSScanner scannerWithString:cade];
            NSCharacterSet *numerosSimbolos = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
            NSString *cadeConNumeros;
            //si encuentra un caracter definido se detiene
            [scaner scanUpToCharactersFromSet:numerosSimbolos intoString:&cadeConNumeros];
            
            //NSLog(@"Cadena: %@ Longitud: %lu",cade, cade.length);
            //NSLog(@"Cadena con numeros: %@ Longitud: %lu",cadeConNumeros, cadeConNumeros.length);
            
            if (cade.length <=3 ||  cadeConNumeros.length < cade.length)
            {
                [listaCadenas removeObjectAtIndex:i];
                i--;
            }
            
        }
        if ([listaCadenas count] >= 1) {
            self.empresaTextField.text = [listaCadenas objectAtIndex:0];
        }
        if ([listaCadenas count] >= 2) {
            NSMutableArray *listaNombres = [[[listaCadenas objectAtIndex:1] componentsSeparatedByString:@" "] mutableCopy];
            
            //NSLog(@"Numero de nombres %lu",(unsigned long)[listaNombres count]);
            //NSLog(@"Nombres: %@", listaNombres);
            
            if ([listaNombres count] == 2) {
                self.nombreTextField.text = [listaNombres objectAtIndex:0];
                self.apellidosTextField.text = [listaNombres objectAtIndex:1];
            }
            else if ([listaNombres count] == 1){
                self.nombreTextField.text = [listaNombres objectAtIndex:0];
            }
            else{
                NSString *ape;
                NSString *nom;
                for (int i = [listaNombres count]; i > 0; i--) {
                    if ((i-2) >= 0) {
                        if (ape == NULL) {
                            ape =[listaNombres objectAtIndex:(i-1)];
                        }else{
                            ape = [NSString stringWithFormat:@"%@ %@",[listaNombres objectAtIndex:(i-1)],ape];}
                    }
                    else{
                        if (nom == NULL) {
                            nom = [listaNombres objectAtIndex:(i-1)];
                        } else {
                            nom = [NSString stringWithFormat:@"%@ %@",[listaNombres objectAtIndex:(i-1)],nom];}
                    }
                }
                self.nombreTextField.text = nom;
                self.apellidosTextField.text = ape;
            }
            
        }
        
        // Remove the animated progress activity indicator
        [self.miActivityIndicatorView stopAnimating];
        
        // NSLog(@"Texto filtrado:  %@", listaCadenas);
        /*  NSPredicate *predicado = [NSPredicate predicateWithFormat:@"SELF CONTAINS '*[0-9]*'"];
         [listaCadenas filteredArrayUsingPredicate:predicado];
         NSLog(@"Texto filtrado predicado:  %@", listaCadenas);
         
         
         NSString* pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
         
         NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
         if ([predicate evaluateWithObject:@"johndoe@example.com"] == YES) {
         // Okay
         } else {
         // Not found
         }
         
         //////////////////////////////////////////////////////////////////////
         
         
         // Spawn an alert with the recognized text
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
         message:recognizedText
         delegate:nil
         cancelButtonTitle:@"OK"
         otherButtonTitles:nil];
         [alert show];*/
    };
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

#pragma mark - DELEGADO TEXTFIELD
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.auxiliar= textField;
    
    //Add tap recognizer to scroll view, user can tap other part of scroll view to
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    [self.tableView addGestureRecognizer:tapRecognizer];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.auxiliar= nil;
}


//when the keyboard is number pad, there will be not reture key
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*
 When user tap on the scroll view, the method is called to disable the keyboard
 */
- (void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    [self.auxiliar resignFirstResponder];
    [self.tableView removeGestureRecognizer:tapRecognizer];
}

#pragma mark - event of keyboard relative methods
/*- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)unregisterForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

*/

/*- (void)keyboardWillShown:(NSNotification*)aNotification
{
    //SE USA PARA MOVER EL SCROLL Y SEA VISIBLE
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect frame = self.view.frame;
    
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
        frame.size.height -= kbSize.height;
        
    }else{
        frame.size.height -= kbSize.width;
    }
    CGPoint fOrigin = self.webTextField.frame.origin;
    fOrigin.y -= self.tableView.contentOffset.y;
    fOrigin.y += self.webTextField.frame.size.height;
    if (!CGRectContainsPoint(frame, fOrigin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.webTextField.frame.origin.y + self.webTextField.frame.size.height - frame.size.height);
        [self.tableView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{    //SE USA PARA REGRESAR EL SCROLL A LA POSICION
    [self.tableView setContentOffset:CGPointZero animated:YES];
}
*/
#pragma mark - AGREGAR CONTACTO

- (void)addContacto
{
    ABAddressBookRef addressBook = NULL;
    CFErrorRef error = NULL;
    
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized: {
            addressBook = ABAddressBookCreateWithOptions(NULL, &error);
            
            [self agregarContactoConNombre:self.nombreTextField.text conApellidos:self.apellidosTextField.text conEmpresa:self.empresaTextField.text conTelefono:self.telefonoTextField.text conCelular:self.celularTextField.text conEmail:self.emailTextField.text conWeb:self.webTextField.text conTarjeta:self.fotoImageView.image inAddressBook:addressBook];
            
            if (addressBook != NULL) CFRelease(addressBook);
            break;
        }
        case kABAuthorizationStatusDenied: {
            NSLog(@"No se tiene acceso a la libreta de direcciones");
            break;
        }
        case kABAuthorizationStatusNotDetermined: {
            addressBook = ABAddressBookCreateWithOptions(NULL, &error);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                if (granted) {
                    NSLog(@"Access was granted");
                    [self agregarContactoConNombre:self.nombreTextField.text conApellidos:self.apellidosTextField.text conEmpresa:self.empresaTextField.text conTelefono:self.telefonoTextField.text conCelular:self.celularTextField.text conEmail:self.emailTextField.text conWeb:self.webTextField.text conTarjeta:self.fotoImageView.image inAddressBook:addressBook];
                }
                else NSLog(@"Access was not granted");
                if (addressBook != NULL) CFRelease(addressBook);
            });
            break;
        }
        case kABAuthorizationStatusRestricted: {
            NSLog(@"access restricted to address book");
            break;
        }
    }
}

- (ABRecordRef)agregarContactoConNombre:(NSString *)nombre conApellidos:(NSString *)apellidos conEmpresa:(NSString *)empresa conTelefono:(NSString *)telefono conCelular:(NSString *)celular conEmail:(NSString *)email conWeb:(NSString *)web conTarjeta:(UIImage *)tarjeta  inAddressBook:(ABAddressBookRef)addressBook
{
    ABRecordRef persona = ABPersonCreate();
    CFErrorRef error = NULL;
    
    //1
    if (persona == NULL) {
        NSLog(@"Error al crear registro de nueva persona.");
        return NULL;
    }
    
    //2
    BOOL couldSetNombre = ABRecordSetValue(persona, kABPersonFirstNameProperty, (__bridge CFTypeRef)nombre, &error);
    BOOL couldSetEmpresa   = ABRecordSetValue(persona, kABPersonOrganizationProperty, (__bridge CFTypeRef)empresa, &error);
    if (couldSetNombre &&  couldSetEmpresa ) {
        NSLog(@"Se configuraron correctamente los datos nombre y empresa");
    } else {
        NSLog(@"Error al configurar datos nombre y empresa");
    }
    
    if (![self.apellidosTextField.text isEqualToString:@""]) {
       BOOL couldSetApellidos  = ABRecordSetValue(persona, kABPersonLastNameProperty, (__bridge CFTypeRef)apellidos, &error);
        if (couldSetApellidos) {
            NSLog(@"Se configuraron correctamente los datos apellidos");
        } else {
            NSLog(@"Error al configurar datos apellidos");
        }
    }
    
    ABRecordSetValue(persona, kABPersonNoteProperty, @"Contacto agregado desde Tarjetero ZD", &error);
    //3
    BOOL couldAddPerson = ABAddressBookAddRecord(addressBook, persona, &error);
    
    if (couldAddPerson) {
        NSLog(@"Se agrego satisfactoriamente los datos persona.");
    } else {
        NSLog(@"Error al agregar persona.");
        CFRelease(persona);
        persona = NULL;
        return persona;
    }
    
    
    if ([self.telefonoTextField.text isEqualToString:@""] && [self.celularTextField.text isEqualToString:@""]) {
        NSLog(@"No hay telefono ni celular");
    }
    else
    {
        //--------------------------------------------------------------
        ABMutableMultiValueRef multiTelefono = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        BOOL didAddTelefono;
        if (![self.telefonoTextField.text isEqualToString:@""]) {
            didAddTelefono = ABMultiValueAddValueAndLabel(multiTelefono, (__bridge CFTypeRef)celular, kABPersonPhoneMobileLabel, NULL);
            if (!didAddTelefono) {
                NSLog(@"Error al configurar telefono movil");
            }
        }
        
        if (![self.celularTextField.text isEqualToString:@""]) {
            didAddTelefono = ABMultiValueAddValueAndLabel(multiTelefono, (__bridge CFTypeRef)telefono, kABPersonPhoneMainLabel, NULL);
            if (!didAddTelefono) {
                NSLog(@"Error al configurar telefono");
            }
        }
        
        
        ABRecordSetValue(persona, kABPersonPhoneProperty, multiTelefono,&error);
        NSLog(@"Telefonos guardados......");
       
        
        CFRelease(multiTelefono);
    }


    if (![self.webTextField.text isEqualToString:@""])
    {
        //----------------------------------------------------------------------
        ABMutableMultiValueRef multiWeb = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        //BOOL didAddWeb =
        ABMultiValueAddValueAndLabel(multiWeb, (__bridge CFTypeRef)web, kABPersonHomePageLabel, NULL);
        //if (didAddWeb) {
        ABRecordSetValue(persona, kABPersonURLProperty, multiWeb, &error);
        NSLog(@"Web guardado......");

        CFRelease(multiWeb);
    }

    if (![self.emailTextField.text isEqualToString:@""])
    {
        //---------------------------------------------------------------------
        ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABPersonEmailProperty);
        //BOOL didAddEmail =
        ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef) email, kABOtherLabel, NULL);
        //if (didAddEmail) {
        ABRecordSetValue(persona, kABPersonEmailProperty, multiEmail, &error);
        NSLog(@"Email guardado......");
        //}
        CFRelease(multiEmail);
    }
    //----------------------------------------------------------------------
    NSData *dataRefImagen = UIImagePNGRepresentation(tarjeta);
    CFDataRef cfDataRefImagen = CFDataCreate(NULL, [dataRefImagen bytes], [dataRefImagen length]);
    ABPersonSetImageData(persona, cfDataRefImagen, &error);
    
    
    
    //----------------------------------------------------------------------
    //4
    if (ABAddressBookHasUnsavedChanges(addressBook)) {
        BOOL couldSaveAddressBook = ABAddressBookSave(addressBook, &error);
        
        if (couldSaveAddressBook) {
            NSLog(@"Contacto satisfactoriamente agregado a la libreta de direcciones.");
        } else {
            NSLog(@"Error.");
        }
    }
    
    return persona;
}

#pragma mark - AUXILIARES

-(NSString*)obtenerSoloNumerosDeLaCadena:(NSString*)stringToStrip{
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:stringToStrip.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:stringToStrip];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
            
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    
    return strippedString;
}


@end
