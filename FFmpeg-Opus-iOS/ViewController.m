//
//  ViewController.m
//  FFmpeg-Opus-iOS
//
//  Created by Will on 2023/1/11.
//

#import "ViewController.h"
#import "ffmpeg.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *path = NSHomeDirectory();
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"mp3"];
    NSString *save = [NSString stringWithFormat:@"%@/%@", path, @"Documents/demo.opus"];

    char command_str_full[1024]={0};

    NSString *command_str= [NSString stringWithFormat:@"ffmpeg -i %@ -acodec libopus -ac 2 -ar 48000 %@", path1, save];
    NSArray *argv_array=[command_str componentsSeparatedByString:(@" ")];
    int argc=argv_array.count;
    char** argv=(char**)malloc(sizeof(char*)*argc);
    for(int i=0;i<argc;i++)
    {
        argv[i]=(char*)malloc(sizeof(char)*1024);
        strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
    }

    ffmpeg_main(argc, argv);

    for(int i=0;i<argc;i++)
        free(argv[i]);
    free(argv);

}
@end
