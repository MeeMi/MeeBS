//
//  MeeLoginRegisterController.m
//  MeeBS
//
//  Created by 扬帆起航 on 15/11/18.
//  Copyright © 2015年 Lee. All rights reserved.
//

#import "MeeLoginRegisterController.h"

@interface MeeLoginRegisterController ()
// 登录界面的左边的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadCons;

@end

@implementation MeeLoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


//  处理注册按钮
- (IBAction)regiserButton:(UIButton *)button {
    button.selected = !button.selected;
    
    if (self.leadCons.constant == 0) {
        self.leadCons.constant = - MeeScreenW;
    }else {
        self.leadCons.constant = 0;
    }
    [UIView animateWithDuration:0.5 animations:^{
       
        // 更新UI
        [self.view layoutIfNeeded];
    }];
}

// 关掉控制器
//- (IBAction)close {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//  第二种关掉控制的方法,就是在上一个控制上月 exit建立关系


// 关掉键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
