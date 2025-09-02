{ lib, ... }: {
  machineType =
    lib.types.enum [
      "dell-precision-5690"

      # user consents to having a special machine that hasn't been integrated
      # with yet, and that they will maintain that specifically for themselves
      "custom"
    ];
}
