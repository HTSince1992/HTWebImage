//
//  HTDownLoadImage.h
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^FinishedBlock)(UIImage *image);

@interface HTDownLoadImage : NSOperation


//写一个方法以供对象调用传值
+ (instancetype)DownloadImageWithUrl:(NSString *)url andBlock:(FinishedBlock)finishedBlock;

@end
