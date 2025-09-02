# any patches that need to be applied alongside our
# unrealized modules
final: prev: {
  lib =
    prev.lib.extend (final_lib: prev_lib:
      {
        # extend our user defined types into our overlay
        types =
          prev_lib.types // (import ./types {
            # this is final since we're a consumer of lib with this arg, not an extender
            # That gives us the ability to use any of our defined library functions as well
            # within our type definitions
            lib = final_lib;
          });
      });
}
