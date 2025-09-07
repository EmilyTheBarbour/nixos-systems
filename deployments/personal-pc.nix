{
  machine.name = "personal-pc";
  # custom modules to extend beyond the core config provided by this framework
  # Generally these are options that are hyper specific to an actual, physical realization
  # of a device, such as HW Ids, etc.
  modules = [
    ({ parameters, ... }: {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/dbc71064-c4f8-47be-9598-cb70a9372d7c";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/7EC9-C87C";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

      swapDevices = [ ];

      # TODO(emily): The home-manager module seems to be in its infancy so we'll probably want to figure
      # out how to do this external to my repository without having to "reopen" the vault every time you
      # open the app
      home-manager.users.${parameters.users.main-user.user-name}.programs.obsidian.vaults.robotics = {
        enable = true;
        target = "Documents/robotics";
      };
    })
  ];
}
