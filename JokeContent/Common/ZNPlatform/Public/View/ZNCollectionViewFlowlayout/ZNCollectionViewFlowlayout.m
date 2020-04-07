//
//  ZNCollectionViewFlowlayout.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/19.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNCollectionViewFlowlayout.h"

@implementation ZNCollectionViewFlowlayout

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray<UICollectionViewLayoutAttributes *> * attrsArray = [super layoutAttributesForElementsInRect:rect];
    
    if (attrsArray.count <= 0) {
        return attrsArray;
    }
    
    if (!self.leftLayout) {
        return attrsArray;
    }
    
   NSInteger section = self.collectionView.numberOfSections;
    NSMutableArray * newArray = [NSMutableArray new];
    for (NSInteger i = 0; i < section ; i++) {
        NSMutableArray * sectionArray = [NSMutableArray new];
        for (UICollectionViewLayoutAttributes * attr in attrsArray) {
            if (attr.indexPath.section == i) {
                NSLog(@"%@",attr.representedElementKind);
                if (attr.representedElementKind == nil) {
                    //该属性为空时，该视图为cell
                    [sectionArray addObject:attr];
                }else{
                    [newArray addObject:attr];
                }
            }
        }
        if (sectionArray.count > 0) {
            [newArray addObjectsFromArray:[self sectionCellAttrWithCellAtt:sectionArray]];
        }
    }
    return [newArray copy];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)sectionCellAttrWithCellAtt:(NSArray<UICollectionViewLayoutAttributes *> *) attrsArray{
    CGRect rect = attrsArray[0].frame;
    attrsArray[0].frame = CGRectMake(zn_AutoWidth(15), rect.origin.y, rect.size.width, rect.size.height);
    CGFloat originX = attrsArray[0].frame.origin.x;
    
    CGFloat width = 0;
    for (int i = 0; i < attrsArray.count - 1; i ++) {
            UICollectionViewLayoutAttributes * curBute = attrsArray[i];
            UICollectionViewLayoutAttributes * nextBute = attrsArray[i + 1];
        
        if (width == 0) {
            width = curBute.frame.origin.x + curBute.frame.size.width;
        }
        
        width = width + self.minimumInteritemSpacing + nextBute.frame.size.width;
        
        CGFloat x = curBute.frame.origin.x + curBute.frame.size.width + self.minimumInteritemSpacing;
        
        CGFloat nextLineY = curBute.frame.origin.y + curBute.frame.size.height + self.minimumLineSpacing;
        
        if (width >= (self.collectionView.width - zn_AutoWidth(30))) {
            width = 0;
            nextBute.frame = CGRectMake(originX, nextLineY, nextBute.frame.size.width, nextBute.frame.size.height);
        }else{
            nextBute.frame = CGRectMake(x, curBute.frame.origin.y, nextBute.frame.size.width, nextBute.frame.size.height);
        }
    }
    return attrsArray;
}

@end
