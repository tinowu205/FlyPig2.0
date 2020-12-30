//
//  HomeViewController.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import "HomeViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface HomeViewController ()<UITextViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.title = @"FlyPig";
    [self layoutViews];
    
    UIBarButtonItem* item = [ [UIBarButtonItem alloc]initWithImage:[UIImage systemImageNamed:@"sun.max"] menu:nil];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)layoutViews{
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(30, 150, ScreenWidth-60, ScreenHeight-250)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 20;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 10;
    
    [self.view addSubview:_bgView];
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, 300, 80)];
    [self.bgView addSubview:label];
    label.font = [UIFont systemFontOfSize:30];
    label.text = @"您要去哪儿？🙋🏻‍♂️";
    label.textAlignment = 1;
    
    _searchView = [[UITextView alloc]init];
    [self.bgView addSubview:_searchView];
    _searchView.frame = CGRectMake(30, 100, 300, 100);
    _searchView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    _searchView.layer.cornerRadius = 15;
    _searchView.font = [UIFont systemFontOfSize:30];
    _searchView.textContainerInset = UIEdgeInsetsMake(30, 0, 12, 0);
    _searchView.textAlignment = 1;
    
    _buttonView = [[UILabel alloc]initWithFrame:CGRectMake(60, 250, 240, 50)];
    _buttonView.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpToDetail)];
    [_buttonView addGestureRecognizer:tap];
    _buttonView.layer.cornerRadius = 25;
    _buttonView.layer.masksToBounds = YES;
    _buttonView.backgroundColor = [UIColor orangeColor];
    _buttonView.text = @"搜索🚀";
    _buttonView.textAlignment = 1;
    [self.bgView addSubview:_buttonView];
}
-(void)jumpToDetail{
    [self.searchView endEditing:YES];
    self.detailVC = [[ViewController alloc]init];
    self.detailVC.destination = self.searchView.text;
    
    [self.navigationController pushViewController:_detailVC animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    textView.text = @"";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
