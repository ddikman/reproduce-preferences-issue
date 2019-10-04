# test_with_preference_service

Reproduce test issue using the flutter [preference](https://pub.dev/packages/preferences) lib.

When using the [preferences](https://pub.dev/packages/preferences) library I found an issue where the test simply halted. I believe this is due to a scoped model waiting for the `init` method to complete causing the building of the widgets to halt indefinitely.

In this example repo it looks as though the preferences simply does not load, it halts and the future never finishes whilst what I expect is to at least get the same issue as the test failing due to missing implementation.