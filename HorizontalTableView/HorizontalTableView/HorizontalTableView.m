//
//  HorizontalTableView.m
//  HorizontalTableView
//
//  Created by ileo on 16/3/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "HorizontalTableView.h"

@interface HorizontalTableView()

@property (nonatomic, strong) NSMutableDictionary *reUsedCells;
@property (nonatomic, strong) NSMutableArray<__kindof HorizontalTableViewCell *> *currentVisibleCells;
@property (nonatomic, copy) NSArray *currentVisibleRowInfos;

@property (nonatomic, assign) CGFloat maxWidth;

@end

@implementation HorizontalTableView

@dynamic delegate;

-(void)reloadData{
    for (UIView *view in self.currentVisibleCells) {
        [view removeFromSuperview];
    }
    [self.currentVisibleCells removeAllObjects];
    self.currentVisibleRowInfos = nil;
    [self setNeedsDisplay];
}

#pragma mark -

-(void)addCellWithRowInfo:(RowInfo)rowInfo{
    if (self.dataSource) {
        HorizontalTableViewCell *cell = [self.dataSource horizontalTableView:self cellForRow:rowInfo.row];
        cell.frame = CGRectMake(rowInfo.left, 0, rowInfo.width, self.frame.size.height);
        cell.row = rowInfo.row;
        [self addSubview:cell];
        [self.currentVisibleCells addObject:cell];
    }
}

#pragma mark - layout
-(void)layoutSubviews{
    [super layoutSubviews];
    [self checkVisibleRowInfosWhenMove];
}

-(void)checkVisibleRowInfosWhenMove{
    if (self.dataSource) {
        
        RowInfo leftRowInfo = [self.currentVisibleRowInfos.firstObject rowInfoValue];
        RowInfo rightRowInfo = [self.currentVisibleRowInfos.lastObject rowInfoValue];
        CGFloat screenLeft = self.contentOffset.x;
        CGFloat screenRight = self.contentOffset.x + self.frame.size.width;
        if (screenLeft < leftRowInfo.left ||
            screenLeft >= leftRowInfo.right ||
            screenRight > rightRowInfo.right ||
            screenRight <= rightRowInfo.left) {
            
            NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.currentVisibleRowInfos];
            NSArray *cells = [self.currentVisibleCells copy];
            
            NSInteger num = [self.dataSource numberOfRows];
            CGFloat width = 0;
            NSMutableArray *rowInfos = [NSMutableArray arrayWithCapacity:10];
            for (int i = 0; i < num; i++) {
                CGFloat left = width;
                CGFloat cellWidth = [self.dataSource horizontalTableView:self widthForRow:i];
                CGFloat right = width + cellWidth;
                width += cellWidth;
                if ((left >= screenLeft &&
                    left < screenRight) ||
                    (right > screenLeft &&
                    right <= screenRight)) {
                        
                    RowInfo row = RowInfoMake(i, left, width, cellWidth);
                    [rowInfos addObject:[NSValue valueWithRowInfo:row]];
                    NSArray *remain = [tmp copy];
                    BOOL hasRowInfo = NO;
                    for (NSValue *value in remain) {
                        RowInfo rowInfo = [value rowInfoValue];
                        if (rowInfo.row == i) {
                            hasRowInfo = YES;
                            [tmp removeObject:value];
                            break;
                        }
                    }
                    //加载新cell
                    if (!hasRowInfo) {
                        [self addCellWithRowInfo:row];
                    }

                }
            }
            
            self.maxWidth = width;
            self.contentSize = CGSizeMake(width, CGRectGetHeight(self.frame));
            
            //移除屏幕外的cell
            for (HorizontalTableViewCell *cell in cells) {
                for (NSValue *value in tmp) {
                    RowInfo row = [value rowInfoValue];
                    if (row.row == cell.row) {
                        [cell removeFromSuperview];
                        [self.currentVisibleCells removeObject:cell];
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.reUsedCells[cell.reuseIdentifier]];
                        [arr addObject:cell];
                        self.reUsedCells[cell.reuseIdentifier] = arr;
                    }
                }
            }
            
            self.currentVisibleRowInfos = [rowInfos copy];
        }
        
    }
}

#pragma mark - readonly

-(NSArray<HorizontalTableViewCell *> *)visibleCells{
    return self.currentVisibleCells;
}

-(NSArray *)visibleRowInfos{
    return self.currentVisibleRowInfos;
}

#pragma mark - 重用
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.reUsedCells[identifier]];
    if (arr.count > 0) {
        HorizontalTableViewCell *cell = arr.firstObject;
        [arr removeObject:cell];
        self.reUsedCells[cell.reuseIdentifier] = arr;
        return cell;
    }
    return nil;
}

#pragma mark - set get
-(NSMutableArray<HorizontalTableViewCell *> *)currentVisibleCells{
    if (!_currentVisibleCells) {
        _currentVisibleCells = [NSMutableArray arrayWithCapacity:5];
    }
    return _currentVisibleCells;
}
-(NSMutableDictionary *)reUsedCells{
    if (!_reUsedCells) {
        _reUsedCells = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    return _reUsedCells;
}

@end

@implementation NSValue (RowInfo)
+(NSValue *)valueWithRowInfo:(RowInfo)rowInfo{
    return [NSValue valueWithBytes:&rowInfo objCType:@encode(RowInfo)];
}
-(RowInfo)rowInfoValue{
    RowInfo rowInfo;
    [self getValue:&rowInfo];
    return rowInfo;
}
@end
