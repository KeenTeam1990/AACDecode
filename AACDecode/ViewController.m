//
//  ViewController.m
//  AACDecode
//
//  Created by yyj on 2017/6/9.
//  Copyright © 2017年 yyj. All rights reserved.
//

#import "ViewController.h"
#import "AACPlayer.h"

@interface ViewController ()
{
    AACPlayer *player;
    
}
@property (nonatomic , strong) UILabel  *mLabel;
@property (nonatomic , strong) UILabel *mCurrentTimeLabel;
@property (nonatomic , strong) UIButton *mDecodeButton;
@property (nonatomic , strong) CADisplayLink *mDispalyLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 100)];
    self.mLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.mLabel];
    self.mLabel.text = @"测试ACC播放";
    
    self.mCurrentTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 200, 100)];
    self.mCurrentTimeLabel.textColor = [UIColor redColor];
    self.mCurrentTimeLabel.text = @"时间";
    [self.view addSubview:self.mCurrentTimeLabel];
    
    self.mDecodeButton = [[UIButton alloc] initWithFrame:CGRectMake(150, 20, 100, 100)];
    [self.mDecodeButton setTitle:@"play" forState:UIControlStateNormal];
    [self.mDecodeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:self.mDecodeButton];
    [self.mDecodeButton addTarget:self action:@selector(onDecodeStart) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.mDispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFrame)];
    self.mDispalyLink.frameInterval = 5; // 默认是30FPS的帧率录制
    [self.mDispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.mDispalyLink setPaused:YES];
    
}

- (void)onDecodeStart {
    
    self.mDecodeButton.hidden = NO;
    [self.mDispalyLink setPaused:NO];
    player = [[AACPlayer alloc] init];
    
    NSString * urlStr = @"https://smart-voice-stg.pingan.com.cn:10422/nfsc/csp_isps_core_id005707_vol1003_stg/API/VPROMP01/TTS_HTTP/vprompttshttp01/20190212/1549939956202574.aac";
    urlStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:urlStr];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    NSURLSession * shareSession = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * downloadTask = [shareSession downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            int y =10000+ (arc4random()%10001);
            NSString * filePath = [self getFilePathWithFileName:[NSString stringWithFormat:@"%d.aac",y]];
            NSError * filError;
            [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:filePath error:&filError];
            if (filError == nil) {
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                   NSURL * urlPlay = [NSURL fileURLWithPath:filePath];
                   [player play:urlPlay];
                    
                });
            }
            
        }
        
    }];
    
    [downloadTask resume];
    
    
}

- (NSString *)getFilePathWithFileName:(NSString*)fileName{
    
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    filePath = [filePath stringByAppendingPathComponent:fileName];
    
    return filePath;
    
}

- (void)updateFrame {
    if (player) {
        self.mCurrentTimeLabel.text = [NSString stringWithFormat:@"当前时间:%.1fs", [player getCurrentTime]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
