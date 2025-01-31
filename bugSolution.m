The solution is to reliably remove the observer in the `-dealloc` method of the view controller.  Consider using `removeObserver:forKeyPath:` within a `@try...@catch` block to handle potential exceptions in cases where the observer might already be removed or the observed object is already deallocated.

```objectivec
- (void)dealloc {
    @try {
        [self.observedObject removeObserver:self forKeyPath:@"someProperty"];
    } @catch (NSException *exception) {
        // Handle the exception gracefully (log it, etc.)
    }
    // ... other deallocation tasks ...
}
```

Alternatively, use a weak reference to the observed object or employ associated objects to manage the observer's lifecycle more effectively.  This provides a robust solution and prevents potential crashes related to the improper removal of KVO observers.