//
//  ViewController.m
//  ZZLNavigationBar
//
//  Created by ZZL on 2017/2/14.
//  Copyright © 2017年 com.GuangZhou Rich Stone Data Technologies Company Limited.ZZL. All rights reserved.
//

#import "ViewController.h"

#define kScreenWith [UIScreen mainScreen].bound.size.width
#define kScreenHeight [UIScreen mainScreen].bound.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIView *backViewForTableHeaderView;
@property(nonatomic,strong)UIImageView *backImageViewForTableHeaderView;
@property(nonatomic,strong)UIImageView *barImageView;
@property(nonatomic,strong)UILabel *nameLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createTableView];
    
    [self handleNavigationBar];
    
}

-(void)createTableView{

    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height + 64)];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    [self.view addSubview:_myTableView];
    _myTableView.tableHeaderView = [self createTableHeaderView];

}

- (void)handleNavigationBar {
    
    self.barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
    _barImageView.backgroundColor = [UIColor orangeColor];
    [self.navigationController.navigationBar addSubview:_barImageView];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"我最帅" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem * naButton = [[UIBarButtonItem alloc]initWithTitle:@"哈哈哈" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    self.navigationItem.leftBarButtonItem = naButton;
    
    [self.navigationItem.titleView bringSubviewToFront:self.navigationItem.leftBarButtonItem.customView ];
    
    // 去掉背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 去掉navigationBar底部线条
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    // 此处y设置为-20, 否则状态栏不能被覆盖
//    self.barImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
//    _barImageView.backgroundColor = [UIColor orangeColor];
//    [self.navigationController.navigationBar addSubview:_barImageView];
    self.navigationItem.title = @"导航栏";
}

-(void)click{

    NSLog(@"我最新帅！！！");
    
}

- (UIView *)createTableHeaderView {
    self.backViewForTableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    self.backImageViewForTableHeaderView = [[UIImageView alloc] initWithFrame:self.backViewForTableHeaderView.bounds];
    _backImageViewForTableHeaderView.image = [UIImage imageNamed:@"timg (2).jpeg"];
    [self.backViewForTableHeaderView addSubview:_backImageViewForTableHeaderView];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 200, 40)];
    _nameLabel.text = @"FUCK CONPOUTER";
    [self.backViewForTableHeaderView addSubview:_nameLabel];
    
    
    return _backViewForTableHeaderView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    cell.textLabel.text = [NSString stringWithFormat:@"cell- %ld", indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 64) / 200.0f;
    self.barImageView.alpha = alpha;
    if (offset_Y < -64) {
        CGFloat add_height = -(offset_Y + 64);
        CGFloat scale = (200 + add_height) / 200.0f;
        self.backImageViewForTableHeaderView.frame = CGRectMake(-([UIScreen mainScreen].bounds.size.width * scale - [UIScreen mainScreen].bounds.size.width) / 2.0f, -add_height, [UIScreen mainScreen].bounds.size.width * scale, 200 + add_height);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
