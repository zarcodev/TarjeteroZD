//
//  CoreDataAyuda.m
//  tarjeteroZD
//
//  Created by Oscar Zarco on 17/04/15.
//  Copyright (c) 2015 Tecnologias ZD. All rights reserved.
//

#import "CoreDataAyuda.h"


@implementation CoreDataAyuda



+(NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    
    return context;
}


@end
