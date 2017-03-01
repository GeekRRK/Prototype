//
//  ChangeUserInfoVC.m
//  BaseProject
//
//  Created by GeekRRK on 2016/12/20.
//  Copyright © 2016年 GeekRRK. All rights reserved.
//

#import "BPChangeUserInfoVC.h"
#import <MBProgressHUD.h>

@interface BPChangeUserInfoVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *provinceCityTextField;

@end

@implementation BPChangeUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改用户信息";
    
    [self requestUserInfo];
}

- (void)requestUserInfo {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:TOKEN];
    NSString *api = SERVER_ADDRESS API_USERINFO;
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS, @"token":TOKEN} copyItems:YES];
    [param setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [BPInterface request:token param:param success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([responseObject[@"status"] intValue] == 0) {
            // 处理获取的用户信息
        } else {
            [BPUtil showMessage:responseObject[@"content"]];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [BPUtil showMessage:error.localizedDescription];
    }];
}

- (NSDictionary *)userInfoParams {
    NSString *name = _nameTextField.text;               // 姓名，可选
    NSString *email = _emailTextField.text;             // 邮箱，可选
    NSString *sex = @"";                                // 性别，可选，1男 2女
    NSString *provinceid = @"";                         // 省份id，可选
    NSString *cityid = @"";                             // 城市id，可选
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:@{FIXED_PARAMS,
                                                                                    @"name":name,
                                                                                    @"email":email,
                                                                                    @"sex":sex,
                                                                                    @"province_id":provinceid,
                                                                                    @"city_id":cityid} copyItems:YES];
    
    [params setValuesForKeysWithDictionary:[BPUtil getUserParamDict]];
    
    return params;
}

- (IBAction)clickChangeBtn:(id)sender {
    NSString *api = SERVER_ADDRESS API_MODIFY_USERINFO;
    NSDictionary *params = [self userInfoParams];
    
    NSString *imgPath = [CACHE_DIR stringByAppendingPathComponent:@"avatar.jpg"];
    NSDictionary *files = @{@"avatar":imgPath};
    
    if (params || files) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [BPInterface request2UploadFile:api files:files param:params success:^(NSDictionary *responseObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([responseObject[@"status"] intValue] == 0) {
                
            } else {
                [BPUtil showMessage:responseObject[@"content"]];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [BPUtil showMessage:error.localizedDescription];
        }];
    }
}

@end