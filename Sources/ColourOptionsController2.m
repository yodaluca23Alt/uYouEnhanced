#import "ColourOptionsController2.h"
#import "uYouPlus.h"

@interface ColourOptionsController2 ()
@end

@implementation ColourOptionsController2

- (void)loadView {
	[super loadView];

    self.title = @"Custom Tint Color";
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItems = @[closeButton, saveButton];

    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    self.navigationItem.leftBarButtonItem = resetButton;

    self.supportsAlpha = NO;
    NSData *lcmColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kCustomUIColor"];
    NSKeyedUnarchiver *lcmUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:lcmColorData error:nil];
    [lcmUnarchiver setRequiresSecureCoding:NO];
    UIColor *color = [lcmUnarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    self.selectedColor = color;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
}

@end

@implementation ColourOptionsController2(Privates)

- (void)close {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    NSData *lcmColorData = [NSKeyedArchiver archivedDataWithRootObject:self.selectedColor requiringSecureCoding:nil error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:lcmColorData forKey:@"kCustomUIColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Color Saved" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertSaved addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [self presentViewController:alertSaved animated:YES completion:nil];
}

- (void)reset {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"kCustomUIColor"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
