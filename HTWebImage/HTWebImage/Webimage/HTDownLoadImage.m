//
//  HTDownLoadImage.m
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#define filePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[url lastPathComponent]]

#import "HTDownLoadImage.h"

@interface HTDownLoadImage ()

@property (nonatomic,copy) NSString *url;

@property (nonatomic,copy) FinishedBlock finishedBlock;

@end

@implementation HTDownLoadImage

+ (instancetype)DownloadImageWithUrl:(NSString *)url andBlock:(FinishedBlock)finishedBlock
{
    HTDownLoadImage *op = [[HTDownLoadImage alloc] init];
    op.url = url;
    op.finishedBlock = finishedBlock;
    return op;

}

- (void)main
{
    @autoreleasepool {
        
        NSLog(@"来下载了");
        
        //下载图
        NSURL *url = [NSURL URLWithString:self.url];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        //写入沙河缓存
        [data writeToFile:filePath atomically:YES];
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (self.finishedBlock) {
            
            //应该在主线程调用
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.finishedBlock(image);
            }];
            
        }
        
    }
}

@end
