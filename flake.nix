{
  description = "A collection of Niksi devcontainer templates";

  outputs = _: {
    templates = {
      plain = {
        path = ./plain;
        description = "Niksi barebones devcontainer";
      };
      scala = {
        path = ./scala;
        description = "Niksi Scala devcontainer";
      };
    };
  };
}
