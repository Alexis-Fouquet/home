{ ... }:
{
  xsession.windowManager.i3 = {
    enable = false;
  };
  xsession.windowManager.i3.config = {
    assigns = {
      "1" = [ { class = "^Firefox$"; } ];
    };
  };
}
