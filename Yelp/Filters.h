//
//  Filters.h
//  Yelp
//
//  Created by AP Fritts on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject

+(NSInteger)sortMethod;
+(void)setSortMethod:(NSInteger)sortMethod;

+(NSArray *)categories;
+(void)addCategory:(NSSet *)category;
+(BOOL)containsCategory:(NSSet *)category;
+(void)removeCategory:(NSSet *)category;

+(NSDictionary *)filter;
+(void)reset;

+(NSArray *)allCategories;
+(NSArray *)allSortOrders;

@end
