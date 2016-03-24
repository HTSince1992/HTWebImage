//
//  HTDownLoadManager.m
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#define filePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:[url lastPathComponent]]

#import "HTDownLoadManager.h"
#import "HTDownLoadImage.h"


@interface HTDownLoadManager () <NSCacheDelegate>
//操作队列
@property (nonatomic,strong) NSOperationQueue *queue;

//操作缓存
@property (nonatomic,strong) NSMutableDictionary *operationCache;

//内存缓存
//@property (nonatomic,strong) NSMutableDictionary *ImageCache;

//使用NSCache进行内存缓存
@property (nonatomic,strong) NSCache *imgCache;

@end

@implementation HTDownLoadManager

//实例化内存缓存、
//- (NSMutableDictionary *)ImageCache
//{
//    if (!_ImageCache) {
//        _ImageCache = [NSMutableDictionary dictionary];
//    }
//    
//    return _ImageCache;
//}

//实例化内存缓存
- (NSCache *)imgCache
{
    if (!_imgCache) {
        _imgCache = [[NSCache alloc] init];
        _imgCache.countLimit = 1;
        _imgCache.delegate = self;
    }
    return _imgCache;
}

//实例化队列
- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

//实例化操作缓存、
- (NSMutableDictionary *)operationCache
{
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    
    return _operationCache;
}

//创建单例对象
+ (instancetype)ShareDownLoadManager
{
    static HTDownLoadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTDownLoadManager alloc] init];
    });
    
    return manager;
}

- (void)DownLoadpicWithUrl:(NSString *)url andBlock:(FinishedBlock)finishedBlock
{
    //判断内存有无，没有再去下载
//    if ([self.ImageCache objectForKey:url]) {
//        NSLog(@"来内存");
//        
//        if (finishedBlock) {
//            
//            finishedBlock([self.ImageCache objectForKey:url]);
//        }
//        
//        return;
//    }
    if ([self.imgCache objectForKey:url]) {
        
        NSLog(@"来内存");
        if (finishedBlock) {
            finishedBlock([self.imgCache objectForKey:url]);
            }
         return;
    }
    
    //判断沙河缓存是否有
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
         NSLog(@"来沙河");
        if (finishedBlock) {
            
            finishedBlock(image);
            
            //添加到内存
//            [self.ImageCache setObject:image forKey:url];
            [self.imgCache setObject:image forKey:url];
            
        }
        
        return;
    }
    
    //判断是否已经有相同的操作，如果有就不再创建操作
    if ([self.operationCache objectForKey:url]) {
        return;
    }
    
    //创建操作
    HTDownLoadImage *op = [HTDownLoadImage DownloadImageWithUrl:url andBlock:^(UIImage *image) {
        
        //将图片添加到内存缓存
//        [self.ImageCache setObject:image forKey:url];
        if (image) {
            [self.imgCache setObject:image forKey:url];
        }
        
        if (finishedBlock) {
            
            finishedBlock(image);
        }
        
    }];
    
    //将操作加入到操作缓存
    [self.operationCache setObject:op forKey:url];
    
    //操作加入到队列
    [self.queue addOperation:op];
    
}

- (void)CancleDoanloadWithUrl:(NSString *)url
{
    //从操作缓存中取出对应的操作
    HTDownLoadImage *op = [self.operationCache objectForKey:url];
    
    if (op==nil) {
        return;
    }
    
    [op cancel];
    
    //从操作缓存中移除对应的操作
    [self.operationCache removeObjectForKey:url];
}

//重写init方法添加内存警告通知
//- (id)init
//{
//    if (self == [super init]) {
//        
//        //添加通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ClearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
//        
//    }
//    
//    return self;
//}

//接受内存警告后清除内存缓存
//- (void)ClearMemory
//{
//    // 清除内存缓存
//    [self.ImageCache removeAllObjects];
//}

//- (void)ClearMemory
//{
//    // 清除内存缓存
//    [self.imgCache removeAllObjects];
//}

//当有内存警告时清除内存,移除哪个由系统决定
- (void)cache:(NSCache *)cache willEvictObject:(id)obj
{
    NSLog(@"移除==%@",obj);
}

@end
