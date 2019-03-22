//
//  DropDownSecondFloorView.h
//  dropDownSecondFloor
//
//  Created by quy21 on 2019/2/14.
//

#import <UIKit/UIKit.h>

@interface DropDownSecondFloorView : UIView

@property (nonatomic, copy) NSString *tip;
@property (nonatomic, copy) NSString *picUrl;

@property (nonatomic, copy)void(^imageFinish)();

@end
