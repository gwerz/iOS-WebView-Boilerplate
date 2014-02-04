//
//  ViewController.m
//  Sample App
//
//  Created by Artem Golub on 2/4/14.
//  Copyright (c) 2014 Artem Golub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize spinner;
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:nil];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *Url = [NSURL fileURLWithPath:htmlPath];
    
    [[self.webView scrollView] setBounces: NO];
    
    [self.webView loadHTMLString:htmlString baseURL:Url];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserDrag='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserModify='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitHighlight='none';"];
    
    if ([self iOS5OrHigher]) {
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(20.0,0.0,44.0,0.0);
    } else {
        UIScrollView *scrollview = (UIScrollView *)[self.webView.subviews objectAtIndex:0];
        scrollview.contentInset = UIEdgeInsetsMake(20.0,0.0,44.0,0.0);
    }
    
    [spinner stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    static NSString *regexp = @"^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9])[.])+([A-Za-z]|[A-Za-z][A-Za-z0-9-]*[A-Za-z0-9])$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    
    if ([predicate evaluateWithObject:request.URL.host]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)iOS5OrHigher {
    NSString *iOSversion = [[UIDevice currentDevice] systemVersion];
    if ([iOSversion compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending) {
        return YES;
    } else {
        return NO;
    }
}

@end
