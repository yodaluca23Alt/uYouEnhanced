#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <dlfcn.h>
#import <sys/utsname.h>
#import <substrate.h>
#import <rootless.h>

#import "RootOptionsController.h"
#import "Tweaks/YouTubeHeader/YTAppDelegate.h"
#import "Tweaks/YouTubeHeader/YTQTMButton.h"
#import "Tweaks/YouTubeHeader/YTVideoQualitySwitchOriginalController.h"
#import "Tweaks/YouTubeHeader/YTWatchController.h"
#import "Tweaks/YouTubeHeader/YTIGuideResponse.h"
#import "Tweaks/YouTubeHeader/YTIGuideResponseSupportedRenderers.h"
#import "Tweaks/YouTubeHeader/YTIPivotBarSupportedRenderers.h"
#import "Tweaks/YouTubeHeader/YTIPivotBarItemRenderer.h"
#import "Tweaks/YouTubeHeader/YTIPivotBarRenderer.h"
#import "Tweaks/YouTubeHeader/YTIBrowseRequest.h"
#import "Tweaks/YouTubeHeader/YTIButtonRenderer.h"
#import "Tweaks/YouTubeHeader/YTISectionListRenderer.h"
#import "Tweaks/YouTubeHeader/YTColorPalette.h"
#import "Tweaks/YouTubeHeader/YTCommonColorPalette.h"
#import "Tweaks/YouTubeHeader/YTSettingsSectionItemManager.h"
#import "Tweaks/YouTubeHeader/ASCollectionView.h"
#import "Tweaks/YouTubeHeader/YTPlayerOverlay.h"
#import "Tweaks/YouTubeHeader/YTPlayerOverlayProvider.h"
#import "Tweaks/YouTubeHeader/YTReelWatchPlaybackOverlayView.h"
#import "Tweaks/YouTubeHeader/YTReelPlayerBottomButton.h"
#import "Tweaks/YouTubeHeader/YTReelPlayerViewController.h"
#import "Tweaks/YouTubeHeader/YTIMenuConditionalServiceItemRenderer.h"
#import "Tweaks/YouTubeHeader/YTPivotBarItemView.h"
#import "Tweaks/YouTubeHeader/YTVideoWithContextNode.h" // YouTube-X
#import "Tweaks/YouTubeHeader/ELMCellNode.h" // YouTube-X
#import "Tweaks/YouTubeHeader/ELMNodeController.h" // YouTube-X

#define LOC(x) [tweakBundle localizedStringForKey:x value:nil table:nil]
#define IS_ENABLED(k) [[NSUserDefaults standardUserDefaults] boolForKey:k]
#define APP_THEME_IDX [[NSUserDefaults standardUserDefaults] integerForKey:@"appTheme"]
#define YT_BUNDLE_ID @"com.google.ios.youtube"
#define YT_NAME @"YouTube"
#define DEFAULT_RATE 1.0f // YTSpeed
#define LOWCONTRASTMODE_CUTOFF_VERSION @"17.38.10" // LowContrastMode

// IAmYouTube
@interface SSOConfiguration : NSObject
@end

// uYouPlus
@interface YTHeaderLogoController : UIView
@property(readonly, nonatomic) long long pageStyle;
@end

@interface YTNavigationBarTitleView : UIView
@end

@interface YTChipCloudCell : UIView
@end

@interface YTPlayabilityResolutionUserActionUIController : NSObject // Skips content warning before playing *some videos - @PoomSmart
- (void)confirmAlertDidPressConfirm;
@end 

@interface YTMainAppControlsOverlayView : UIView
@end

@interface YTTransportControlsButtonView : UIView
@end

@interface _ASCollectionViewCell : UICollectionViewCell
- (id)node;
@end

@interface YTAsyncCollectionView : UICollectionView
@end

@interface FRPSliderCell : UITableViewCell
@end

@interface boolSettingsVC : UIViewController
@end

@interface YTPlaybackButton : UIControl
@end

@interface YTSegmentableInlinePlayerBarView
@property (nonatomic, assign, readwrite) BOOL enableSnapToChapter;
@end

@interface YTPlaylistHeaderViewController: UIViewController
@property UIButton *downloadsButton;
@end

// Buttons
@interface YTRightNavigationButtons : UIView
- (id)_viewControllerForAncestor;
@property(readonly, nonatomic) YTQTMButton *searchButton;
@property(readonly, nonatomic) YTQTMButton *notificationButton;
@property(strong, nonatomic) YTQTMButton *sponsorBlockButton;
@property(strong, nonatomic) YTQTMButton *uYouPlusButton;
- (void)setLeadingPadding:(CGFloat)arg1;
- (void)uYouPlusRootOptionsAction;
@end

@interface YTISlimMetadataButtonSupportedRenderers : NSObject
- (id)slimButton_buttonRenderer;
- (id)slimMetadataButtonRenderer;
@end

// YTSpeed
@interface YTVarispeedSwitchControllerOption : NSObject
- (id)initWithTitle:(id)title rate:(float)rate;
@end

@interface MLHAMQueuePlayer : NSObject
@property id playerEventCenter;
@property id delegate;
- (void)setRate:(float)rate;
- (void)internalSetRate;
@end

@interface MLPlayerStickySettings : NSObject
- (void)setRate:(float)rate;
@end

@interface MLPlayerEventCenter : NSObject
- (void)broadcastRateChange:(float)rate;
@end

@interface HAMPlayerInternal : NSObject
- (void)setRate:(float)rate;
@end

// App Theme
@interface YTColor : NSObject
+ (UIColor *)white1;
+ (UIColor *)white2;
+ (UIColor *)white3;
+ (UIColor *)white4;
+ (UIColor *)white5;
+ (UIColor *)black0;
+ (UIColor *)black1;
+ (UIColor *)black2;
+ (UIColor *)black3;
+ (UIColor *)black4;
+ (UIColor *)blackPure;
+ (UIColor *)grey1;
+ (UIColor *)grey2;
+ (UIColor *)white1Alpha98;
+ (UIColor *)white1Alpha95;
@end

@interface YTPageStyleController
+ (NSInteger)pageStyle;
@end

@interface YCHLiveChatView : UIView
@end

@interface YTFullscreenEngagementOverlayView : UIView
@end

@interface YTRelatedVideosView : UIView
@end

@interface YTTopAlignedView : UIView
@end

@interface ELMView : UIView
@end

@interface ASWAppSwitcherCollectionViewCell : UIView
@end

@interface ASScrollView : UIView
@end

@interface UIKeyboardLayoutStar : UIView
@end

@interface UIKeyboardDockView : UIView
@end

@interface _ASDisplayView : UIView
@end

@interface ELMContainerNode : NSObject
@end

@interface YTAutonavEndscreenView : UIView
@end

@interface YTPivotBarIndicatorView : UIView
@end

@interface YTCommentDetailHeaderCell : UIView
@end

@interface SponsorBlockSettingsController : UITableViewController
@end

@interface SponsorBlockViewController : UIViewController
@end

@interface UICandidateViewController : UIViewController
@end

@interface UIPredictionViewController : UIViewController
@end

@interface FRPreferences : UITableViewController
@end

@interface FRPSelectListTable : UITableViewController
@end

@interface settingsReorderTable : UIViewController
@property(nonatomic, strong) UITableView *tableView;
@end

// Snack bar
@interface YTHUDMessage : NSObject
+ (id)messageWithText:(id)text;
- (void)setAction:(id)action;
@end

@interface GOOHUDMessageAction : NSObject
- (void)setTitle:(NSString *)title;
- (void)setHandler:(void (^)(id))handler;
@end

@interface GOOHUDManagerInternal : NSObject
- (void)showMessageMainThread:(id)message;
+ (id)sharedInstance;
@end
