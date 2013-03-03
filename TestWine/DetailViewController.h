//
//  DetailViewController.h
//  TestWine
//
//  Created by Keith Elliott on 2/15/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Wine;
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Wine* wine;

@property (strong, nonatomic) IBOutlet UILabel *wineName;
@property (strong, nonatomic) IBOutlet UILabel *wineRegion;
@property (strong, nonatomic) IBOutlet UILabel *wineCountry;
@property (strong, nonatomic) IBOutlet UILabel *wineYear;


@property (strong, nonatomic) IBOutlet UIImageView *wineRating;
@property (strong, nonatomic) IBOutlet UIImageView *wineBottle;
@end
