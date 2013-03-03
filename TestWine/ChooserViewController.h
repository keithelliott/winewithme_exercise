//
//  ChooserViewController.h
//  winewithme
//
//  Created by Keith Elliott on 1/25/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WineUtils;

static int const COMPONENTS_IN_REGION = 2;
static int const COMPONENTS_DEFAULT = 1;
typedef enum ChooserUIEnum{
    CTYear,
    CTRegion,
    CTType
} ChooserUIType;

@interface ChooserViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic) ChooserUIType pickerType;
@property (strong, nonatomic) WineUtils *wineUtils;
@property (copy, nonatomic) NSString *selectedValue;

@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

- (IBAction)donePressed:(id)sender;
- (id)initWithPickerType:(ChooserUIType)pickerType;
+ (id)objectWithPickerType:(ChooserUIType)pickerType;

@end
