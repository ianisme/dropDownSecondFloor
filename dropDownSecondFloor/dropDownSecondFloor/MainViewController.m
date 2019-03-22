//
//  MainViewController.m
//  dropDownSecondFloor
//
//  Created by quy21 on 2019/2/14.
//

#import "MainViewController.h"
#import <Masonry.h>
#import "DropDownSecondFloorView.h"
#import "UIView+HHAddition.h"
#import "WebViewController.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *customNavigationBar;
@property (nonatomic, strong) DropDownSecondFloorView *secondFloorView;
@property (nonatomic, assign) BOOL needShowGuide;
@property (nonatomic, assign) BOOL hasSecondFloor;
@property (nonatomic, assign) BOOL isEnteringSecondFloor;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.needShowGuide = YES;
    self.hasSecondFloor = YES;
    [self creatTableView];
    [self creatNaviBar];
    [self creatFloorView];
    [self showGuideAction];
}

- (void)dealloc
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)creatNaviBar
{
    _customNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64.0f)];
    [self.view addSubview:_customNavigationBar];
    _customNavigationBar.backgroundColor = [UIColor blueColor];
}

- (void)creatTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.height -= 64;
    _tableView.top += 64;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"123"];

    // headerView
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    headerView.backgroundColor = [UIColor yellowColor];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 72.0f);
    _tableView.tableHeaderView = headerView;
}

- (void)creatFloorView
{
    _secondFloorView = [[DropDownSecondFloorView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _secondFloorView.bottom = self.customNavigationBar.height;
    _secondFloorView.picUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1550472931&di=2b22a94ca3edc98a8fc907a86f2d15af&src=http://b-ssl.duitang.com/uploads/item/201606/10/20160610113004_er5MX.jpeg";
    [self.view insertSubview:_secondFloorView belowSubview:self.customNavigationBar];
//    _secondFloorView.imageFinish = ^{
//        [self.navigationController pushViewController:[WebViewController new] animated:YES];
//    };
}

- (void)showGuideAction
{
    if (!self.needShowGuide) {
        return;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    self.tableView.contentOffset = CGPointMake(0, -30);
    [self secondFloorEnteringWithOffset:-30];
}

- (CAShapeLayer *)maskLayerWithOffset:(CGFloat)offset
{
    // 55 拉平
    offset = MIN(55, offset);
    CGFloat margin = 55 - offset;
    CGFloat width = _secondFloorView.width;
    CGFloat height = _secondFloorView.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width, height - margin)];
    [path addQuadCurveToPoint:CGPointMake(0, height - margin) controlPoint:CGPointMake(width * 0.5, height + margin)];
    [path stroke];
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [path CGPath];
    maskLayer.fillRule = kCAFillRuleNonZero;
    
    return maskLayer;
}

- (void)enterSecondFloor:(BOOL)autoAction
{
    self.customNavigationBar.alpha = 0;
    UIScrollView *scrollView = self.tableView;
    self.isEnteringSecondFloor = YES;
    scrollView.bounces = NO;
    scrollView.transform = CGAffineTransformMakeTranslation(0, -scrollView.contentOffset.y);
    scrollView.contentOffset = CGPointZero;
    self.secondFloorView.tip = nil;
    [UIView animateWithDuration:0.4 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, scrollView.height);
        scrollView.transform = transform;
        self.secondFloorView.transform = transform;
    } completion:^(BOOL finished) {
        // 进入二楼
        self.isEnteringSecondFloor = NO;
        [self.navigationController pushViewController:[WebViewController new] animated:YES];
    }];
}


#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}



#pragma mark - scrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    [self secondFloorEnteringWithOffset:offsetY];
}

- (void)secondFloorEnteringWithOffset:(CGFloat)offsetY
{
    if (_isEnteringSecondFloor || !self.hasSecondFloor) return;
    
    if (offsetY >= 0) {
        // 搜索栏的高度
        CGFloat searchBarHeight = 72;
        CGFloat current = offsetY - 5;
        CGFloat percent = MIN(1, current / searchBarHeight);
//        self.searchBar.alpha = percent;
//        self.headerView.alpha = 1 - percent;
//        self.logoView.alpha = 1 - percent;
//        self.customNavigationBar.bottomLine.alpha = percent;
        _secondFloorView.transform = CGAffineTransformIdentity;
        self.customNavigationBar.alpha = 1;
    } else {
//        self.searchBar.alpha = 0;
//        self.headerView.alpha = 1;
        // 二楼
        CGFloat transformY = -offsetY;
        CGFloat hiddenOffset = 40;
        CGFloat alpha = (transformY - 30) / hiddenOffset;
        alpha = MIN(alpha, 1);
        self.customNavigationBar.alpha = 1 - alpha;
        self.secondFloorView.transform = CGAffineTransformMakeTranslation(0, transformY);
        if (offsetY <= -140) {
            self.secondFloorView.tip = @"松手看世界...";
        } else {
            self.secondFloorView.tip = @"下拉看世界...";
        }
        if (self.needShowGuide) {
            self.secondFloorView.layer.mask = [self maskLayerWithOffset:transformY];
        } else {
            self.secondFloorView.layer.mask = nil;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY <= -140) {
        if (self.hasSecondFloor) {
            [self enterSecondFloor:NO];
        }
    }
    if (decelerate) {
        return;
    }
}

@end
