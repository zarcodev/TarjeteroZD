//
//  PaginasAyudaViewController.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 01/06/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "PaginasAyudaViewController.h"

@interface PaginasAyudaViewController ()

@end

@implementation PaginasAyudaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.fondoImageView.image = [UIImage imageNamed:self.imageFile];
    self.tituloLabel.text = self.titleText;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
