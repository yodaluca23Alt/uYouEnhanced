#import "ColourOptionsController.h"
#import "uYouPlus.h"

@interface ColourOptionsController ()
@end

@implementation ColourOptionsController

- (void)loadView {
	[super loadView];

    self.title = @"Theme Custom Color";
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItems = @[closeButton, saveButton];

    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    self.navigationItem.leftBarButtonItem = resetButton;

    self.supportsAlpha = NO;
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kCustomThemeColor"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:colorData error:nil];
    [unarchiver setRequiresSecureCoding:NO];
    UIColor *color = [unarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    self.selectedColor = color;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
}

@end

@implementation ColourOptionsController(Privates)

- (void)close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:self.selectedColor requiringSecureCoding:nil error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"kCustomThemeColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Color Saved" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertSaved addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [self presentViewController:alertSaved animated:YES completion:nil];
}

- (void)reset {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kCustomThemeColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
