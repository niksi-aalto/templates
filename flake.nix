{
  description = "A collection of Niksi devcontainer templates";

  outputs = _: {
    templates = {
      scala = {
        path = ./scala;
        description = "Niksi Scala devcontainer";
      };
    };
  };
}
