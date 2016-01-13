//
//  SelectionCell.m
//  LSHOpenYourEyes
//
//  Created by DeNiRo4H on 16-1-12.
//  Copyright (c) 2016年 LSH. All rights reserved.
//

#import "SelectionCell.h"
#import "UIImageView+AFNetworking.h"
@implementation SelectionCell


-(void)setModel:(VideoModel *)model{

    _model = model;
    [self.image setImageWithURL:[NSURL URLWithString:_model.cover.feed]];
    self.title.text = _model.title;
    
    self.info.text = [NSString stringWithFormat:@"#%@ / %@",_model.category,_model.duration];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
