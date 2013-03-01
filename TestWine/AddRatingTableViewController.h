//
//  AddRatingTableViewController.h
//  TestWine
//
//  Created by Keith Elliott on 2/28/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChooserViewController;

static int const HIGHEST_RATING = 5;

static int const LOWEST_RATING = 1;

static int const CHOOSER_VIEW = 5000;

static int const TEXTFIELD = 3300;

@interface AddRatingTableViewController : UITableViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *regionBtn;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UIButton *yearBtn;
@property (strong, nonatomic) IBOutlet UIButton *typeBtn;
@property (strong, nonatomic) IBOutlet UIButton *ratingsBtn;

@property (strong, nonatomic) ChooserViewController *chooser;
- (IBAction)ratingChanged:(id)sender;
- (IBAction)typeChanged:(id)sender;
- (IBAction)addRating:(id)sender;
- (IBAction)regionPressed:(id)sender;
- (IBAction)yearPressed:(id)sender;

@end
