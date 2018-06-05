//
//  ViewController.m
//  mac_02_window
//
//  Created by beyond on 2018/6/5.
//  Copyright © 2018年 beyond. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()<NSWindowDelegate>
{
    NSWindow *_win;
    NSTextView *_textView;
    NSScrollView *_scrollView;
    
    NSButton *_switchBtn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSApplication* app = [NSApplication sharedApplication];
    
    //Create the main window
    NSRect rc = NSMakeRect(500, 0, 500, 400);
    NSUInteger uiStyle = NSTitledWindowMask | NSResizableWindowMask | NSClosableWindowMask;
    NSBackingStoreType backingStoreStyle = NSBackingStoreBuffered;
    NSWindow* win = [[NSWindow alloc] initWithContentRect:rc styleMask:uiStyle backing:backingStoreStyle defer:NO];
    [win setTitle:@"代码->顶置"];
    [win makeKeyAndOrderFront:win];
    
    //    给window添加一个NSTextField
    NSTextView *textField = [[NSTextView alloc]initWithFrame:win.contentView.frame];
    
//    textField.backgroundColor = [NSColor colorWithRed:29/255.0 green:30/255.0 blue:25/255.0 alpha:1];

    textField.backgroundColor = [NSColor colorWithRed:29/255.0 green:30/255.0 blue:25/255.0 alpha:1];
    
    textField.textColor = [NSColor whiteColor];
    textField.font = [NSFont systemFontOfSize:22];
    textField.frame = win.contentView.frame;
    
    
    NSButton *btn = [NSButton buttonWithTitle:@"切换背景" target:self action:@selector(changeBgColor:)];
    
    
    // 创建段落样式，主要是为了设置居中
    NSMutableParagraphStyle *pghStyle = [[NSMutableParagraphStyle alloc] init];
    pghStyle.alignment = NSTextAlignmentLeft;
    // 创建Attributes，设置颜色和段落样式
    NSDictionary *dicAtt = @{NSForegroundColorAttributeName: [NSColor whiteColor], NSParagraphStyleAttributeName: pghStyle};
    // 创建NSAttributedString赋值给NSButton的attributedTitle属性
    btn.attributedTitle = [[NSAttributedString alloc] initWithString:@"切换背景" attributes:dicAtt];
    
    
    btn.frame = CGRectMake(textField.frame.size.width - 82, textField.frame.origin.y, 82, 32);
    
    _switchBtn = btn;
    [btn setButtonType:NSButtonTypeSwitch];
    [textField addSubview:btn];
    
    
    NSScrollView *scrollView = [[NSScrollView alloc]initWithFrame:CGRectMake(0, 0, 500, 400)];
    [scrollView setDocumentView:textField];
    [scrollView setHasVerticalScroller:YES];
    scrollView.backgroundColor = [NSColor clearColor];
    _scrollView = scrollView;
    
    
    
    [win.contentView addSubview:scrollView];
    
    _textView = textField;
    
    // 窗口透明
    [win setOpaque:NO];
    [win setBackgroundColor:[NSColor clearColor]];
    
    
    [win makeMainWindow];
    [win setLevel:NSStatusWindowLevel];
    win.delegate = self;
    _win = win;
    //Start the event loop by calling NSApp run
    [NSApp run];
    
    //    监听窗口大小改变
    [[NSNotificationCenter defaultCenter] addObserver:win
                                             selector:@selector(windowDidResize:)
                                                 name:NSWindowDidResizeNotification
                                               object:self];
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    // Update the view, if already loaded.
}

// window delegate
- (void)windowDidResize:(NSNotification *)notification
{
    _scrollView.frame = CGRectMake(0, -22, _win.frame.size.width, _win.frame.size.height);
    _textView.frame = CGRectMake(0, -22, _win.frame.size.width, _win.frame.size.height - 22);
    //    width: 82, height: 32
    NSLog(@"%f",_switchBtn.frame.size.height);
    _switchBtn.frame = CGRectMake(_textView.frame.size.width - 82, 0, 82, 32);
}


// 背景颜色改变
- (void)changeBgColor:(NSButton *)btn
{

    if(btn.state){
        _textView.backgroundColor = [NSColor whiteColor];
        
        
//        _textView.textColor = [NSColor colorWithRed:29/255.0 green:30/255.0 blue:25/255.0 alpha:1];
        
        
        // 创建段落样式，主要是为了设置居中
        NSMutableParagraphStyle *pghStyle = [[NSMutableParagraphStyle alloc] init];
        pghStyle.alignment = NSTextAlignmentLeft;
        // 创建Attributes，设置颜色和段落样式
        NSDictionary *dicAtt = @{NSForegroundColorAttributeName: [NSColor blackColor], NSParagraphStyleAttributeName: pghStyle};
        // 创建NSAttributedString赋值给NSButton的attributedTitle属性
        _switchBtn.attributedTitle = [[NSAttributedString alloc] initWithString:@"切换背景" attributes:dicAtt];
    }else{
        _textView.backgroundColor = [NSColor colorWithRed:29/255.0 green:30/255.0 blue:25/255.0 alpha:1];
        
//        _textView.textColor = [NSColor whiteColor];
        
        // 创建段落样式，主要是为了设置居中
        NSMutableParagraphStyle *pghStyle = [[NSMutableParagraphStyle alloc] init];
        pghStyle.alignment = NSTextAlignmentLeft;
        // 创建Attributes，设置颜色和段落样式
        NSDictionary *dicAtt = @{NSForegroundColorAttributeName: [NSColor whiteColor], NSParagraphStyleAttributeName: pghStyle};
        // 创建NSAttributedString赋值给NSButton的attributedTitle属性
        _switchBtn.attributedTitle = [[NSAttributedString alloc] initWithString:@"切换背景" attributes:dicAtt];
    }
}

@end
