#!/usr/bin/env python3
import gi
import subprocess
import json
import os
from pathlib import Path

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, Gdk, Pango

class PowerMenu(Gtk.Window):
    def __init__(self):
        super().__init__(title="Power Menu")
        
        # Load Pywal colors
        self.pywal_colors = self.load_pywal_colors()
        
        # Set window properties
        self.set_default_size(320, 450)
        self.set_border_width(15)
        self.set_position(Gtk.WindowPosition.CENTER)
        self.set_resizable(False)
        self.set_decorated(False)
        self.set_skip_taskbar_hint(True)
        
        # Apply Pywal colors
        self.apply_colors()
        
        # Create main box
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=12)
        self.add(self.box)
        
        # Add header
        self.add_header()
        
        # Add buttons with different color accents
        self.add_button("  Lock", self.lock, color_idx=1)
        self.add_button("  Logout", self.logout, color_idx=2)
        self.add_button("  Reboot", self.reboot, color_idx=3)
        self.add_button("  Shutdown", self.shutdown, color_idx=4)
        self.add_button("  Cancel", self.close, color_idx=5)
        
    def load_pywal_colors(self):
        """Load Pywal colors from colors.json"""
        colors_file = Path(os.path.expanduser("~/.cache/wal/colors.json"))
        if colors_file.exists():
            with open(colors_file) as f:
                return json.load(f)
        return None
    
    def hex_to_rgb(self, hex_color):
        """Convert hex color to RGB values (0-1 range)"""
        hex_color = hex_color.lstrip('#')
        return tuple(int(hex_color[i:i+2], 16)/255 for i in (0, 2, 4))
    
    def apply_colors(self):
        """Apply Pywal colors to the window with varied color usage"""
        if not self.pywal_colors:
            return
            
        # Get colors
        bg_color = self.hex_to_rgb(self.pywal_colors['special']['background'])
        fg_color = self.hex_to_rgb(self.pywal_colors['special']['foreground'])
        colors = [self.hex_to_rgb(c) for c in self.pywal_colors['colors'].values()]
        
        # Create CSS with GTK3-compatible properties
        css = f"""
        window {{
            background-color: rgba({bg_color[0]*255}, {bg_color[1]*255}, {bg_color[2]*255}, 0.95);
            border-radius: 15px;
            border: 2px solid rgba({colors[0][0]*255}, {colors[0][1]*255}, {colors[0][2]*255}, 0.4);
            box-shadow: 0 4px 20px 4px rgba(0, 0, 0, 0.3);
        }}
        
        .header {{
            color: rgba({fg_color[0]*255}, {fg_color[1]*255}, {fg_color[2]*255}, 0.9);
            font-size: 18px;
            margin-bottom: 15px;
        }}
        
        button {{
            background-color: rgba({bg_color[0]*255}, {bg_color[1]*255}, {bg_color[2]*255}, 0.7);
            color: rgba({fg_color[0]*255}, {fg_color[1]*255}, {fg_color[2]*255}, 1);
            border-radius: 8px;
            padding: 12px;
            font-size: 16px;
            transition: background-color 0.2s ease;
            border: none;
            outline: none;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }}
        
        button:hover {{
            background-color: rgba({colors[0][0]*255}, {colors[0][1]*255}, {colors[0][2]*255}, 0.3);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }}
        
        .color1 {{ border-left: 5px solid rgba({colors[0][0]*255}, {colors[0][1]*255}, {colors[0][2]*255}, 0.8); }}
        .color2 {{ border-left: 5px solid rgba({colors[1][0]*255}, {colors[1][1]*255}, {colors[1][2]*255}, 0.8); }}
        .color3 {{ border-left: 5px solid rgba({colors[2][0]*255}, {colors[2][1]*255}, {colors[2][2]*255}, 0.8); }}
        .color4 {{ border-left: 5px solid rgba({colors[3][0]*255}, {colors[3][1]*255}, {colors[3][2]*255}, 0.8); }}
        .color5 {{ border-left: 5px solid rgba({colors[4][0]*255}, {colors[4][1]*255}, {colors[4][2]*255}, 0.8); }}
        """
        
        provider = Gtk.CssProvider()
        provider.load_from_data(css.encode())
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )
    
    def add_header(self):
        """Add a styled header to the menu"""
        header = Gtk.Label(label="Power Options")
        header.set_name("header")
        header.set_justify(Gtk.Justification.CENTER)
        
        # Set font weight
        attr = Pango.AttrList()
        attr.insert(Pango.AttrWeight.new(Pango.Weight.BOLD))
        header.set_attributes(attr)
        
        self.box.pack_start(header, False, False, 0)
    
    def add_button(self, label, callback, color_idx):
        """Add a styled button with specific color accent"""
        button = Gtk.Button(label=label)
        button.connect("clicked", callback)
        button.set_name(f"color{color_idx}")
        
        # Add some margin
        button.set_margin_bottom(5)
        
        self.box.pack_start(button, True, True, 0)
    
    def lock(self, button):
        """Lock the screen using hyprlock"""
        subprocess.Popen(["hyprlock"])
        self.close()
    
    def shutdown(self, button):
        """Shutdown the system"""
        subprocess.Popen(["systemctl", "poweroff"])
        self.close()
    
    def reboot(self, button):
        """Reboot the system"""
        subprocess.Popen(["systemctl", "reboot"])
        self.close()
    
    def logout(self, button):
        """Logout from the session"""
        subprocess.Popen(["loginctl", "terminate-user", os.getenv("USER")])
        self.close()
    
    def close(self, button=None):
        """Close the window"""
        Gtk.main_quit()

if __name__ == "__main__":
    win = PowerMenu()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
