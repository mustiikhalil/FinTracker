### Commands

#### Running app

- bazel (run|build) //:ios --config=i17
- bazel (run|build) //:macos  ## bazel build //App:fintracker_macOS

#### Modules
- bazel mod tidy
- bazel run @swift_package//:resolve
- bazel run @swift_package//:update
- bazel run @swift_package//:update -- flatbuffers
