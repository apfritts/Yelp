//
//  PriceCell.h
//  Yelp
//
//  Created by AP Fritts on 2/17/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PriceCell;

@protocol PriceCellDelegate <NSObject>

-(void)priceCell:(PriceCell *)priceCell togglePrice:(NSString *)price on:(BOOL)on;

@end

@interface PriceCell : UITableViewCell

@end
