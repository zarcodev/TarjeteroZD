//
//  PaginasAyudaViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 01/06/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaginasAyudaViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *tituloLabel;
@property (strong, nonatomic) IBOutlet UIImageView *fondoImageView;

@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;

@end
