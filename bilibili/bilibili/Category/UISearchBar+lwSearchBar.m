//
//  UISearchBar+lwSearchBar.m
//  JuYingBao
//
//  Created by lw on 16/5/25.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UISearchBar+lwSearchBar.h"

@implementation UISearchBar (lwSearchBar)


+ (UISearchBar *)createdSearchBar:(id)target{
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.placeholder = @"进口食品";
    searchBar.translucent = YES;
    searchBar.delegate = target;
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.barStyle = UIBarStyleDefault;
    searchBar.barTintColor = [UIColor whiteColor];
    return searchBar;
}

@end
