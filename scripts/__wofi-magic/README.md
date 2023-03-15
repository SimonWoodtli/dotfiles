# Wofi Magic

> ⚠️  The setup script only creates symlinks to your /bin for each script. You have to create a keyboard shortcut manually depending on your distro/window manager. For Gnome just go to 'Settings' 'Keyboard' 'View and Customize Shortcuts' 'Custom Shortcuts'

* The idea of these scripts is to run them with a keyboard shortcut. They aren't meant to be confined within the terminal. So they can be used globally like all the other 'Settings' 'Keyboard' 'Shortcuts' can. 
* Don't use these scripts in your terminal as wofi is a GUI app, fzf would be way better for that. Only use them together with keyboard shortcuts

## Bookmarks: bm-gui scripts

> 🧐 Useful in a GUI Browser to write into your address bar: Ctrl-L followed by the keyboard shortcut that you defined to run the script

Bookmark scripts that allow you to select your bookmarks with wofi. And then Paste the content to your currently active window with dotool. If you don't use wayland I suggest to use xdotool and dmenu to get the same result.

* You also need to create the database files: `touch ~/Private/bookmarks/bookmarksWork` and add your links in there and if you want some tags.

example of bookmarksWork:

```
https://github.com/simonwoodtli
https://github.com/simonwoodtli/zet #zet #knowledge #notes #zettelkasten
```

> 🧐 If you need to use w3m/lynx terminal browsers checkout my dotfiles/scripts/bmw script it uses fzf instead of wofi but does the same thing.
