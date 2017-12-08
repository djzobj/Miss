//
//  DJZTabBarController.m
//  Miss
//
//  Created by DJZ on 2017/12/4.
//  Copyright © 2017年 djz. All rights reserved.
//

#import "DJZTabBarController.h"
#import "DJZNavigationController.h"

@interface DJZTabBarController ()

@end

@implementation DJZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTabBar];
}

-(void)setTabBar{
    DJZNavigationController *homeController = [self createBarControllerWithName:@"HomeViewController" title:@"首页" normalImage:@"icon_home_selected" selectedImage:@"icon_home_unselected"];
    DJZNavigationController *centerController = [self createBarControllerWithName:@"CenterViewController" title:@"中心" normalImage:@"icon_licai_selected" selectedImage:@"icon_licai_unselected"];
    DJZNavigationController *mineController = [self createBarControllerWithName:@"MineViewController" title:@"我的" normalImage:@"icon_zichan_selected" selectedImage:@"icon_zichan_unselected"];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRGB:@"#BCC0CA"], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRGB:@"#34373C"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    self.viewControllers = @[homeController,centerController,mineController];
}

-(DJZNavigationController *)createBarControllerWithName:(NSString *)name title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage{
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.title = title;
    [item setImage:[[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UIViewController *controller = [NSClassFromString(name) new];
    controller.tabBarItem = item;
    DJZNavigationController *navigationController = [[DJZNavigationController alloc]initWithRootViewController:controller];
    return navigationController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
