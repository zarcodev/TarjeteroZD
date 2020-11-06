//
//  ConfiguracionTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 19/05/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h> 

@interface ConfiguracionTableViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UISwitch *contactosSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *fotosSwitch;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


- (IBAction)contactosChanged:(UISwitch *)sender;
- (IBAction)fotosChanged:(UISwitch *)sender;

@end
