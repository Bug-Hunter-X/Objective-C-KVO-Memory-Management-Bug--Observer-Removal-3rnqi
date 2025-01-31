In Objective-C, a subtle bug can arise from the interaction between KVO (Key-Value Observing) and memory management.  If an observer is not properly removed when it's no longer needed (e.g., when a view controller is deallocated), it can lead to crashes or unexpected behavior.  This often occurs when the observed object outlives the observer, and the observer attempts to access deallocated memory.  The crash might not happen immediately, making it difficult to debug.

Example:

```objectivec
@interface MyViewController : UIViewController
@property (nonatomic, strong) SomeObservedObject *observedObject;
@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.observedObject addObserver:self forKeyPath:@"someProperty" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // ... handle changes ...
}

- (void)dealloc {
    [self.observedObject removeObserver:self forKeyPath:@"someProperty"];
    // ... other deallocation tasks ...
}

@end
```

If `dealloc` is not called properly (e.g., due to a memory leak elsewhere), the observer is never removed. When `someProperty` changes, the `observeValueForKeyPath:` method attempts to access `self` (which might be deallocated), leading to a crash.