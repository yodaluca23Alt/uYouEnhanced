#import "ColourOptionsController.h"
#import "../uYouPlus.h"

@interface ColourOptionsController ()
- (void)coloursView;
@end

@implementation ColourOptionsController

- (void)loadView {
	[super loadView];
    [self coloursView];

    self.title = @"Theme Custom Color";
    
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = closeButton;

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;

    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    self.navigationItem.leftBarButtonItem = resetButton;

    self.supportsAlpha = NO;
    NSData *colorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kCustomThemeColor"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:colorData error:nil];
    [unarchiver setRequiresSecureCoding:NO];
    UIColor *color = [unarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    self.selectedColor = color;
}

- (void)coloursView {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
        self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self coloursView];
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
