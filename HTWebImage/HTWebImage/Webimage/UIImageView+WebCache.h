//
//  UIImageView+WebCache.h
//  HTWebImage
//
//  Created by Page on 16/3/24.
//  Copyright © 2016年 Apple.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

- (void)setimageWithUrl:(NSString *)url;

//记录当前的操作
@property  (nonatomic,copy) NSString *curentUrl;

@end
