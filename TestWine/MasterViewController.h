//
//  MasterViewController.h
//  TestWine
//
//  Created by Keith Elliott on 2/15/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
