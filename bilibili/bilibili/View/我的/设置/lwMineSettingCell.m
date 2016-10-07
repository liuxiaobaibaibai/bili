//
//  lwMineSettingCell.m
//  bilibili
//
//  Created by 刘威 on 16/10/8.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwMineSettingCell.h"

#import "lwMineSettingModel.h"

@implementation lwMineSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setMineSettingModel:(lwMineSettingModel *)mineSettingModel{
    _mineSettingModel = mineSettingModel;
    self.textLabel.text = mineSettingModel.title;
    switch (mineSettingModel.type) {
        case 1:
        {
            UISwitch *sth = [[UISwitch alloc] initWithFrame:CGRectMake(lW - 50, 0, 40, 30)];
            sth.on = YES;
            self.accessoryView = sth;
        }
            break;
        case 2:
        {
            self.detailTextLabel.text = @"我擦你妈";
            self.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
        default:
        {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
    }
}

@end
