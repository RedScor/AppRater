//
//  AppRater.h
//  AppRater
//
//  Created by RedScor Yuan on 2013/4/16.
//  http://redscor.github.com
//
//  Copyright 2013 RedScor Yuan . All rights reserved.
//
//	This Class Use in ARC , If you are not use it , set -fobjc-arc in build Phases
//  at AppRater.m

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

//@protocol RateApp <NSObject>
//
//@optional
//- (UIViewController *)setDelegate;
//
//@end

@interface AppRater : UIViewController<SKStoreProductViewControllerDelegate>


//@property(nonatomic,assign)id <RateApp> delegate;
+ (void)openAppStore:(NSString *)AppId;
@end


