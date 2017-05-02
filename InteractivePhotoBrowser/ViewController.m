//
//  ViewController.m
//  InteractivePhotoBrowser
//
//  Created by Xue Yang on 2017/5/2.
//  Copyright © 2017年 Xue Yang. All rights reserved.
//

#import "ViewController.h"
#import "XYPhotoCell.h"
#import <KSPhotoBrowser.h>
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,KSPhotoBrowserDelegate>
@property(nonatomic,strong)NSArray *photos;
@property(nonatomic,strong)UICollectionView *collectionV;
@end
//屏幕宽度 && 高度
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
@implementation ViewController
- (NSArray *)photos
{
    if (!_photos) {
        _photos = @[@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg",@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg"];
    }
    return _photos;
}
#pragma mark --- 建表
- (UICollectionView *)collectionV
{
    if (!_collectionV) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
       
        CGFloat w = (screenW - 30) * 0.5;
        layout.itemSize = CGSizeMake(w, w);
        //item间距
//        layout.minimumInteritemSpacing = 10;
//        layout.minimumLineSpacing = 10;
        
        _collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH) collectionViewLayout:layout];
        
        //注册cell
        [_collectionV registerClass:[XYPhotoCell class] forCellWithReuseIdentifier:@"XYPhotoCell"];
        
        _collectionV.delegate = self;
        _collectionV.dataSource = self;
        
        _collectionV.alwaysBounceVertical = YES;
        _collectionV.showsVerticalScrollIndicator = NO;
        _collectionV.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionV];
}


#pragma mark --- UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYPhotoCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.photos[indexPath.item]];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *items = @[].mutableCopy;
    for (int i = 0; i < self.photos.count; i++) {
        XYPhotoCell *cell = (XYPhotoCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        KSPhotoItem *item = [[KSPhotoItem alloc] initWithSourceView:cell.imageV image:[UIImage imageNamed:_photos[i]]];
        [items addObject:item];
    }
    KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:indexPath.row];
    browser.delegate = self;
    //设置手势dismiss的样式。
    browser.dismissalStyle = KSPhotoBrowserInteractiveDismissalStyleRotation;
    //设置背景样式
    browser.backgroundStyle = KSPhotoBrowserBackgroundStyleBlur;
    //设置图片加载样式
    browser.loadingStyle = KSPhotoBrowserImageLoadingStyleIndeterminate;
    //设置图片个数样式
    browser.pageindicatorStyle = KSPhotoBrowserPageIndicatorStyleText;
    //设置是否有弹性效果
    browser.bounces = NO;
    [browser showFromViewController:self];
}

- (void)ks_photoBrowser:(KSPhotoBrowser *)browser didSelectItem:(KSPhotoItem *)item atIndex:(NSUInteger)index
{
    NSLog(@"index= %zd",index);
}

@end
