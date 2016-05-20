//
//  SelectionCell.h
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "UIImageView+AFNetworking.h"
@interface SelectionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *info;

@property(nonatomic, strong)VideoModel *model;

@end
