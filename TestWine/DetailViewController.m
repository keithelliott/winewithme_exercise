//
//  DetailViewController.m
//  TestWine
//
//  Created by Keith Elliott on 2/15/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import "DetailViewController.h"
#import "Wine.h"
#import "WineUtils.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setWine:(id)wine
{
    if (_wine	!= wine) {
        _wine = wine;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

	if (self.wine) {
		self.wineCountry.text = self.wine.region;
		self.wineName.text = self.wine.name;
		NSString *imgName = [NSString stringWithFormat:@"ratings_%d", [self.wine.rating intValue] ];
		self.wineRating.image = [UIImage imageNamed:imgName];
		self.wineYear.text = self.wine.year;
		
		NSString *winetype = self.wine.type;
		
		if([winetype isEqualToString:@"Red"])
			self.wineBottle.image = [UIImage imageNamed:@"RedWine.png"];
		else if([winetype isEqualToString:@"Rose"])
			self.wineBottle.image = [UIImage imageNamed:@"RoseWine.png"];
		else
			self.wineBottle.image = [UIImage imageNamed:@"WhiteWine.png"];
		
		WineUtils *wineUtils = [[WineUtils alloc] init];
		NSString *continent = [wineUtils regionForCountry:self.wine.region];
		
		if(continent != nil && ![continent isEqualToString:@""]){
			self.wineRegion.text = continent;
		}

	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
