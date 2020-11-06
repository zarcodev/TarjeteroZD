//
//  Tarjetas.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 13/04/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categorias;

@interface Tarjetas : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * apellidos;
@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSString * empresa;
@property (nonatomic, retain) NSString * telefono;
@property (nonatomic, retain) NSString * celular;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * web;
@property (nonatomic, retain) id fotofrente;
@property (nonatomic, retain) id fotoatras;

@property (nonatomic, retain) Categorias *inCategoria;

@end
