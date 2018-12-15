//
//  ComboViewController.m
//  Combo
//
//  Created by Craig H Maynard on 11/24/13.
//  Copyright © 2016 Craig H Maynard. All rights reserved.
//
//  In viewDidLoad, we use code blocks enclosed in round brackets ({ }).
//  This syntax allows the block to return a value.
//

#import <Combo-Swift.h>
//#import "Combo-Swift.h"

#import "Combo.h"
#import "ComboCard.h"
#import "ComboDeck.h"
#import "ComboPreviewController.h"
#import "ComboViewCell.h"
#import "ComboViewController.h"

@import QuartzCore;

@interface ComboViewController () <
    CAAnimationDelegate,
    ComboProtocol,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) Combo *game;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *infoButton;
@property (nonatomic, assign) BOOL showHint;
@property (nonatomic, readonly) UIEdgeInsets insets;
@property (nonatomic, readonly) CGSize itemSize;

@end

@implementation ComboViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIEdgeInsets)insets {
    return [self collectionView:self.collectionView
                         layout:self.collectionView.collectionViewLayout
         insetForSectionAtIndex:0];
}

- (CGSize)itemSize {
    return [self collectionView:self.collectionView
                         layout:self.collectionView.collectionViewLayout
         sizeForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

#pragma mark - View Management

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Combo needs to support all iPhone screen sizes. The user inferface is simple,
    // so we decided to layout the views programmatically instead of using a storyboard.
    
    // Make sure the main view exists
    NSAssert(self.view, @"main view undefined");
    // NSLog(@"%@", self.view);

    self.view.backgroundColor = [UIColor blackColor];
    
    // Create the collection view and add it to the main view.

    self.collectionView = ({

        // Combo displays 12 cards face-up using a standard collection view. The collection view
        // fills most of the screen, and a small amount of space at the bottom is reserved for a
        // progress bar and an info button.

        CGFloat width = self.view.frame.size.width;
        CGFloat height = self.view.frame.size.height * 0.95;
        CGRect frame = CGRectMake(0.0, 0.0, width, height);

        // We always want to display the cards in a 4 x 3 grid. Given that constraint, we
        // compute the size of each cell ("span" is the standard distance between cells).
        // General formula: cellWidth = (screenWidth – (n + 1) * span) / n

        CGFloat span = 15.0;
        CGSize cellSize = CGSizeMake((width - (4.0 * span)) / 3.0, (height - (5.0 * span)) / 4.0);

        // Using the standard flow layout with the computed span and cell size
        // results in a collection view with the desired 4 x 3 grid.

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = cellSize;
        // layout.estimatedItemSize = cellSize;
        layout.sectionInset = UIEdgeInsetsMake(span, span, span, span);
        layout.minimumInteritemSpacing = layout.minimumLineSpacing = span;

        UICollectionView *view =
            [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        [view setDataSource:self];
        [view setDelegate:self];
        [view registerClass:[ComboViewCell class] forCellWithReuseIdentifier:@"ComboCell"];
        [self.view addSubview:view];

        // add single-tap gesture to choose a card
        UITapGestureRecognizer *tap =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        tap.numberOfTapsRequired = 1;
        [view addGestureRecognizer:tap];

        // add right-swipe gesture to ask for a hint
        UISwipeGestureRecognizer *swipe =
            [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipe:)];
        [swipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
        swipe.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:swipe];

        view;
    });

   // Create a progress bar and add it to the main view.

    self.progressView = ({
        UIProgressView *view = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        CGPoint origin = CGPointMake(self.view.frame.origin.x + 64.0, self.view.frame.size.height - 12.0);
        CGSize size = CGSizeMake(self.collectionView.bounds.size.width - 128.0, 3.0);
        view.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
        view.userInteractionEnabled = NO;
        view.progress = 0.5f;
        view.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:view];
        view;
    });
    
    // Create an info button to display usage information, and add it to the Main View.

    self.infoButton = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
        CGPoint origin = CGPointMake(self.view.frame.size.width - 40.0, self.view.frame.size.height - 22.0);
        CGSize size = CGSizeMake(button.frame.size.width, button.frame.size.height);
        button.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
        [button addTarget:self action:@selector(infoAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });

    // Create the first game.
    [self createGame];
}

- (void)infoAction:(UIButton*)sender {
    // NSLog(@"user tapped the info button");
    PreviewController *previewController = [[PreviewController alloc] init];
    [[self navigationController] pushViewController:previewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillDisappear:animated];
}

#pragma mark - Game Control

- (void)createGame
{
    self.game = [[Combo alloc] initWithCardCount:12 usingCardDeck:[self createDeck]];
    self.game.delegate = self;
    [self updateUI];
}

- (ComboDeck *)createDeck
{
    return [[ComboDeck alloc] init];
}

- (void)updateUI
{
    for (ComboViewCell *cell in [self.collectionView visibleCells]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        ComboCard *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card];
    }
    
    CGFloat progress = [self.game gameProgress];
    [self.progressView setProgress:progress animated:YES];
}

- (void)gameDidFinish
{
    NSArray *messages = @[@"Awesome!", @"Great Job!", @"Whew!", @"Nice Work!"];
    unsigned index = arc4random() % [messages count];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                   message:messages[index]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) { [self createGame]; }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)singleTap:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        self.showHint = NO;
        BOOL success = [self.game chooseCardAtIndex:indexPath.item];
        [self updateUI];
        if (!success) {
            // match failed
            [self shake];
        }
    }
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gesture
{
    self.showHint = YES;
    [self updateUI];
}


#pragma mark - QuickLook

- (IBAction)info:(id)sender
{
    [self present];
}

- (void)present
{
    PreviewController *controller = [[PreviewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ComboViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ComboCell" forIndexPath:indexPath];
    ComboCard *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];

    return cell;
}

- (void)updateCell:(ComboViewCell *)cell usingCard:(ComboCard *)card
{
    cell.rank = card.rank;
    cell.shape = card.shape;
    cell.color = card.color;
    cell.shading = card.shading;
    cell.hidden = card.isMatched;

    if (card.isNew) {
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionMoveIn;
        transition.subtype = kCATransitionFromBottom;
        transition.duration = 0.3;
        [cell.layer addAnimation:transition forKey:nil];
        card.new = NO;
    }

    if (self.showHint) {
        if (card.canMatch) {
            [self startAnimatingCell:cell];
        }
    }
    else if (card.isChosen) {
        [self startAnimatingCell:cell];
    }
    else {
        [self stopAnimatingCell:cell];
    }
}

- (void)startAnimatingCell:(ComboViewCell *)cell
{
    if (cell.isAnimating) return;
    cell.isAnimating = YES;

    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut |
                                     UIViewAnimationOptionAutoreverse |
                                     UIViewAnimationOptionRepeat |
                                     UIViewAnimationOptionAllowUserInteraction;

    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95, 0.95);

    [UIView animateWithDuration:0.25
                          delay:0
                        options:options
                     animations:^{ cell.transform = transform; }
                     completion:NULL];
}

- (void)stopAnimatingCell:(ComboViewCell *)cell
{
    if (!cell.isAnimating) return;
    cell.isAnimating = NO;

    UIViewAnimationOptions options = UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionBeginFromCurrentState;

    CGAffineTransform transform = CGAffineTransformIdentity;

    [UIView animateWithDuration:0.1
                          delay:0
                        options:options
                     animations:^{ cell.transform = transform; }
                     completion:NULL];
}

- (void)shake
{
    static CAKeyframeAnimation *animation;

    if (!animation) {

        animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.duration = 0.25;
        animation.delegate = self;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = YES;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

        NSMutableArray* values = [[NSMutableArray alloc] init];

        int steps = 100;
        double position = 0;
        float e = 2.71;

        for (int t = 0; t < steps; t++) {
            position = 10 * pow(e, -0.022 * t) * sin(0.12 * t);
            NSValue* value = [NSValue valueWithCGPoint:CGPointMake([self.collectionView center].x - position, [self.collectionView center].y)];
            [values addObject:value];
        }

        animation.values = values;
    }

    [[self.collectionView layer] addAnimation:animation forKey:@"position"];
}

@end
