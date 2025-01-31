# Objective-C KVO Memory Management Bug: Observer Removal

This repository demonstrates a common, yet subtle, bug in Objective-C related to Key-Value Observing (KVO) and memory management.  The bug arises from failing to properly remove KVO observers when they are no longer needed, often leading to crashes or unexpected behavior after a delay.

## The Bug

The `bug.m` file contains a simple example of a view controller observing a property of another object.  If the view controller is deallocated before the observer is removed, a crash can occur when the observed property is subsequently changed.

## The Solution

The `bugSolution.m` file shows the corrected code.  The key change is ensuring that the observer is removed in the `-dealloc` method of the view controller.  This prevents the observer from attempting to access memory that might have already been deallocated.

## How to Reproduce

1. Clone this repository.
2. Open the project in Xcode.
3. Run the application (both the buggy and fixed version) to observe the behavior.