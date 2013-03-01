//
//  Wine.h
//  TestWine
//
//  Created by Keith Elliott on 2/28/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Wine : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * year;

@end
