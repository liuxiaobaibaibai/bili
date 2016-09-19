//
//  UITextField+lwTextField.m
//  JuYingBao
//
//  Created by lw on 16/7/1.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "UITextField+lwTextField.h"

@implementation UITextField (lwTextField)

- (void)price:(id)target{
    self.delegate = target;
    self.keyboardType = UIKeyboardTypeDecimalPad;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // 判断是否包含小数点
    if ([textField.text containsString:@"."] && [string isEqualToString:@"."]) {
        return NO;
    }else{
        return YES;
    }
}

@end
