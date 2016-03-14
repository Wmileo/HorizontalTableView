//
//  HorizontalTableViewCell.h
//  HorizontalTableView
//
//  Created by ileo on 16/3/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalTableViewCell : UIView

@property (nonatomic, copy) NSString *reuseIdentifier;

@property (nonatomic, assign) NSInteger row;

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
-(void)prepareForReuse;

@end
