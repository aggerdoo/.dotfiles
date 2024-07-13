{ disks ? [ "/dev/vda" ], ... }: {
  disko.devices = {
    disk = {
      vda = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "gpt";
          #format = "gpt";
          partitions = {
              ESP = {
              start = "1MiB";
              end = "1024MiB";
              #bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
               };
              };
              root = {
              start = "1024MiB";
              end = "100%";
              #part-type = "primary";
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}
