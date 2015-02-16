//
//  HeaderView.m
//  Yelp
//
//  Created by AP Fritts on 2/15/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView()

@property (nonatomic, strong) UILabel *title;

@end

@implementation HeaderView

-(instancetype)init {
    self = [super init];
    if (self) {
        CGSize size = [[UIScreen mainScreen] bounds].size;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(4, 4, size.width - 8, 22)];
        //NSLayoutConstraint *constraint = [[NSLayoutConstraint alloc] init];
    }
    return self;
}

-(CGSize)intrinsicContentSize {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 30);
}

-(instancetype)initWithTitle:(NSString *)title {
    self = [self init];
    if (self.title) {
        self.title.text = title;
    }
    return self;
}

-(void)setLabelTitle:(NSString *)title {
    self.title.text = title;
}

@end
