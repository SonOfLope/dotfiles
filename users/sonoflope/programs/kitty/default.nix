{ fontSize, pkgs, ... }:

{
   programs.kitty = {
    enable = true;
    settings = {
      font_size = "11.0";
      font_family      = "FiraCode Nerd Font";
      bold_font        = "auto";
      italic_font      = "auto";
      bold_italic_font = "auto";
      background = "#282a36";
      foreground = "#f8f8f2";
      selection_foreground ="#ffffff";
      selection_background = "#44475a";
      cursor = "#f8f8f2";
      cursor_text_color = "background";
      color0  = "#21222c";
      color1  = "#ff5555";
      color2  = "#50fa7b";
      color3  = "#f1fa8c";
      color4  = "#bd93f9";
      color5  = "#ff79c6";
      color6  = "#8be9fd";
      color7  = "#f8f8f2";
      color8  = "#6272a4";
      color9  = "#ff6e6e";
      color10 = "#50fa7b";
      color11 = "#ffffa5";
      color12 = "#d6acff";
      color13 = "#ff92df";
      color14 = "#a4ffff";
      color15 = "#ffffff";
      # Tab bar colors
      active_tab_foreground = "#282a36";
      active_tab_background = "#f8f8f2";
      inactive_tab_foreground = "#282a36";
      inactive_tab_background = "#6272a4";
      mark1_foreground = "#282a36";
      mark1_background = "#ff5555";
      cursor_beam_thickness = "1.5";
      cursor_underline_thickness = "2.0";
      cursor_blink_interval = "-1";
      scrollback_lines = "2000";
      mouse_hide_wait = "2.0";
      detect_urls = true;
      copy_on_select = false;
      pointer_shape_when_grabbed = "arrow";
      default_pointer_shape = "beam";
      pointer_shape_when_dragging = "beam";
      enable_audio_bell = false;
      remember_window_size =  false;
      initial_window_width = "940";
      initial_window_height = "520";
      window_border_width = "0.1";
      draw_minimal_borders = true;
      window_padding_width = "2";
      hide_window_decorations = true;
      background_opacity = "0.90";
      dim_opacity = "0.80";
    };
  };
}

