//
//  UIImageView+WebCache.m
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "HTDownLoadManager.h"
#import <objc/runtime.h>

@implementation UIImageView (WebCache)

//重写setter与getter方法
#define key "key"
- (void)setCurentUrl:(NSString *)curentUrl
{
    //使用运行时进行绑定赋值
    objc_setAssociatedObject(self, key, curentUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)curentUrl
{
    return objc_getAssociatedObject(self, key);
   
}

/////////////////////////////////////////////////////////////
- (void)setimageWithUrl:(NSString *)url
{
    HTDownLoadManager *manager = [HTDownLoadManager ShareDownLoadManager];
    
    //判断操作是否与之前的相同
    if ([url isEqualToString:self.curentUrl]) {
        //相同则删除之前的操作
        [manager CancleDoanloadWithUrl:self.curentUrl];
        //将之前的image设置为空，安放新图片
        self.image = nil;
        
        //将新的操作负值给self.currentUrl
        self.curentUrl = url;
    }
    
    //再去下载最新地址的图片操作
    [manager DownLoadpicWithUrl:url andBlock:^(UIImage *image) {
        
        self.image = image;
    }];
}

@end
