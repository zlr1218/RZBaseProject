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

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

#pragma mark - 冒泡排序
/*
 冒泡排序（从小到大）
 如果是从小到大排序，则每轮比较完成，本轮最后发生交换的坐标之前的元素都是有序的，后面的不一定是有序的，所以记录下最后交换的坐标
 */
+ (NSArray *)bubbleSort1:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    for (NSInteger i = 0; i < mArr.count-1; i++) {
        // 两两比较，从0开始，到最后是 倒数第二个数（count-2）与最后一个数（count-1）比较,所以，j的最大值应是count-2，（等同于<count-1）
        for (NSInteger j = 0; j < mArr.count-1-i; j++) {
            // 两两比较，确定一个最大或最小值，放在最后
            if ([mArr[j] integerValue] > [mArr[j+1] integerValue]) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    return mArr;
}
+ (NSArray *)bubbleSort2:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    NSInteger right = mArr.count-1;
    for (NSInteger i = 0; i < right; i++) {
        BOOL flag = true;// 记录本轮比较是否发生交换
        for (NSInteger j = 0; j < right-i; j++) {
            if ([mArr[j] integerValue] > [mArr[j+1] integerValue]) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = false;
            }
        }
        // 如果本轮未发生交换，说明数组已经是有序数组，直接终止排序，节省时间，增加效率
        if (flag) {break;}
    }
    TOCK;
    return mArr;
}
+ (NSArray *)bubbleSort3:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    NSInteger pos = 0;
    for (NSInteger i = 0; i < mArr.count-1; i++) {
        BOOL flag = true;// 记录本轮比较是否发生交换
        NSInteger k = mArr.count-1;
        for (NSInteger j = 0; j < k; j++) {
            if ([mArr[j] integerValue] > [mArr[j+1] integerValue]) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag = false;
                pos = j;
            }
        }
        // 记录下最后一次交换的坐标，这个坐标后面的没有交换，就是有序的，就不用排序了
        if (flag) {break;}
        k = pos;
    }
    TOCK;
    return mArr;
}
// 最终优化版本
+ (NSArray *)bubbleSort:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    NSInteger pos_max = 0;
    NSInteger pos_min = mArr.count-1;
    for (NSInteger i = 0; i < mArr.count-1; i++) {
        
        // 双向扫描 从左往右扫描（k_min-->k_max）记录最后一次交换坐标（k_max），从右往左扫描(k_max-->k_min)记录最后一次交换坐标（k_min）
        NSInteger k_min = 0;
        NSInteger k_max = mArr.count-1;
        BOOL flag_max = true;// 记录本轮比较是否发生交换
        for (NSInteger j = k_min; j < k_max; j++) {
            if ([mArr[j] integerValue] > [mArr[j+1] integerValue]) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                flag_max = false;
                pos_max = j;
            }
        }
        // 记录下最后一次交换的坐标，这个坐标后面的没有交换，就是有序的，就不用排序了
        if (flag_max) {break;}
        k_max = pos_max;
        
        BOOL flag_min = true;// 记录本轮比较是否发生交换
        for (NSInteger j = k_max; j > k_min; j--) {
            if ([mArr[j] integerValue] < [mArr[j-1] integerValue]) {
                [mArr exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                flag_min = false;
                pos_min = j;
            }
        }
        // 记录下最后一次交换的坐标，这个坐标后面的没有交换，就是有序的，就不用排序了
        if (flag_min) {break;}
        k_min = pos_min;
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
 
 时间复杂度：O(n^2)
 空间复杂度：O(1)
 排序不稳定：353928 当3与2进行比较时，第一个3与第二个3的相对位置发生了变化，因此不稳定
 */

+ (NSArray *)selectionSort1:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    for (NSInteger i = 0; i < mArr.count-1; i++) {
        NSInteger min = i;
        for (NSInteger j = i+1; j < mArr.count; j++) {
            if (mArr[min] > mArr[j]) {
                min = j;
            }
        }
        [mArr exchangeObjectAtIndex:i withObjectAtIndex:min];
    }
    TOCK;
    return mArr;
}
+ (NSArray *)selectionSort:(NSArray *)array {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:array];
    TICK;
    NSInteger left = 0;
    NSInteger right = mArr.count-1;
    while (left < right) {
        NSInteger mix = left;
        NSInteger max = left;
        for (NSInteger j = left+1; j <= right; j++) {
            if ([mArr[mix] integerValue] > [mArr[j] integerValue]) {
                mix = j;
            }
            if ([mArr[max] integerValue] < [mArr[j] integerValue]) {
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
        
//        NSMutableArray *marr2 = [NSMutableArray array];
//        for (NSInteger i = left; i <= right; i++) {
//            [marr2 addObject:mArr[i]];
//        }
//        RZLog(@"%@", marr2.mj_JSONString);
        
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
    for (NSInteger i = 1; i < mArr.count; i++) {// 无序
        // 拿出待插入元素
        NSNumber *temp = mArr[i];
        // 然后有序序列从右往左扫描，大于temp的元素往右移一位
        NSInteger j;
        for (j = i-1; j >= 0; j--) {// 有序
            if ([mArr[j] integerValue] > [temp integerValue]) {
                // 把较大值往后移一位
                mArr[j+1] = mArr[j];
            } else {
                break;
            }
        }
        // 当比较完所有有序序列的元素或者没有比temp大的时结束，插入元素
        // 这里为什么是j+1？因为以上两中情况中，1、比较完所有元素执行了j--，不满足j>=0，2、不大于temp的元素坐标为j，也就该插入到j元素的后面
        mArr[j+1] = temp;
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
//    NSInteger p = [RZSort partition:mArr indexL:l indexR:r];
    NSInteger p = [RZSort sortByArr:mArr L:l R:r];
    [RZSort indenticalQuickSort:mArr indexL:l indexR:p-1];
    [RZSort indenticalQuickSort:mArr indexL:p+1 indexR:r];
}
+ (NSInteger)partition:(NSMutableArray *)mArr indexL:(NSInteger)l indexR:(NSInteger)r {
    NSInteger t = l;
    while (l < r) {
        while ([mArr[r] integerValue] >= [mArr[t] integerValue] && l < r) {
            r--;
        }
        while ([mArr[l] integerValue] <= [mArr[t] integerValue] && l < r) {
            l++;
        }
        if (l < r) {
            [mArr exchangeObjectAtIndex:l withObjectAtIndex:r];
        }
    }
    [mArr exchangeObjectAtIndex:t withObjectAtIndex:l];
    return l;
}

+ (NSInteger)sortByArr:(NSMutableArray *)mArr L:(NSInteger)l R:(NSInteger)r {
    // 定基准
    NSInteger t = l;
    NSInteger index = t+1;
    // 分区操作：根据基准分区，小于基准的放基准前面，大于基准的放基准后面
    for (NSInteger i = index; i <= r; i++) {
        if ([mArr[i] integerValue] < [mArr[t] integerValue]) {
            // 扫描到比第一个基准小的，放在index位置，第二个放在index+1
            [mArr exchangeObjectAtIndex:i withObjectAtIndex:index];
            index++;
        }
    }
    // 最后一个比基准小的放在了index, 然后执行了一次index++，所以index-1才是最后一个比基准小的元素的位置，交换后达成了基准左侧都比基准小，右侧都比基准大
    [mArr exchangeObjectAtIndex:t withObjectAtIndex:index-1];
    
    return index-1;
}



@end
