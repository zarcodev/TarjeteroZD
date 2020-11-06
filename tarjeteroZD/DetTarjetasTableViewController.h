//
//  DetTarjetasTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 06/07/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 
#import "EditTarjetaTableViewController.h"

@interface DetTarjetasTableViewController : UITableViewController <UIActionSheetDelegate,MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) Tarjetas *tarjeta;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end
