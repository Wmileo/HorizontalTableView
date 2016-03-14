//
//  HorizontalTableViewCell.m
//  HorizontalTableView
//
//  Created by ileo on 16/3/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "HorizontalTableViewCell.h"

@implementation HorizontalTableViewCell

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super init];
    if (self) {
        self.reuseIdentifier = reuseIdentifier;
    }
    return self;
}

-(NSString *)reuseIdentifier{
    if (!_reuseIdentifier) {
        return @"";
    }
    return _reuseIdentifier;
}

-(void)prepareForReuse{

}

@end
