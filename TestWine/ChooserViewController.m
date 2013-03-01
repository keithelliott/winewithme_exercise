//
//  ChooserViewController.m
//  winewithme
//
//  Created by Keith Elliott on 1/25/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import "ChooserViewController.h"
#import "WineUtils.h"

@interface ChooserViewController ()

@end

@implementation ChooserViewController {
}

@synthesize navItem = _navItem;
@synthesize pickerType = _pickerType;
@synthesize wineUtils = _wineUtils;
@synthesize selectedValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithPickerType:(ChooserUIType)pickerType {
    self = [super initWithNibName:@"ChooserViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        _pickerType = pickerType;
				_wineUtils = [[WineUtils alloc] init];
    }

    return self;
}

+ (id)objectWithPickerType:(ChooserUIType)pickerType {
    return [[ChooserViewController alloc] initWithPickerType:pickerType];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	switch (_pickerType) {
		case CTRegion:
			self.navBar.title = @"Wine Region";
			break;
		case CTType:
			self.navBar.title = @"Wine Type";
			break;
		case CTYear:
			self.navBar.title = @"Wine Year";
			break;
		default:
			break;
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender {
	NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
	
	if(selectedValue == nil){
			if(self.pickerType == CTYear)
				selectedValue = [_wineUtils.wineYears objectAtIndex:0];
		  else if(self.pickerType == CTRegion){
				NSString *country = [[_wineUtils wineCountries] objectAtIndex:0];
				selectedValue = [[_wineUtils wineRegionsForCountry:country] objectAtIndex:0];
			}
			else{
				selectedValue = [_wineUtils.wineTypes objectAtIndex:0];
			}
	}
	
	[userInfo setObject:selectedValue forKey:@"value"];
	if(self.pickerType == CTYear)
		[userInfo setObject:@"year" forKey:@"type"];
	else if(self.pickerType == CTRegion)
		[userInfo setObject:@"region" forKey:@"type"];
	else
		[userInfo setObject:@"type" forKey:@"type"];
	
	NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"CVDonePressed" object:self userInfo:userInfo];

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.pickerType){
        case CTYear:
					return [self.wineUtils.wineYears objectAtIndex:(NSUInteger) row];
        case CTRegion: {
					if(component == 0){
						NSString *country = [[self.wineUtils wineCountries] objectAtIndex:(NSUInteger)row];
						return country;
					}
					NSArray *regions = [self.wineUtils wineRegionsForCountry:[[self.wineUtils wineCountries] objectAtIndex:(NSUInteger) [pickerView selectedRowInComponent:0]]];
					return [regions objectAtIndex:(NSUInteger) row];
        }
        case CTType:
				return [self.wineUtils.wineTypes objectAtIndex:(NSUInteger) row];
    }

    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
  
	if(self.pickerType == CTRegion){
	 if (component == 0)
		 [pickerView reloadAllComponents];
	 else if(component == 1){
		  NSArray *regions = [self.wineUtils wineRegionsForCountry:[[self.wineUtils wineCountries] objectAtIndex:(NSUInteger) [pickerView selectedRowInComponent:0]]];
			NSString *region = [regions objectAtIndex:(NSUInteger) row];
		 NSLog(@"%@", region);
		 selectedValue = [NSString stringWithString:region];
	 }
	}
	else if(self.pickerType == CTYear){
		selectedValue = [self.wineUtils.wineYears objectAtIndex:(NSUInteger) row];
	}
	else{
		selectedValue = [self.wineUtils.wineTypes objectAtIndex:(NSUInteger) row];
	}
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerType == CTRegion ? COMPONENTS_IN_REGION : COMPONENTS_DEFAULT;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.pickerType){

        case CTYear:
				return [self.wineUtils.wineYears count];
        case CTRegion: {
						
						if(component == 0){
							return [[self.wineUtils wineCountries] count];
						}
					
            NSArray *regions = [self.wineUtils wineRegionsForCountry:[[self.wineUtils wineCountries] objectAtIndex:(NSUInteger) [pickerView selectedRowInComponent:0]]];;
            return regions.count;
        }
        case CTType:
				return [self.wineUtils.wineTypes count];
    }
}

@end
