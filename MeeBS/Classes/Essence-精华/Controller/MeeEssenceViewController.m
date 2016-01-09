//
//  MeeEssenceViewController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/7.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeEssenceViewController.h"
#import "MeeTagTableViewController.h"

#import "MeeAllViewController.h"
#import "MeeWordViewController.h"
#import "MeeVideoViewController.h"
#import "MeeVoiceViewController.h"
#import "MeePictureViewController.h"

@interface MeeEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIButton *selectBtn; /**< 记录选中的按钮 */
@property (nonatomic, weak) UIView *indicatorView; /**< 记录一下指示器 */

@end

@implementation MeeEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建左边的
    
    // 方式一：
    /*
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸，否则无法显示
    [leftButton sizeToFit];
    [leftButton addTarget:self action:@selector(leftBaeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
     */
    
    // 方式二：
    /*
    self.navigationItem.leftBarButtonItem = [self barItemWithImage:@"MainTagSubIcon" andSelectImage:@"MainTagSubIconClick" action:@selector(leftBarButtonItem)];
     */
    
    // 方式三：UIBarButtonItem 分类
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImage:@"MainTagSubIcon" andSelectImage:@"MainTagSubIconClick" action:@selector(leftBaeButtonClick) andTarget:self];
    
    // 精华模块，分为 全部、声音、图片、视频、段子，这个五个部分
    // 这个五个部分展示五个不同的内容View，创建五个子控制器，负责每个View界面上的数据展示
    // 给精华模块，添加子控制器
    [self setupAddChildViewController];
    
    // 设置scrollView
    [self setupScrollView];
    
    // 设置导航条下面的切换导航按钮条
    [self setupButtonView];
}

#pragma mark - 导航条左边的按钮点击事件
- (void)leftBaeButtonClick
{
    // 进入推荐标签的子控制器
    MeeTagTableViewController *tagVc = [[MeeTagTableViewController alloc]init];
    [self.navigationController pushViewController:tagVc animated:YES];
}

#pragma mark - setupAddChildViewController
- (void)setupAddChildViewController
{
    MeeAllViewController *all = [[MeeAllViewController alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    
    MeeVideoViewController *video = [[MeeVideoViewController alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    
    MeeVoiceViewController *voice = [[MeeVoiceViewController alloc]init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    MeePictureViewController *picture = [[MeePictureViewController alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    MeeWordViewController *word = [[MeeWordViewController alloc]init];
    word.title = @"段子";
    [self addChildViewController:word];
    
    // 控制器成为父控制器的子控制器，同时他们的view也要成为父控制器View的子View
}


#pragma mark - setupScrollView
- (void)setupScrollView
{
    // 创建scrollView，这样添加子控制器的View，能够通过滑动来切换
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
   
    // 设置禁止设置scrollView增加内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 设置scrollView 的内容尺寸
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * MeeScreenW, 0); // 0 表示竖直方向不要拖到
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    // 这种方式添加控制器的弊端，一次性将所以的子控制都加载进来，但是实际中，是拖动到那个控制器，就去加载哪个控制器
    // 添加子控制的view
    /*
     for (int i = 0; i < self.childViewControllers.count; i++) {
     UITableViewController *vc = self.childViewControllers[i];
     vc.view.x = i * screenWidth;
     vc.view.y = 0;
     
     // 设置view的内边距
     vc.tableView.contentInset = UIEdgeInsetsMake(104, 0, 49, 0);
     [scrollView addSubview:vc.view];
     }
     */
}

#pragma mark - setupButtonView
- (void)setupButtonView
{
    // 1.创建view
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, MeeNavHeight, MeeScreenW, 40);
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    
    
    // 2.创建按钮
    NSInteger count = self.childViewControllers.count;
    CGFloat btnW = MeeScreenW / count;
    CGFloat btnH = titleView.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeVc:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];

        [titleView addSubview:btn];
    }
    
    // 3.创建按钮下面的指示条View
    UIView *indicatorView = [[UIView alloc]init];
    [titleView addSubview:indicatorView];
    // 颜色和按钮选择时的颜色一样。随便获取一个按钮
    UIButton *fristBtn = titleView.subviews.firstObject;
    indicatorView.backgroundColor = [fristBtn titleColorForState:UIControlStateSelected];
    // 设置尺寸
    indicatorView.height = 1;
    indicatorView.y = fristBtn.height - 1;
    // 因为这个方法中在设置按钮，还没有执行完，还无法刷新计算titleLabel的宽度，所以自己动手提前计算
    [fristBtn.titleLabel sizeToFit]; // 注意是titleLabel计算尺寸，不是btn要不btn位置会错
    indicatorView.width = fristBtn.titleLabel.width;
    // 注意设置center一定要在设置Size的后面
    indicatorView.centerX = fristBtn.centerX;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 设置默认情况下，第一个按钮被选择
    fristBtn.selected = YES;
    self.selectBtn = fristBtn;
}

// 切换控制器的View
- (void)changeVc:(UIButton *)btn
{
    // 取消上一次按钮的选中
    self.selectBtn.selected = NO;
    // 设置本次按钮选中状态
    btn.selected = YES;
    // 记录本次选中的按钮
    self.selectBtn = btn;
    
    // 指示器的动画
    [UIView animateWithDuration:.25 animations:^{
        // 让指示的宽度和选中的按钮文子是一样大的
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    
   
}


#pragma mark -UIScrollViewDelegate

// scrollView 滚动过程中调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}
// scrollView 完全停止时，调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //DidEndDecelerating 在减速过程后，就是停止
    
}


#pragma mark - 往scrollView中添加子控制器的View
- (void)addChildVcView
{
    // 获取索引
    NSInteger index = self.scrollView.contentOffset.x / MeeScreenW;
    
    // 获取对应控制器的view，设置尺寸
    UIViewController *showView = self.childViewControllers[index].view;
    
    [self.scrollView addSubview:showView];
    // 设置尺寸
    
}






/* 方式二：
// 因为很多控制器，都要写这段代码，所以抽成 UIBarButtonItem的分类
- (UIBarButtonItem *) barItemWithImage:(NSString *)image andSelectImage:(NSString *)selectImage action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸，否则无法显示
    [btn sizeToFit];
    [btn addTarget:self action:@selector(leftBaeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
*/
@end
