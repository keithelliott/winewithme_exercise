//
// Created by keithelliott on 1/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "WineUtils.h"


@implementation WineUtils {
}
@synthesize wineRegionsDict;
@synthesize wineTypes;
@synthesize wineYears;

- (id)init {
    self = [super init];
    if (self){
        [self buildWineRegions];
				wineTypes = @[@"Red", @"Rose", @"White"];
			[self buildWineYears];
    }

    return self;
}

- (NSArray *)wineRegionsForCountry:(NSString *)country {
    return [wineRegionsDict objectForKey:country];
}

- (NSArray *)wineCountries {
    return [wineRegionsDict allKeys];
}



-(void)buildWineRegions{
    if (wineRegionsDict == nil){
        wineRegionsDict = @{
                @"Africa" : @[@"Algeria", @"Cape_Verde", @"Morocco" , @"South_Africa", @"Tunisia"],
                @"Americas" : @[@"Argentina", @"Bolivia", @"Brazil", @"Canada", @"Chile", @"Mexico", @"Peru", @"United_States", @"Uruguay", @"Venezuela"],
                @"Europe" : @[@"Austria", @"Armenia",@"Azerbaijan", @"Belgium",@"Bulgaria", @"Croatia", @"Cyprus", @"Czech_Republic",@"Denmark", @"France",@"Georgia",
                        @"Germany", @"Greece", @"Hungary", @"Ireland", @"Italy", @"Luxembourg", @"Macedonia", @"Moldova",
                        @"Montenegro", @"Netherlands", @"Poland", @"Portugal", @"Romania", @"Russia", @"Serbia", @"Slovakia",
                        @"Slovenia",@"Spain",@"Sweden", @"Switzerland", @"Turkey",@"Ukraine", @"United_Kingdom"],
                @"Asia" : @[@"China",@"India", @"Indonesia", @"Iran", @"Israel", @"Japan", @"Kazakhstan",@"Republic_of_Korea",
                        @"Lebanon",@"Burma", @"Palestinian_territories",@"Syria",@"Vietnam"],
                @"Oceania" : @[@"Australia", @"New_Zealand"]
        };
    }
}

-(void)buildWineYears{
	NSMutableArray *yrs = [[NSMutableArray alloc] initWithCapacity:MAX_YEARS];
	int year = CURRENT_YEAR;
	for(int i = 0; i < MAX_YEARS; i++){
		NSString *yrNum = [NSString stringWithFormat:@"%d", year - i];
		[yrs addObject:yrNum];
	}
	
	wineYears = [[NSArray alloc] initWithArray:yrs];
}

-(NSString *)regionForCountry:(NSString *)country{
	NSArray *regions = [wineRegionsDict allKeys];
	for(NSUInteger i = 0; i < regions.count; i++){
		NSString *key = (NSString *)[regions objectAtIndex:i];
		NSArray *countries = [wineRegionsDict objectForKey:key];
		for(NSUInteger x = 0; x < countries.count; x++){
			 NSString *testCountry = [countries objectAtIndex:x];
			 if([country isEqualToString:testCountry])
				 return [regions objectAtIndex:i];
		}
	}
	
	return nil;
}

@end