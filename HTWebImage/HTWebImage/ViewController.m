//
//  ViewController.m
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "ViewController.h"
#import "HTDownLoadManager.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.导入头文件
    
    //2.加载图片 用法类似SDWebimage
    [self.iconView setimageWithUrl:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3841157212,2135341815&fm=116&gp=0.jpg"];
    
    
    
}

@end
