//
//  HTDownLoadManager.h
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "HTDownLoadImage.h"

@interface HTDownLoadManager : NSObject

//定义一个方法以供对象调用
+ (instancetype)ShareDownLoadManager;

- (void)DownLoadpicWithUrl:(NSString *)url andBlock:(FinishedBlock)finishedBlock;

- (void)CancleDoanloadWithUrl:(NSString *)url;

@end
