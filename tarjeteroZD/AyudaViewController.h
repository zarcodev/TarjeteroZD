//
//  AyudaViewController.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 01/06/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaginasAyudaViewController.h"

@interface AyudaViewController : UIViewController <UIPageViewControllerDataSource>

- (IBAction)inicioPressButton:(UIButton *)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
