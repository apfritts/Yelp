//
//  Business.m
//  Yelp
//
//  Created by AP Fritts on 2/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        @try {
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj count] > 0) {
                [categoryNames addObject:obj[0]];
            }
        }];
        [self setCategories:[categoryNames componentsJoinedByString:@", "]];

        [self setName:dictionary[@"name"]];
        [self setImageUrl:dictionary[@"image_url"]];
        NSString *street = [dictionary valueForKeyPath:@"location.address"][0];
        NSString *neighborhood = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
        [self setAddress:[NSString stringWithFormat:@"%@, %@", street, neighborhood]];
        [self setNumReviews:[dictionary[@"review_count"] integerValue]];
        [self setRatingImageUrl:dictionary[@"rating_img_url"]];
        float milesPerMeter = 0.000621371;
        [self setDistance:[dictionary[@"distance"] integerValue] * milesPerMeter];
        }
        @catch (NSException *e) {
            NSLog(@"EXCEPTION FOR OBJECT:\n%@\n\n%@", dictionary, e);
        }
    }
    return self;
}

+(NSArray *)businessesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *businesses = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        [businesses addObject:business];
    }
    return businesses;
}

@end
