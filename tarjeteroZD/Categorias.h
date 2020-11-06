//
//  Categorias.h
//  tarjeteroZD
//
//  Created by Oscar Zarco on 13/04/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Tarjetas;


@class NSManagedObject;

@interface Categorias : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSSet * padreDe;

@end

@interface Categorias (CoreDataGeneratedAccessors)
- (void)addHeldByObject:(Tarjetas *)value;
- (void)removeHeldByObject:(Tarjetas *)value;
- (void)addHeldBy:(NSSet *)values;
- (void)removeHeldBy:(NSSet *)values;

@end

