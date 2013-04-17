//
//  AppRater.m
//  AppRater
//
//  Created by RedScor Yuan on 2013/4/16.
//  http://redscor.github.com
//
//  Copyright 2013 RedScor Yuan . All rights reserved.
//
//	This Class Use in ARC , If you are not use it , set -fobjc-arc in build Phases
//  at AppRater.m

#import "AppRater.h"

@interface AppRater ()

@end

@implementation AppRater

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

+ (id)getRootViewController {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal) {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(window in windows) {
//            if (window.windowLevel == UIWindowLevelNormal) {
//                break;
//            }
//        }
//    }
    
    for (UIView *subView in [window subviews])
    {
        UIResponder *responder = [subView nextResponder];
        if([responder isKindOfClass:[UIViewController class]]) {
            return ((UIViewController *) responder);
        }
    }
    
    return nil;
}

+ (AppRater *)initController {
	static AppRater *appRater = nil;
	
	if (appRater == nil)
		appRater = [[AppRater alloc] init];

	return appRater;
}

+ (void)openAppStore:(NSString *)AppId
{
	if (NSStringFromClass([SKStoreProductViewController class]) != nil) {
		
	
		SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc]init];
		
		//設定小菊花
		__block	UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(150.0f, 144.0f, 40.0f, 40.0f)];
		activityView.activityIndicatorViewStyle =UIActivityIndicatorViewStyleWhiteLarge;
		
		UIViewController *controller = [self getRootViewController];
		[controller.view addSubview:activityView];

		if([activityView isAnimating]){
			return;
		}
		[activityView startAnimating] ;
		
		storeProductVC.delegate = self.initController ;
		[storeProductVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:AppId} completionBlock:^(BOOL result, NSError *error) {
			
			[activityView stopAnimating];
			activityView = nil; //釋放菊花
			
			if (error) 
				NSLog(@"error : %@, UserInfo : %@",error,[error userInfo]);
			else
				//推出頁面顯示app 位置
				[[self getRootViewController] presentViewController:storeProductVC animated:YES completion:nil];
		}];
		
	}else{

		[[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",AppId]]];
	}
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
	[[AppRater getRootViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
