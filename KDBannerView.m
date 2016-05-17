//
//  KDBannerView.m
//  zhonghaijinchao
//
//  Created by Blankwonder on 5/30/15.
//  Copyright (c) 2015 Blankwonder. All rights reserved.
//

#import "KDBannerView.h"

@interface KDBannerView () <UIScrollViewDelegate> 

@end

@interface KDBannerViewTapGestureRecognizer : UITapGestureRecognizer
@end

@implementation KDBannerViewTapGestureRecognizer
@end

@implementation KDBannerView {
    UIScrollView *_scrollView;
    NSArray *_views;
    
    NSTimer *_timer;
}

- (void)_init {
    _tapEnabled = YES;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.scrollsToTop = NO;
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.hidesForSinglePage = YES;
    
    _pageControlBottomInset = 10.0f;
    
    [self addSubview:_scrollView];
    [self addSubview:_pageControl];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)setViews:(NSArray *)array {
    for (UIView *view in _views) {
        [view removeFromSuperview];
    }
    _views = [array copy];
    _pageControl.numberOfPages = _views.count;
    
    for (int i = 0; i < _views.count; i++) {
        UIView *view = _views[i];
        [_scrollView addSubview:view];
    }
    
    [self setTapEnabled:_tapEnabled];
    
    [self setNeedsLayout];
}

- (NSArray *)views {
    return  _views;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
    
    [_views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger index, BOOL *stop) {
        view.frame = CGRectMake(index * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
    }];
    
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * _pageControl.numberOfPages, self.bounds.size.height);
    
    [_pageControl sizeToFit];
    
    _pageControl.center = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height - _pageControlBottomInset);
}

- (void)timer {
    if (_pageControl.numberOfPages == 0) return;
    NSInteger page = _pageControl.currentPage + 1;
    if (page == _pageControl.numberOfPages) page = 0;
    [_scrollView scrollRectToVisible:((UIView *)_views[page]).frame
                            animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (_pageControl.currentPage != page) {
        _pageControl.currentPage = page;
        
        if ([self.delegate respondsToSelector:@selector(bannerView:didScrollToView:atIndex:)]) {
            [self.delegate bannerView:self didScrollToView:_views[page] atIndex:page];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.autoScrollDuration = _autoScrollDuration;
}

- (void)viewTapped:(UIGestureRecognizer *)gr {
    if ([self.delegate respondsToSelector:@selector(bannerView:didTapView:atIndex:)]) {
        [self.delegate bannerView:self
                       didTapView:gr.view
                          atIndex:[_views indexOfObject:gr.view]];
    }
}

- (void)setAutoScrollDuration:(NSTimeInterval)autoScrollDuration {
    _autoScrollDuration = autoScrollDuration;
    
    [_timer invalidate];
    _timer = nil;
    
    if (autoScrollDuration != 0.0) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:autoScrollDuration target:self selector:@selector(timer) userInfo:nil repeats:YES];
    }
}

- (void)setPageControlBottomInset:(CGFloat)pageControlBottomInset {
    _pageControlBottomInset = pageControlBottomInset;
    [self setNeedsLayout];
}

- (NSInteger)currentIndex {
    return _pageControl.currentPage;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    [self setCurrentIndex:currentIndex animated:NO];
}

- (void)setCurrentIndex:(NSInteger)currentIndex animated:(BOOL)animated {
    _pageControl.currentPage = currentIndex;
    [_scrollView setContentOffset:CGPointMake(currentIndex * _scrollView.frame.size.width, 0) animated:animated];
}

- (void)dealloc {
    [_timer invalidate];
}

- (void)setTapEnabled:(BOOL)tapEnabled {
    _tapEnabled = tapEnabled;
    
    for (int i = 0; i < _views.count; i++) {
        UIView *view = _views[i];
        
        for (UIGestureRecognizer *gr in view.gestureRecognizers) {
            if ([gr isKindOfClass:[KDBannerViewTapGestureRecognizer class]]) {
                [view removeGestureRecognizer:gr];
            }
        }
        
        if (tapEnabled) {
            view.userInteractionEnabled = YES;
            KDBannerViewTapGestureRecognizer *gr = [[KDBannerViewTapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
            [view addGestureRecognizer:gr];
        }
    }
    
    
}

@end
