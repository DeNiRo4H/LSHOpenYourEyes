//
//  SelectionCell.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "SelectionCell.h"

@implementation SelectionCell


-(void)setModel:(VideoModel *)model{

    _model = model;
    [self.image setImageWithURL:[NSURL URLWithString:_model.cover.feed]];
    
    self.image.layer.cornerRadius = 8;
    self.image.layer.masksToBounds = YES;
    
    self.title.text = _model.title;
    
    
    NSInteger minute = [_model.duration integerValue] / 60;
    
    NSInteger second = [_model.duration integerValue] % 60;
    
    self.info.text = [NSString stringWithFormat:@"#%@ / %ld\' %ld\" ",_model.category,minute,second];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
