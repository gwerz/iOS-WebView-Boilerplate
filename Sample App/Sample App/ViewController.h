//
//  ViewController.h
//  Sample App
//
//  Created by Artem Golub on 2/4/14.
//  Copyright (c) 2014 Artem Golub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

<UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) UIWebView * webView;
@property (nonatomic, retain) UIActivityIndicatorView * spinner;

@end