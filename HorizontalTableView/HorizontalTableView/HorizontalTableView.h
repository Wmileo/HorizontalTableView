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

-(NSInteger)numberOfRows;
-(HorizontalTableViewCell *)horizontalTableView:(HorizontalTableView *)horizontalTableView cellForRow:(NSInteger)row;
-(CGFloat)horizontalTableView:(HorizontalTableView *)horizontalTableView widthForRow:(NSInteger)row;

@end

@protocol HorizontalTableViewDelegate <NSObject, UIScrollViewDelegate>

@optional
-(void)horizontalTableView:(HorizontalTableView *)horizontalTableView willDisplayCell:(HorizontalTableViewCell *)cell forRow:(NSInteger)row;
-(void)horizontalTableView:(HorizontalTableView *)horizontalTableView didEndDisplayCell:(HorizontalTableViewCell *)cell forRow:(NSInteger)row;

@end

@interface HorizontalTableView : UIScrollView

@property (nonatomic, assign) id <HorizontalTableViewDataSourse> dataSource;
@property (nonatomic, assign) id <HorizontalTableViewDelegate> delegate;

-(void)reloadData;

-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

@property (nonatomic, readonly) NSArray<__kindof HorizontalTableViewCell *> *visibleCells;
@property (nonatomic, readonly) NSArray *visibleRowInfos;

@end

@interface NSValue (RowInfo)
+(NSValue *)valueWithRowInfo:(RowInfo)rowInfo;
-(RowInfo)rowInfoValue;
@end

