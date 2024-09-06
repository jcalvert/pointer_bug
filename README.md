# Sample repo showing Ruby bug not freeing Data_Make_Struct

This minimal reproduction uses FFI because that's how I found it and writing my own C function to call `Data_Make_Struct` with a default allocator seems excessive.

FFI 1.15.5 is used because in later revisions `Data_Make_Struct` is replaced with `TypedData_Make_Struct` - the bug is that the Ruby GC process does not call `xfree` on non-Typed data structs that use the default free function (`-1`)

## Instructions
`bundle install`
`bundle exec ruby pointer_bug.rb`

Run with Ruby 3.3.5 prints `memsize: 496.2578125Mb` (obviously not exact every time)
with 3.2.4 - `memsize: 24.68359375Mb` 


