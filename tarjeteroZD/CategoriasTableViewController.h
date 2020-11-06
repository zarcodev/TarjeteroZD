//
//  CategoriasTableViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 16/04/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoriasTableViewController : UITableViewController <UITableViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)agregarCategoriaPressBarButton:(UIBarButtonItem *)sender;

@end
