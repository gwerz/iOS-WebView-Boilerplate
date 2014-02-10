//
//  ViewController.m
//  Sample App
//
//  Created by Artem Golub on 2/4/14.
//  Copyright (c) 2014 Artem Golub. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, retain) IBOutlet UIWebView * webView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView * spinner;
@end

@implementation ViewController
@synthesize spinner;
@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    [[self.webView scrollView] setBounces: NO];
    [self.webView.scrollView setDelaysContentTouches: NO];
    
    // Load local.
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:nil];
    NSString *htmlString = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *Url = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:htmlString baseURL:Url];
    
    // Load remote.
	//NSString *fullURL = @"http://remote.com/index.html";
    //NSURL *url = [NSURL URLWithString:fullURL];
    //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    //[self.webView loadRequest:requestObj];
    
    [spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserDrag='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserModify='none';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitHighlight='none';"];
    
    if ([self iOS7OrHigher]) {
        self.webView.scrollView.contentInset = UIEdgeInsetsMake(20,0,0,0);
    }
    
    [spinner stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        static NSString *regexp = @"^(([a-zA-Z]|[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9])[.])+([A-Za-z]|[A-Za-z][A-Za-z0-9-]*[A-Za-z0-9])$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
        
        if ([predicate evaluateWithObject:request.URL.host]) {
            [[UIApplication sharedApplication] openURL:request.URL];
            
            return NO;
        } else {
            return YES;
        }
    }
    
    return YES;
}

- (BOOL)iOS7OrHigher {
    float iOSversion = [[[UIDevice currentDevice] systemVersion] floatValue];
    return iOSversion >= 7;
}

@end
