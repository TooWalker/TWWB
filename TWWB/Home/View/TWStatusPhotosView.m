//
//  TWStatusPhotosView.m
//  TWWB
//
//  Created by TooWalker on 2/29/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWStatusPhotosView.h"
#import "TWStatusPhotoView.h"

#define TWStatusPhotoWH 70
#define TWStatusPhotoMargin 10

@implementation TWStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

+ (CGSize)sizeWithPhotosCount:(NSUInteger)count{
    CGSize size;
    int maxCols = (count == 4) ? 2 : 3;
    NSUInteger col = (count >= 3) ? 3 : count;
    size.width = col * TWStatusPhotoWH + (col - 1) * TWStatusPhotoMargin;

    NSUInteger row = (count + maxCols - 1) / maxCols;
    size.height = row * TWStatusPhotoWH + (row - 1) * TWStatusPhotoMargin;
    return size;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    NSUInteger photosCount = photos.count;
    while (self.subviews.count < photosCount) {
        TWStatusPhotoView *photoView = [[TWStatusPhotoView alloc] init];
        [self addSubview:photoView];

    }
    for (int i = 0; i < self.subviews.count; i++) {
        TWStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger photosCount = self.photos.count;
    int maxCol = (photosCount == 4) ? 2 : 3;
    for (int i = 0; i<photosCount; i++) {
        TWStatusPhotoView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (TWStatusPhotoWH + TWStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (TWStatusPhotoWH + TWStatusPhotoMargin);
        photoView.width = TWStatusPhotoWH;
        photoView.height = TWStatusPhotoWH;
    }
}
@end
