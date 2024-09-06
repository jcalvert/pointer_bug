require 'ffi'
require 'objspace'
require 'get_process_mem'
module LibC
  extend FFI::Library
  ffi_lib FFI::Library::LIBC

  attach_function :malloc, [:size_t], :pointer
  attach_function :free, [:pointer], :void
end
10_000_000.times do
  buffer = LibC.malloc 100
  buffer.write_string("foo")
  LibC.free(buffer)
end
GC.start
puts "GC stats"
puts GC.stat
puts "-------------"
puts "memsize: #{GetProcessMem.new.mb}Mb"
