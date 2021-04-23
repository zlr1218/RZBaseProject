//
//  RZHomeVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZHomeVC.h"
#import "RZBaseProject-Swift.h"
#import "RZTool.h"
#import <CoreLocation/CoreLocation.h>

#import "RZCityList.h"
#import "RZFoldTableViewController.h"

#import "RZCollectionVC.h"

#import "RZBase64ViewController.h"

#import "UIView+Toast.h"
#import "RZAlertView.h"
#import "RZAlertController.h"
#import "UIView+RZAlert.h"
#import "UIView+RZActivityView.h"

#import "NSString+Size.h"
#import "NSDate+Extension.h"

#import "RZThreadVC.h"
#import "RZDispatchVC.h"
#import "RZGCDVC.h"
#import "RZEmptyVC.h"
#import "RZInterviewController.h"

#import "RZSort.h"

#import "RZUpdateLocationVC.h"

#import "RZBtn.h"

@interface RZHomeVC ()<UITableViewDelegate, UITableViewDataSource, RZAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UIView *HomeHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeTableBottom;

@property (weak, nonatomic) IBOutlet RZBtn *customView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *sortArr;

@end

@implementation RZHomeVC

static NSString *const reCellID = @"HomeCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注意对scrollView及其子控件进行iOS11适配
    kAdjustmentBehavior(self, self.homeTableView);
    
    self.homeTableBottom.constant = kRZTabHeight;
    [self setupTableView];
    
    NSString *htmlString = @"<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">原标题：今日头条不鸣则已，一鸣换人<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\"><strong style=\"font-weight: bold;\">沉寂已久的今日头条不鸣则已，一鸣就是换CEO的消息。<\/strong><\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">根据36氪2月25日报道，今日头条CEO朱文佳将调任至至TikTok负责技术研发相关工作，去年底加入字节跳动的前滴滴高管陈熙（Kevin）或将负责今日头条业务。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">此前，一位接近字节跳动的知情人士对字母榜透露，朱文佳的汇报线目前依旧是张楠，字节跳动想要更换TikTok的负责人已经有一段时间了，&ldquo;字节跳动对之前的负责人瓦妮莎&middot;帕帕斯不满意，只是苦于没有适合的人。&rdquo;<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">关于朱文佳调任的原因，外界众说纷纭，上述知情人士表示，一种说法是今日头条增长遭遇困境，因为做得不好被调任；另一种说法是朱文佳在今日头条待得并不开心，<strong style=\"font-weight: bold;\">此次调任是他的主动选择。<\/strong><\/p>\n<p class=\"detailPic\" style=\"margin: 0px auto 20px; padding: 0px; text-align: justify; text-indent: 28px; font-size: 16px; line-height: 32px; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\"><img style=\"border-width: 0px; display: block; margin: 0px auto; max-width: 100%; height: auto;\" src=\"https:\/\/x0.ifengimg.com\/res\/2021\/FDCB166DB40770D0EED4F7F7ACF2D46AC15281BC_size55_w640_h838.jpeg\" alt=\"朱文佳（图源：今日头条抖音账号）\" \/><\/p>\n<p class=\"picIntro\" style=\"margin: 0px 0px 20px; padding: 0px; text-align: justify; font-size: 14px; line-height: 32px; word-break: break-all; color: #2b2b2b; background-color: #ffffff; font-family: 楷体_gb2312, 楷体;\">朱文佳（图源：今日头条抖音账号）<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">伏笔早已埋下。作为今日头条的CEO，朱文佳在今日头条发文虽然称不上频繁，但基本保证了每月更新的频率，但自从2020年9月25日后，他的今日头条账号便再无更新。与之形成鲜明对比的是，朱文佳在个人抖音账号的动态更新比较频繁。朱文佳在近期的抖音点赞视频中，点赞了包含多位TikTok算法和产品员工的短视频，互动频率明显增加。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">朱文佳的继任者是前不久刚刚从滴滴加入字节跳动的陈熙（Kevin）。公开报道显示，在加入滴滴前，陈熙曾在咨询公司麦肯锡、私募股权投资巨头KKR有多年工作经验，加入滴滴后，参与了滴滴E+轮融资以及滴滴和优步中国的合并且发挥关键作用。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">字节跳动正在进行抖音西瓜火山头条四端联动，去年12月，抖音推出了&ldquo;相关阅读&rdquo;功能，关联今日头条文章详解短视频内容。有报道称，一位接近抖音的人士认为，四端联动需要抖音的资源来支持，如果陈熙负责头条，或许能帮头条争取到更多的内容和运营资源。一位资深的产品经理对字母榜分析道，上述观点显然站不住脚，<strong style=\"font-weight: bold;\">&ldquo;朱文佳之前在抖音负责算法推荐，如果真的是要协调抖音和头条的资源，陈熙怎么可能比朱文佳更合适呢？&rdquo;<\/strong><\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">不过，这次这次调岗显然符合张一鸣的用人风格&mdash;&mdash;根据业务变动，将更适合的人放在需要拓展的重要业务中。朱文佳是技术出身，曾是字节跳动副总裁杨震原在百度期间的重要搭档，以推荐算法见长，此次从业务调整到技术岗位，支持TikTok的技术工作，反而更能发挥其算法长处。一位熟悉陈熙的人士则表示，陈熙擅长融资和战略分析，有很强的突破能力，增长乏力的今日头条也确实需要一位善于突破的领导者。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\"><strong style=\"font-weight: bold;\">A<\/strong><\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">在过去的一年的，字节跳动动作不断，在直播电商、教育、医疗、游戏等各条战线频频布局，老产品中抖音保持了稳定的增长，西瓜视频完成了与抖音的分工任务，将目标锁定在中视频领域。<strong style=\"font-weight: bold;\">在一片热闹中，字节跳动的元老产品今日头条却显得格外安静，这款让字节跳动真正跻身互联网一线公司的产品存在感变得越来越低。<\/strong><\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">这背后的原因在于，今日头条增长逐渐乏力。2017年，据自媒体&ldquo;开柒&rdquo;报道，今日头条融资资料显示，今日头条的日活用户达到了1.2亿。而整个2019年，这一数据还是停留在1.2亿。除此之外，今日头条已经也很久没有对外公布用户数了，外界猜测，其用户数增长已陷入停滞。<\/p>\n<p class=\"detailPic\" style=\"margin: 0px auto 20px; padding: 0px; text-align: justify; text-indent: 28px; font-size: 16px; line-height: 32px; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\"><img style=\"border-width: 0px; display: block; margin: 0px auto; max-width: 100%; height: auto;\" src=\"https:\/\/x0.ifengimg.com\/res\/2021\/240E0754F347C33CA3B6ED1212AD05C83A9FF9BC_size18_w640_h427.jpeg\" alt=\"换了4任CEO的今日头条还有戏吗？\" \/><\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">在陈林时代的今日头条，据易观提供的数据显示，2019年1月到6月，今日头条的MAU（月活跃用户）分别为2.88亿、2.62亿、2.50亿、2.64亿、2.79亿、2.86亿，增长态势已趋于停滞。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">外部竞争环境也日趋激烈，腾讯与百度的内容分发平台对今日头条始终紧咬不放，根据腾讯对外披露的报告显示，腾讯看点去年3月的去重日活达到了2.4亿，百度也在五月宣布APP日活突破2.3亿，而今日头条的日活在过去的两三年里几乎没有增长。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">为此，今日头条进行了频繁的人事调整。2017年，张一鸣从今日头条CEO的位置上卸任，2018年陈林接任该职，一年后，朱文佳接任，直接向张一鸣汇报。此次调岗后，陈熙将成为今日头条的第四任负责人。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\"><strong style=\"font-weight: bold;\">B<\/strong><\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">与此同时，今日头条还试图在搜索上发力。2019年中旬的CEO面对面会上，张一鸣就坦言，<strong style=\"font-weight: bold;\">如果没有搜索场景的拓展和优质内容，今日头条的增长空间可能只剩4000万DAU，<\/strong>当时，今日头条正在艰难度过1.8亿DAU的增长瓶颈期，而在第三方数据平台QuestMobile的监测中，2019年9月，今日头条DAU已经跌至1.15亿，呈现负增长趋势。<\/p>\n<p style=\"margin: 0px 0px 20px; padding: 0px; text-indent: 28px; font-size: 16px; line-height: 32px; text-align: justify; word-break: break-all; color: #2b2b2b; font-family: PingFangSC-Regular, 'Pingfang SC', 'Hiragino Sans GB', 'Noto Sans', 'Microsoft YaHei', simsun, arial, helvetica, clean, sans-serif; background-color: #ffffff;\">百度出身的朱文佳同样重视搜索，接手今日头条后，今日头条App在2020年春节前后，实现DAU过亿的成绩，短期用户增长成绩显著。为了发力搜索，字节跳动在2019年引入了360搜索产品负责人吴凯担任搜索业务负责人。同年8月，字节跳动的搜索产品&ldquo;头条搜索&rdquo;上线；2020年2月&ldquo;头条搜索&rdquo;正式推出App。<\/p>";
    
    /*
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *str = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *date = [dateFormatter dateFromString:str];
    RZLog(@"%@\n%@", date, [NSDate date]);
    
    RZSwift *test = [[RZSwift alloc] init];
    // 调用swift代码时若有参数需要引入参数名称
    [test abcWithName:@"123"];
    
    // copy与strong的区别
    RZEmptyVC *v1 = [RZEmptyVC new];
    RZEmptyVC *v2 = [RZEmptyVC new];
    RZLog(@"%p - %p", v1, v2);
    self.arr = @[v1, v2];
    NSArray *arr1 = self.arr.copy;
    NSArray *arr2 = self.arr.mutableCopy;
    CFGetRetainCount((__bridge CFTypeRef)(self.arr));
    RZLog(@"%p \n %p \n %p \n %p - %p", self.arr, arr1, arr2, self.arr[0], arr2[0]);
    
    self.mArr = [NSMutableArray arrayWithArray:@[v1, v2]];
    NSArray *arr3 = self.mArr.copy;
    NSArray *arr4 = self.mArr.mutableCopy;
    RZLog(@"%p \n %p \n %p \n %p - %p", self.mArr, arr3, arr4, self.mArr[0], arr4[0]);
    
    [v1 test];
    
    void (^testBlock1)(void) = ^{
        RZLog(@"testBlock1");
    };
    RZLog(@"%@", [testBlock1 class]);
    
    NSInteger i = 10;
    void (^testBlock2)(void) = ^{
        RZLog(@"testBlock2");
    };
    RZLog(@"%@", [testBlock2 class]);
    
    void (^testBlock3)(void) = [ ^{
        RZLog(@"testBlock3");
        RZLog(@"%li", (long)i);
    } copy];
    RZLog(@"%@", [testBlock3 class]);
    */
}

- (void)setupTableView {
    // 设置headerview
    self.HomeHeaderView.height = kScreeWith*150.f/320.f;
    
    // 隐藏指示器
    self.homeTableView.showsVerticalScrollIndicator = NO;
}

- (NSNumber*)num:(NSInteger)i {
    return [NSNumber numberWithInteger:i];
}

#pragma mark - tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str = [NSString stringWithFormat:@"%@、%@", [RZTool num:indexPath.row + 1], self.titleArr[indexPath.row]];
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor orangeColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titleArr[indexPath.row];
    
    if ([title isEqualToString:@"table折叠示例"]) {
        RZFoldTableViewController *foldVC = [[RZFoldTableViewController alloc] init];
        [self.navigationController pushViewController:foldVC animated:YES];
    }
    
    if ([title isEqualToString:@"城市列表选择"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
        NSArray *cityData = [NSArray arrayWithContentsOfFile:path];
        RZCityList *list = [[RZCityList alloc] initWithData:cityData];
        [list setRZCityListBlock:^(NSArray *nameArr, NSArray *IDArr) {
            RZLog(@"%@\n%@", nameArr, IDArr);
        }];
    }
    
    if ([title isEqualToString:@"collectionView"]) {
        RZCollectionVC *collectionVC = [[RZCollectionVC alloc] init];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
    
    if ([title isEqualToString:@"UIView+Toast"]) {
        [self.view makeToast:@"This is toast 路飞是要成为海贼王的男人，他有一群值得付出生命去守护的伙伴，他们是一伙因为梦想而聚在一起的伙伴！" duration:2.0 position:CSToastPositionCenter];
    }
    
    if ([title isEqualToString:@"iOS_base64加密"]) {
        RZBase64ViewController *base64VC = [[RZBase64ViewController alloc] init];
        [self.navigationController pushViewController:base64VC animated:YES];
        base64VC.navigationItem.title = @"base64加密";
    }
    
    if ([title isEqualToString:@"RZAlert"]) {
//        RZAlertView *alert02 = [[RZAlertView alloc] initWithTitle:nil Message:@"这是一个自定义的alertView，欢迎大家使用指导！" Delegate:self CancleTitle:nil OtherBtnTitles:nil];
//        [self.view.window addSubview:alert02];
//        alert02.isClickMask = YES;
        
        [self.tabBarController.view showAlertMsg:@"这是一个自定义的alertView，欢迎大家使用指导！"];
    }
    
    if ([title isEqualToString:@"UIView+RZAlert"]) {
        [self.tabBarController.view showAlertTitle:@"提示" msg:@"这是一个自定义的alertView，欢迎大家使用指导！" sure:^{
        }];
        
        //[[RZTool window] makeActivity:nil];
    }
    
    if ([title isEqualToString:@"RZAlertController"]) {
        [RZAlertController alertWithTitle:@"提示" message:@"这是一个自定义的alertView，欢迎大家使用指导！" actionLeftTitle:@"确定" lefthandler:^{
            RZLog(@"确定");
        } showVC:self];
    }
    
    if ([title isEqualToString:@"NSString+Size"]) {
        NSString *string = @"这是一个自定义的alertView，欢迎大家使用指导！";
        CGFloat height = [string heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:100.f];
        RZLog(@"%lf", height);
    }
    
    if ([title isEqualToString:@"NSDate+Extension"]) {
        NSDate *date = [NSDate date];
        [self.view makeRZToast:[NSString stringWithFormat:@"Today is %@ - %@", [date stringWithFormat:[date ymdFormat]], [date dayFromWeekday]]];
    }
    
    if ([title isEqualToString:@"多线程"]) {
        [self.navigationController pushViewController:[RZThreadVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"GCD 多线程"]) {
        [self.navigationController pushViewController:[RZDispatchVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"冒泡排序"]) {
//        RZLog(@"%@", [[RZSort bubbleSort3:arr] mj_JSONString]);// 冒泡
        RZLog(@"冒泡排序：%@", [[RZSort bubbleSort:self.sortArr] mj_JSONString]);// 冒泡
    }
    if ([title isEqualToString:@"选择排序"]) {
        RZLog(@"选择排序：%@", [[RZSort selectionSort:self.sortArr] mj_JSONString]);
    }
    if ([title isEqualToString:@"插入排序"]) {
        RZLog(@"插入排序：%@", [[RZSort insertionSort:self.sortArr] mj_JSONString]);// 插入排序
    }
    if ([title isEqualToString:@"快排"]) {
        RZLog(@"快排：%@", [[RZSort quickSork:self.sortArr] mj_JSONString]);// 快排
    }
    
    if ([title isEqualToString:@"定位"]) {
        [self.navigationController pushViewController:[RZUpdateLocationVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"空白界面"]) {
        [self.navigationController pushViewController:[RZEmptyVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"面试题"]) {
        [self.navigationController pushViewController:[RZInterviewController new] animated:YES];
    }
}

- (void)alertView:(RZAlertView *)alertView ClickedBtnAtIndex:(NSInteger)index {
    RZLog(@"RZAlertView CancleButtonIndex: %@", [NSNumber numberWithInteger:index]);
}

#pragma mark - 懒加载

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"table折叠示例", @"面试题", @"城市列表选择", @"collectionView", @"UIView+Toast", @"iOS_base64加密", @"RZAlert", @"RZAlertController", @"UIView+RZAlert", @"NSString+Size", @"NSDate+Extension", @"多线程", @"GCD 多线程", @"冒泡排序", @"选择排序", @"插入排序", @"快排", @"定位", @"空白界面", @"------"];
    }
    return _titleArr;
}

- (NSArray *)sortArr {
    if (!_sortArr) {
//        _sortArr = @[@34, @21, @6, @31, @43, @59, @8, @51, @51, @81, @52, @96, @80, @53, @34, @67, @37, @56, @27, @51, @11];
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < 1000; i++) {
            NSInteger n = arc4random() % 10000;
            [marr addObject:@(n)];
        }
        _sortArr = [NSArray arrayWithArray:marr];
        RZLog(@"%@", _sortArr.mj_JSONString);
    }
    return _sortArr;
}

@end
