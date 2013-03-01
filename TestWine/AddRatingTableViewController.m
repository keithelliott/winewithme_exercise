//
//  AddRatingTableViewController.m
//  TestWine
//
//  Created by Keith Elliott on 2/28/13.
//  Copyright (c) 2013 Keith Elliott. All rights reserved.
//

#import "AddRatingTableViewController.h"
#import "Wine.h"
#import "AppDelegate.h"
#import "ChooserViewController.h"

@interface AddRatingTableViewController ()

@end

@implementation AddRatingTableViewController
@synthesize managedObjectContext;
@synthesize chooser;

- (id)initWithStyle:(UITableViewStyle)style
{
	self = [super initWithStyle:style];
	if (self) {
			// Custom initialization
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) closeOpenView{
	for(UIView *view in self.view.subviews){
		if(view.tag == CHOOSER_VIEW)
			[view removeFromSuperview];
		else{
			UITextField *tf = (UITextField *)[view viewWithTag:TEXTFIELD];
			[tf resignFirstResponder];
		}
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	return [textField resignFirstResponder];
}

- (id)getChooserView:(ChooserUIType)type {
	return [[ChooserViewController alloc] initWithPickerType:type];
}

-(void)displayChooserViewWithType:(ChooserUIType)type{
	chooser = [self getChooserView:type];
	[self.view addSubview:[chooser view]];
	[chooser view].tag = CHOOSER_VIEW;
	
	float chooser_height = [[chooser view] frame].size.height;
	float chooser_width = [[chooser view] frame].size.width;
	float view_bottom = [self view].frame.size.height;
	
	[chooser view].frame = CGRectMake([[self view] frame].origin.x, view_bottom + chooser_height,chooser_width , chooser_height);
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[chooser view].frame =  CGRectMake([self view].frame.origin.x, view_bottom - chooser_height, chooser_width, chooser_height);
	[UIView commitAnimations];
}

#pragma mark - IBAction Methods

- (IBAction)ratingChanged:(id)sender {
	UIButton *btn = (UIButton *)sender;
	int rating = btn.tag;
	
	if(rating == HIGHEST_RATING){
		btn.tag = LOWEST_RATING;
	}
	else{
		btn.tag = rating + 1;
	}
	
	NSString *img = [NSString stringWithFormat:@"ratings_%d.png",btn.tag];
	[btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
}

- (IBAction)addRating:(id)sender {
	self.managedObjectContext =  [(AppDelegate*)[UIApplication sharedApplication].delegate managedObjectContext];
	
	Wine *wine = (Wine*)[NSEntityDescription insertNewObjectForEntityForName:@"Wine" inManagedObjectContext:self.managedObjectContext];
	
	if([self.name.text isEqualToString:@""] || [self.regionBtn.titleLabel.text isEqualToString:@"Region"] || [self.yearBtn.titleLabel.text isEqualToString:@"Year"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can't Save Rating" message:@"Missing Values" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
	
	else{
		wine.name = self.name.text;
		wine.rating = [NSNumber numberWithInt:self.ratingsBtn.tag];
		wine.region = self.regionBtn.titleLabel.text;
		wine.type = self.typeBtn.titleLabel.text;
		wine.year = self.yearBtn.titleLabel.text;
		
		NSError *error = nil;
		if(![self.managedObjectContext save:&error]){
			NSLog(@"There was an error");
		}
		
		[self.navigationController popViewControllerAnimated:YES];
	}
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	[self closeOpenView];
	return YES;
}

- (IBAction)typeChanged:(id)sender {
	[self closeOpenView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"CVDonePressed" object:nil];
	
	[self displayChooserViewWithType:CTType];
}

- (IBAction)regionPressed:(id)sender {
	[self closeOpenView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:)
																							 name:@"CVDonePressed" object:nil];
	
	[self displayChooserViewWithType:CTRegion];
}

- (IBAction)yearPressed:(id)sender {
	[self closeOpenView];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:)
																							 name:@"CVDonePressed" object:nil];
	
	[self displayChooserViewWithType:CTYear];
	
}


#pragma mark - Handle Notification
- (void) handleNotification:(NSNotification *) notification
{
	if ([[notification name] isEqualToString:@"CVDonePressed"]){
		NSDictionary* userInfo = [notification userInfo];
		NSString *selectedValue = (NSString *)[userInfo objectForKey:@"value"];
		NSString *type = (NSString *)[userInfo objectForKey:@"type"];
		
		if(selectedValue != nil && ![selectedValue isEqualToString:@""]){
			if([type isEqualToString:@"region"])
				[self.regionBtn setTitle:selectedValue forState:UIControlStateNormal];
			else if([type isEqualToString:@"year"])
				[self.yearBtn setTitle:selectedValue forState:UIControlStateNormal];
			else{
				[self.typeBtn setTitle:selectedValue forState:UIControlStateNormal];
				
				if([selectedValue isEqualToString:@"Red"])
					[self.typeBtn setImage:[UIImage imageNamed:@"RedWine-small.png"] forState:UIControlStateNormal];
				else if([selectedValue isEqualToString:@"Rose"])
					[self.typeBtn setImage:[UIImage imageNamed:@"RoseWine-small.png"] forState:UIControlStateNormal];
				else
					[self.typeBtn setImage:[UIImage imageNamed:@"WhiteWine-small.png"] forState:UIControlStateNormal];
			}
			[[NSNotificationCenter defaultCenter] removeObserver:self];
		}
		UIView *chooserView = [[self view] viewWithTag:CHOOSER_VIEW];
		
		float chooser_height = [chooserView frame].size.height;
		float chooser_width = [chooserView frame].size.width;
		float view_bottom = [self view].frame.size.height;
		
		[UIView beginAnimations: nil context: NULL];
		[UIView setAnimationDuration: 0.25];
		[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
		chooserView.frame = CGRectMake([[self view] frame].origin.x, view_bottom + chooser_height,chooser_width , chooser_height);
		[UIView commitAnimations];
		
		[chooserView removeFromSuperview];
	}
}
@end
