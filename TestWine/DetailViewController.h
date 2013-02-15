//
//  DetailViewController.h
//  TestWine
//
//  Created by Keith Elliott on 2/15/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
