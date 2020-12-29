entity HelloWorldSim is
end entity;

architecture arc of HelloWorldSim is
begin
  assert false report "Hello world!" severity note;
end architecture;
