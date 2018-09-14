//
//  RZSort.m
//  RZBaseProject
//
//  Created by os on 2018/8/22.
//  Copyright © 2018年 RZOL. All rights reserved.
//

#import "RZSort.h"
#import "NSDate+Extension.h"

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   RZLog(@"Time: %f", -[startTime timeIntervalSinceNow])

@implementation RZSort

#pragma mark - 冒泡排序
/*
 冒泡排序（从小到大）
 如果是从小到大排序，则每轮比较完成，本轮最后发生交换的坐标之前的元素都是有序的，后面的不一定是有序的，所以记录下最后交换的坐标
 */
+ (NSArray *)bubbleSort:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    NSInteger right = mArr.count-1;
    NSInteger temp = 0;
    for (NSInteger i = 0; i < mArr.count-1; i++) {
        BOOL flag = true;// 记录本轮比较是否发生交换
        for (NSInteger j = 0; j < right; j++) {
            if (mArr[j] > mArr[j+1]) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = false;
                temp = j;
            }
        }
        right = temp;
        // 如果本轮未发生交换，说明数组已经是有序数组，直接终止排序，节省时间，增加效率
        if (flag) {break;}
    }
    TOCK;
    return mArr;
}

#pragma mark - 选择排序

/*
 思路：
 首先在未排序序列中找到最小（大）元素，存放到排序序列的起始位置
 再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。
 重复第二步，直到所有元素均排序完毕。
 
 + (NSArray *)selectionSort:(NSArray *)array {
 NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
 TICK;
 for (NSInteger i = 0; i < mArr.count-1; i++) {
 NSInteger mix = i;
 for (NSInteger j = i+1; j < mArr.count; j++) {
 if (mArr[mix] > mArr[j]) {
 mix = j;
 }
 }
 [mArr exchangeObjectAtIndex:i withObjectAtIndex:mix];
 }
 TOCK;
 return mArr;
 }
 */
+ (NSArray *)selectionSort:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    NSInteger left = 0;
    NSInteger right = mArr.count-1;
    while (left < right) {
        NSInteger mix = left;
        NSInteger max = left;
        for (NSInteger j = left+1; j <= right; j++) {
            if (mArr[mix] > mArr[j]) {
                mix = j;
            }
            if (mArr[max] < mArr[j]) {
                max = j;
            }
        }

        if (mix != left) {
            [mArr exchangeObjectAtIndex:left withObjectAtIndex:mix];
        }
        if (max == left) {
            max = mix;
        }
        if (max != right) {
            [mArr exchangeObjectAtIndex:right withObjectAtIndex:max];
        }

        left++;
        right--;
    }
    TOCK;
    return mArr;
}

#pragma mark - 插入排序
/*
 思路：将数组的第一个元素当做有序数列，第二个到最后一个都是未排序的数列，遍历未排序数列，将扫描到每一个元素依次插入到有序数列中
 */

+ (NSArray *)insertionSort:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    for (NSInteger i = 1; i < mArr.count; i++) {
        for (NSInteger j = 0; j < i; j++) {
            if (mArr[i] < mArr[j]) {
                [mArr exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    TOCK;
    return mArr;
}

#pragma mark - 快速排序
/*
 思路：
 选取一个关键字(key)作为枢轴，一般取整组记录的第一个数/最后一个，这里采用选取序列第一个数为枢轴。
 设置两个变量left = 0;right = N - 1;
 从right一直向前走，直到找到一个小于key的值，left从前往后，直至找到一个大于key的值，然后交换这两个数。
 重复第三步，一直往后找，直到left和right相遇，这时将key放置left的位置即可。
 
 然后把数组分成左右两组，再分别用这个方法排序
 */
+ (NSArray *)quickSork:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    [RZSort indenticalQuickSort:mArr indexL:0 indexR:mArr.count-1];
    TOCK;
    return mArr;
}
+ (void)indenticalQuickSort:(NSMutableArray *)mArr indexL:(NSInteger)l indexR:(NSInteger)r {
    if (l >= r) return;
    NSInteger p = [RZSort partition:mArr indexL:l indexR:r];
    [RZSort indenticalQuickSort:mArr indexL:l indexR:p-1];
    [RZSort indenticalQuickSort:mArr indexL:p+1 indexR:r];
}
+ (NSInteger)partition:(NSMutableArray *)mArr indexL:(NSInteger)l indexR:(NSInteger)r {
    NSInteger t = l;
    while (l < r) {
        while (mArr[r] >= mArr[t] && l < r) {
            r--;
        }
        while (mArr[l] <= mArr[t] && l < r) {
            l++;
        }
        if (l < r) {
            [mArr exchangeObjectAtIndex:l withObjectAtIndex:r];
        }
    }
    [mArr exchangeObjectAtIndex:t withObjectAtIndex:l];
    return l;
}



@end
