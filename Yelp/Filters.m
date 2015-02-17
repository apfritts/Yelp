//
//  Filters.m
//  Yelp
//
//  Created by AP Fritts on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Filters.h"

@implementation Filters

static NSNumber *__sortMethod = nil;
static NSMutableArray *__categories = nil;

+(NSInteger)sortMethod {
    [Filters init];

    return [__sortMethod integerValue];
}

+(void)setSortMethod:(NSInteger)sortMethod {
    __sortMethod = [NSNumber numberWithInteger:sortMethod];
}

+(NSArray *)categories {
    [Filters init];
    
    return [__categories copy];
}

+(void)addCategory:(NSSet *)category {
    [Filters init];
    
    [__categories addObject:category];
}

+(BOOL)containsCategory:(NSSet *)category {
    [Filters init];
    
    return [__categories containsObject:category];
}

+(void)removeCategory:(NSSet *)category {
    [Filters init];
    
    [__categories removeObject:category];
}

+(NSDictionary *)filter {
    [Filters init];

    NSMutableArray *filterCodes = [NSMutableArray array];
    for (NSDictionary *category in __categories) {
        [filterCodes addObject:category[@"code"]];
    }
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    [filters setObject:[filterCodes componentsJoinedByString:@","] forKey:@"category_filter"];
    [filters setObject:[NSString stringWithFormat:@"%@", __sortMethod] forKey:@"sort"];
    return filters;
}

+(void)reset {
    __categories = [NSMutableArray array];
    __sortMethod = [NSNumber numberWithInt:0];
}

+(void)init {
    if (__categories == nil) {
        __categories = [NSMutableArray array];
    }
    if (__sortMethod == nil) {
        __sortMethod = [NSNumber numberWithInt:0];
    }
}

+(NSArray *)allSortOrders {
    return
    @[
      @"Best Match",
      @"Distance",
      @"Highest Rated"
      ];
}

+(NSArray *)allCategories {
    return @[
             @{@"name": @"Afghan", @"code": @"afghani"},
             @{@"name": @"African", @"code": @"african"},
             @{@"name": @"American (New)", @"code": @"newamerican"},
             @{@"name": @"American (Traditional)", @"code": @"tradamerican"},
             @{@"name": @"Arabian", @"code": @"arabian"},
             @{@"name": @"Argentine", @"code": @"argentine"},
             @{@"name": @"Armenian", @"code": @"armenian"},
             @{@"name": @"Asian Fusion", @"code": @"asianfusion"},
             @{@"name": @"Australian", @"code": @"australian"},
             @{@"name": @"Austrian", @"code": @"austrian"},
             @{@"name": @"Bangladeshi", @"code": @"bangladeshi"},
             @{@"name": @"Barbeque", @"code": @"bbq"},
             @{@"name": @"Basque", @"code": @"basque"},
             @{@"name": @"Belgian", @"code": @"belgian"},
             @{@"name": @"Brasseries", @"code": @"brasseries"},
             @{@"name": @"Brazilian", @"code": @"brazilian"},
             @{@"name": @"Breakfast & Brunch", @"code": @"breakfast_brunch"},
             @{@"name": @"British", @"code": @"british"},
             @{@"name": @"Buffets", @"code": @"buffets"},
             @{@"name": @"Burgers", @"code": @"burgers"},
             @{@"name": @"Burmese", @"code": @"burmese"},
             @{@"name": @"Cafes", @"code": @"cafes"},
             @{@"name": @"Cafeteria", @"code": @"cafeteria"},
             @{@"name": @"Cajun/Creole", @"code": @"cajun"},
             @{@"name": @"Cambodian", @"code": @"cambodian"},
             @{@"name": @"Caribbean", @"code": @"caribbean"},
             @{@"name": @"Catalan", @"code": @"catalan"},
             @{@"name": @"Cheesesteaks", @"code": @"cheesesteaks"},
             @{@"name": @"Chicken Shop", @"code": @"chickenshop"},
             @{@"name": @"Chicken Wings", @"code": @"chicken_wings"},
             @{@"name": @"Chinese", @"code": @"chinese"},
             @{@"name": @"Comfort Food", @"code": @"comfortfood"},
             @{@"name": @"Creperies", @"code": @"creperies"},
             @{@"name": @"Cuban", @"code": @"cuban"},
             @{@"name": @"Czech", @"code": @"czech"},
             @{@"name": @"Delis", @"code": @"delis"},
             @{@"name": @"Diners", @"code": @"diners"},
             @{@"name": @"Ethiopian", @"code": @"ethiopian"},
             @{@"name": @"Fast Food", @"code": @"hotdogs"},
             @{@"name": @"Filipino", @"code": @"filipino"},
             @{@"name": @"Fish & Chips", @"code": @"fishnchips"},
             @{@"name": @"Fondue", @"code": @"fondue"},
             @{@"name": @"Food Court", @"code": @"food_court"},
             @{@"name": @"Food Stands", @"code": @"foodstands"},
             @{@"name": @"French", @"code": @"french"},
             @{@"name": @"Gastropubs", @"code": @"gastropubs"},
             @{@"name": @"German", @"code": @"german"},
             @{@"name": @"Gluten-Free", @"code": @"gluten_free"},
             @{@"name": @"Greek", @"code": @"greek"},
             @{@"name": @"Halal", @"code": @"halal"},
             @{@"name": @"Hawaiian", @"code": @"hawaiian"},
             @{@"name": @"Himalayan/Nepalese", @"code": @"himalayan"},
             @{@"name": @"Hot Dogs", @"code": @"hotdog"},
             @{@"name": @"Hot Pot", @"code": @"hotpot"},
             @{@"name": @"Hungarian", @"code": @"hungarian"},
             @{@"name": @"Iberian", @"code": @"iberian"},
             @{@"name": @"Indian", @"code": @"indpak"},
             @{@"name": @"Indonesian", @"code": @"indonesian"},
             @{@"name": @"Irish", @"code": @"irish"},
             @{@"name": @"Italian", @"code": @"italian"},
             @{@"name": @"Japanese", @"code": @"japanese"},
             @{@"name": @"Korean", @"code": @"korean"},
             @{@"name": @"Kosher", @"code": @"kosher"},
             @{@"name": @"Laotian", @"code": @"laotian"},
             @{@"name": @"Latin American", @"code": @"latin"},
             @{@"name": @"Live/Raw Food", @"code": @"raw_food"},
             @{@"name": @"Malaysian", @"code": @"malaysian"},
             @{@"name": @"Mediterranean", @"code": @"mediterranean"},
             @{@"name": @"Falafel", @"code": @"falafel"},
             @{@"name": @"Mexican", @"code": @"mexican"},
             @{@"name": @"Middle Eastern", @"code": @"mideastern"},
             @{@"name": @"Modern European", @"code": @"modern_european"},
             @{@"name": @"Mongolian", @"code": @"mongolian"},
             @{@"name": @"Moroccan", @"code": @"moroccan"},
             @{@"name": @"Pakistani", @"code": @"pakistani"},
             @{@"name": @"Persian/Iranian", @"code": @"persian"},
             @{@"name": @"Peruvian", @"code": @"peruvian"},
             @{@"name": @"Pizza", @"code": @"pizza"},
             @{@"name": @"Polish", @"code": @"polish"},
             @{@"name": @"Portuguese", @"code": @"portuguese"},
             @{@"name": @"Poutineries", @"code": @"poutineries"},
             @{@"name": @"Russian", @"code": @"russian"},
             @{@"name": @"Salad", @"code": @"salad"},
             @{@"name": @"Sandwiches", @"code": @"sandwiches"},
             @{@"name": @"Scandinavian", @"code": @"scandinavian"},
             @{@"name": @"Scottish", @"code": @"scottish"},
             @{@"name": @"Seafood", @"code": @"seafood"},
             @{@"name": @"Singaporean", @"code": @"singaporean"},
             @{@"name": @"Slovakian", @"code": @"slovakian"},
             @{@"name": @"Soul Food", @"code": @"soulfood"},
             @{@"name": @"Soup", @"code": @"soup"},
             @{@"name": @"Southern", @"code": @"southern"},
             @{@"name": @"Spanish", @"code": @"spanish"},
             @{@"name": @"Sri Lankan", @"code": @"srilankan"},
             @{@"name": @"Steakhouses", @"code": @"steak"},
             @{@"name": @"Sushi Bars", @"code": @"sushi"},
             @{@"name": @"Taiwanese", @"code": @"taiwanese"},
             @{@"name": @"Tapas Bars", @"code": @"tapas"},
             @{@"name": @"Tapas/Small Plates", @"code": @"tapasmallplates"},
             @{@"name": @"Tex-Mex", @"code": @"tex-mex"},
             @{@"name": @"Thai", @"code": @"thai"},
             @{@"name": @"Turkish", @"code": @"turkish"},
             @{@"name": @"Ukrainian", @"code": @"ukrainian"},
             @{@"name": @"Uzbek", @"code": @"uzbek"},
             @{@"name": @"Vegan", @"code": @"vegan"},
             @{@"name": @"Vegetarian", @"code": @"vegetarian"},
             @{@"name": @"Vietnamese", @"code": @"vietnamese"}
             ];
}

@end
