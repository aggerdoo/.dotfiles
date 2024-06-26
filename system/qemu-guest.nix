# Common configuration for virtual machines running under QEMU (using virtio).

{ config, lib, ... }:

{
  boot.initrd.availableKernelModules = [ "virtio_net" "virtio_mmio" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ];
  boot.initrd.kernelModules = [ "virtio_balloon" "virtio_console" "virtio_rng" ];

  boot.initrd.postDeviceCommands = lib.mkIf (!config.boot.initrd.systemd.enable)
    ''
     # set system clock time from hardware clock to work around a bug in qemu-kvm 1.5.2 (where the vm clock is initialized to the *boot time* of the host).
     hwclock -s
    '';
}
