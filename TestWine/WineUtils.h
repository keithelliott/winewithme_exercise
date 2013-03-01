//
// Created by keithelliott on 1/25/13.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


static int const CURRENT_YEAR = 2013;

static int const MAX_YEARS = 20;

@interface WineUtils : NSObject
@property(nonatomic, strong) NSDictionary *wineRegionsDict;
@property (nonatomic, strong) NSArray *wineTypes;
@property (nonatomic, strong) NSArray *wineYears;

- (NSArray *)wineRegionsForCountry:(NSString *)country;
- (NSArray *)wineCountries;
- (NSString *)regionForCountry:(NSString *)country;

@end