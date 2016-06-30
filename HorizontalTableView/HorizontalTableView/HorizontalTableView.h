//
//  HorizontalTableView.h
//  HorizontalTableView
//
//  Created by ileo on 16/3/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalTableViewCell.h"

typedef struct {
    NSInteger row;
    CGFloat left;
    CGFloat right;
    CGFloat width;
} RowInfo;
#define RowInfoMake(row,left,right,width) ((RowInfo){row,left,right,width})

@class HorizontalTableView;

@protocol HorizontalTableViewDataSourse <NSObject>

-(NSInteger)numberOfRowsWithHorizontalTableView:(HorizontalTableView *)horizontalTableView;
-(HorizontalTableViewCell *)horizontalTableView:(HorizontalTableView *)horizontalTableView cellForRow:(NSInteger)row;
-(CGFloat)horizontalTableView:(HorizontalTableView *)horizontalTableView widthForRow:(NSInteger)row;

@optional
-(void)horizontalTableView:(HorizontalTableView *)horizontalTableView displayCells:(NSArray *)cells;

@end

@interface HorizontalTableView : UIScrollView

@property (nonatomic, assign) id <HorizontalTableViewDataSourse> dataSource;

-(void)reloadData;

-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@property (nonatomic, readonly) NSArray<__kindof HorizontalTableViewCell *> *visibleCells;
@property (nonatomic, readonly) NSArray *visibleRowInfos;

-(void)displayRow:(NSInteger)row animation:(BOOL)animation;

@end

@interface NSValue (RowInfo)
+(NSValue *)valueWithRowInfo:(RowInfo)rowInfo;
-(RowInfo)rowInfoValue;
@end

