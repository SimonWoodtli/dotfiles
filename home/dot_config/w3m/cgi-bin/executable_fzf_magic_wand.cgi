#!/bin/bash
# dependencies: fzf coreutils
declare newL=$'\n' #insert new line: multi line also works like:
#echo -e "Hello World\n===========\n" but only on linux
#here documents like`cat <<EOF...EOF` need to be defined at once
#incremental variable changes that offer \n cannot be used like that
_main() {
  local buffer=/tmp/w3m-buffer
  # clear screen
  printf "\033c"
  # not running tmux
  if [[ -z "$TMUX" || -z "$TERM_PROGRAM" ]] ; then
    local selectLine="$(_glossary | sort -t '@' -k2 | column -t  -s '#' \
      | fzf --no-preview -i -e --delimiter '@' --with-nth 2.. \
      --prompt='w3m-magic [$func|&custom|*fav]: ' \
      --info=default --layout=reverse --tiebreak=index)"
    local selectScript="$(echo "$selectLine" | awk '{print $1}')"
    local selectVariable="$(echo "$selectLine" | awk '{print $3}')"
    local selection="$selectScript"${newL}"$selectVariable"
  # tmux -ge 3.2 popup
  elif [[ "$TERM_PROGRAM" = tmux ]] ; then
    local selectLine="$(_glossary | sort -t '@' -k2 | column -t  -s '#' \
      | fzf-tmux --no-preview -p -w 80% -h 70% -i -e --delimiter '@' --with-nth 2.. \
      --prompt='w3m-magic [$func|&custom|*fav]: ' \
      --info=default --layout=reverse --tiebreak=index)"
    local selectScript="$(echo "$selectLine" | awk '{print $1}')"
    local selectVariable="$(echo "$selectLine" | awk '{print $3}')"
    local selection="$selectScript"${newL}"$selectVariable"
  # tmux -lt 3.2 regular split
  elif [[ -n "$TMUX" ]] ; then
    local selectLine="$(_glossary | sort -t '@' -k2 | column -t  -s '#' \
      | fzf-tmux --no-preview -i -e --delimiter '@' --with-nth 2.. \
      --prompt='w3m-magic [$func|&custom|*fav]: ' \
      --info=default --layout=reverse --tiebreak=index)"
    local selectScript="$(echo "$selectLine" | awk '{print $1}')"
    local selectVariable="$(echo "$selectLine" | awk '{print $3}')"
    local selection="$selectScript"${newL}"$selectVariable"
  fi
  _writeBuffer
}
_writeBuffer() {
  ##if $selection is empty
  [[ -z "$selection" ]] && echo "" > "$buffer" && exit
  echo "$selection" > "$buffer"
}
_glossary() {
# $ = built-in functions ; & = custom ; * = favorites
#
#__set_user_agent.cgi#@SET_USER_AGENT&#linux#-- Set user agent string linux         
# #= delimiter
#1. script name 2. #@function name# 3. #custom variable# 4. -- description
cat <<EOF
ABORT#@ABORT\$#-- Quit at once
ACCESSKEY#@ACCESSKEY\$#-- Pop up accesskey menu
ADD_BOOKMARK#@ADD_BOOKMARK\$#-- Add current page to bookmarks
ALARM#@ALARM\$#-- Set alarm
BACK#@BACK\$#-- Close current buffer and return to the one below in stack
BEGIN#@BEGIN\$#-- Go to the first line
BOOKMARK#@BOOKMARK\$#-- View bookmarks
CENTER_H#@CENTER_H\$#-- Center on cursor column
CENTER_V#@CENTER_V\$#-- Center on cursor line
CHARSET#@CHARSET\$#-- Change the character encoding for the current document
CLOSE_TAB#@CLOSE_TAB\$#-- Close tab
CLOSE_TAB_MOUSE#@CLOSE_TAB_MOUSE\$#-- Close tab at mouse pointer
COMMAND#@COMMAND\$#-- Invoke w3m function(s)
COOKIE#@COOKIE\$#-- View cookie list
CURSOR_TOP#@CURSOR_TOP\$#-- Move cursor to the top line on the screen
CURSOR_MIDDLE#@CURSOR_MIDDLE\$#-- Move cursor to the middle line on the screen
CURSOR_BOTTOM#@CURSOR_BOTTOM\$#-- Move cursor to the bottom line on the screen
DEFAULT_CHARSET#@DEFAULT_CHARSET\$#-- Change the default character encoding
DEFINE_KEY#@DEFINE_KEY\$#-- Define a binding between a key stroke combination and a command
DELETE_PREVBUF#@DELETE_PREVBUF\$#-- Delete previous buffer (mainly for local CGI-scripts)
DICT_WORD#@DICT_WORD\$#-- Execute dictionary command (see README.dict)
DICT_WORD_AT#@DICT_WORD_AT\$#-- Execute dictionary command for word at cursor
DISPLAY_IMAGE#@DISPLAY_IMAGE\$#-- Restart loading and drawing of images
DOWN#@DOWN\$#-- Scroll the screen down one line
DOWNLOAD#@DOWNLOAD\$#-- Save document html sourcecode
DOWNLOAD_LIST#@DOWNLOAD_LIST\$#-- Display downloads panel
EDIT#@EDIT\$#-- Edit local source
EDIT_SCREEN#@EDIT_SCREEN\$#-- Edit rendered copy of document
END#@END\$#-- Go to the last line
EXEC_SHELL#@EXEC_SHELL\$#-- Execute shell command and display output
EXIT#@EXIT\$#-- Quit at once
EXTERN#@EXTERN\$#-- Display using an external browser
EXTERN_LINK#@EXTERN_LINK\$#-- Display target using an external browser
FRAME#@FRAME\$#-- Toggle rendering HTML frames
GOTO#@GOTO\$*#-- Open specified document in a new buffer
GOTO_HOME#@GOTO_HOME\$#-- Return to the homepage (specified HTTP_HOME or WWW_HOME variable)
GOTO_LINE#@GOTO_LINE\$#-- Go to the specified line
GOTO_LINK#@GOTO_LINK\$#-- Follow current hyperlink in a new buffer
GOTO_RELATIVE#@GOTO_RELATIVE\$#-- Go to relative address
HELP#@HELP\$#-- Show help panel
HISTORY#@HISTORY\$#-- Show browsing history
INFO#@INFO\$#-- Display information about the current document
INTERRUPT#@INTERRUPT\$#-- Suspend w3m to background
ISEARCH#@ISEARCH\$#-- Incremental search forward
ISEARCH_BACK#@ISEARCH_BACK\$#-- Incremental search backward
LEFT#@LEFT\$#-- Shift screen one column left
LINE_BEGIN#@LINE_BEGIN\$#-- Go to the beginning of the line
LINE_END#@LINE_END\$#-- Go to the end of the line
LINE_INFO#@LINE_INFO\$#-- Display current position in document
LINK_BEGIN#@LINK_BEGIN\$#-- Move to the first hyperlink
LINK_END#@LINK_END\$#-- Move to the last hyperlink
LINK_MENU#@LINK_MENU\$#-- Pop up link element menu
LIST#@LIST\$*#-- Show all URLs referenced
LIST_MENU#@LIST_MENU\$#-- Pop up menu for hyperlinks to browse to
LOAD#@LOAD\$#-- Open local file in a new buffer
MAIN_MENU#@MAIN_MENU\$#-- Pop up menu
MARK#@MARK\$#-- Set/unset mark
MARK_MID#@MARK_MID\$#-- Turn Message-ID-like strings into hyperlinks
MARK_URL#@MARK_URL\$#-- Turn URL-like strings into hyperlinks
MARK_WORD#@MARK_WORD\$#-- Turn current word into hyperlink
MENU#@MENU\$#-- Pop up menu
MENU_MOUSE#@MENU_MOUSE\$#-- Pop up menu at mouse pointer
MOUSE_TOGGLE#@MOUSE_TOGGLE\$#-- Toggle mouse support
MOVE_DOWN#@MOVE_DOWN\$#-- Cursor down
MOVE_DOWN1#@MOVE_DOWN1\$#-- Cursor down. With edge touched, slide
MOVE_LEFT#@MOVE_LEFT\$#-- Cursor left
MOVE_LEFT1#@MOVE_LEFT1\$#-- Cursor left. With edge touched, slide
MOVE_LIST_MENU#@MOVE_LIST_MENU\$*#-- Pop up menu to navigate between hyperlinks
MOVE_MOUSE#@MOVE_MOUSE\$#-- Move cursor to mouse pointer
MOVE_RIGHT#@MOVE_RIGHT\$#-- Cursor right
MOVE_RIGHT1#@MOVE_RIGHT1\$#-- Cursor right. With edge touched, slide
MOVE_UP#@MOVE_UP\$#-- Cursor up
MOVE_UP1#@MOVE_UP1\$#-- Cursor up. With edge touched, slide
MSGS#@MSGS\$#-- Display error messages
NEW_TAB#@NEW_TAB\$#-- Open a new tab (with current document)
NEXT#@NEXT\$#-- Switch to the next buffer
NEXT_DOWN#@NEXT_DOWN\$#-- Move downward to the next hyperlink
NEXT_HALF_PAGE#@NEXT_HALF_PAGE\$#-- Scroll down half a page
NEXT_LEFT#@NEXT_LEFT\$#-- Move left to the next hyperlink
NEXT_LEFT_UP#@NEXT_LEFT_UP\$#-- Move left or upward to the next hyperlink
NEXT_LINK#@NEXT_LINK\$#-- Move to the next hyperlink
NEXT_MARK#@NEXT_MARK\$#-- Go to the next mark
NEXT_PAGE#@NEXT_PAGE\$#-- Scroll down one page
NEXT_RIGHT#@NEXT_RIGHT\$#-- Move right to the next hyperlink
NEXT_RIGHT_DOWN#@NEXT_RIGHT_DOWN\$#-- Move right or downward to the next hyperlink
NEXT_TAB#@NEXT_TAB\$#-- Switch to the next tab
NEXT_UP#@NEXT_UP\$#-- Move upward to the next hyperlink
NEXT_VISITED#@NEXT_VISITED\$#-- Move to the next visited hyperlink
NEXT_WORD#@NEXT_WORD\$#-- Move to the next word
NOTHING#@NOTHING\$#-- Do nothing
NULL#@NULL\$#-- Do nothing
OPTIONS#@OPTIONS\$#-- Display options setting panel
PEEK#@PEEK\$#-- Show current address
PEEK_IMG#@PEEK_IMG\$#-- Show image address
PEEK_LINK#@PEEK_LINK\$#-- Show target address
PIPE_BUF#@PIPE_BUF\$#-- Pipe current buffer through a shell command and display output
PIPE_SHELL#@PIPE_SHELL\$#-- Execute shell command and display output
PREV#@PREV\$#-- Switch to the previous buffer
PREV_HALF_PAGE#@PREV_HALF_PAGE\$#-- Scroll up half a page
PREV_LINK#@PREV_LINK\$#-- Move to the previous hyperlink
PREV_MARK#@PREV_MARK\$#-- Go to the previous mark
PREV_PAGE#@PREV_PAGE\$#-- Scroll up one page
PREV_TAB#@PREV_TAB\$#-- Switch to the previous tab
PREV_VISITED#@PREV_VISITED\$#-- Move to the previous visited hyperlink
PREV_WORD#@PREV_WORD\$#-- Move to the previous word
PRINT#@PRINT\$#-- Save rendered document
QUIT#@QUIT\$#-- Quit with confirmation request
READ_SHELL#@READ_SHELL\$#-- Execute shell command and display output
REDO#@REDO\$#-- Cancel the last undo
REDRAW#@REDRAW\$#-- Draw the screen anew
REG_MARK#@REG_MARK\$#-- Mark all occurences of a pattern
REINIT#@REINIT\$#-- Reload configuration file
RELOAD#@RELOAD\$#-- Load current document anew
RESHAPE#@RESHAPE\$#-- Re-render document
RIGHT#@RIGHT\$#-- Shift screen one column right
SAVE#@SAVE\$#-- Save document source
SAVE_IMAGE#@SAVE_IMAGE\$#-- Save inline image
SAVE_LINK#@SAVE_LINK\$#-- Save hyperlink target
SAVE_SCREEN#@SAVE_SCREEN\$#-- Save rendered document
SEARCH#@SEARCH\$#-- Search forward
SEARCH_BACK#@SEARCH_BACK\$#-- Search backward
SEARCH_FORE#@SEARCH_FORE\$#-- Search forward
SEARCH_NEXT#@SEARCH_NEXT\$#-- Continue search forward
SEARCH_PREV#@SEARCH_PREV\$#-- Continue search backward
SELECT#@SELECT\$#-- Display buffer-stack panel
SELECT_MENU#@SELECT_MENU\$*#-- Pop up buffer-stack menu
SETENV#@SETENV\$#-- Set environment variable
SET_OPTION#@SET_OPTION\$#-- Set option
SHELL#@SHELL\$#-- Execute shell command and display output
SHIFT_LEFT#@SHIFT_LEFT\$#-- Shift screen left
SHIFT_RIGHT#@SHIFT_RIGHT\$#-- Shift screen right
SOURCE#@SOURCE\$#-- Toggle between HTML shown or processed
STOP_IMAGE#@STOP_IMAGE\$#-- Stop loading and drawing of images
SUBMIT#@SUBMIT\$#-- Submit form
SUSPEND#@SUSPEND\$#-- Suspend w3m to background
TAB_GOTO#@TAB_GOTO\$*#-- Open specified document in a new tab
TAB_GOTO_RELATIVE#@TAB_GOTO_RELATIVE\$#-- Open relative address in a new tab
TAB_LEFT#@TAB_LEFT\$#-- Move left along the tab bar
TAB_LINK#@TAB_LINK\$#-- Follow current hyperlink in a new tab
TAB_MENU#@TAB_MENU\$*#-- Pop up tab selection menu
TAB_MOUSE#@TAB_MOUSE\$#-- Select tab by mouse action
TAB_RIGHT#@TAB_RIGHT\$#-- Move right along the tab bar
UNDO#@UNDO\$#-- Cancel the last cursor movement
UP#@UP\$#-- Scroll the screen up one line
VERSION#@VERSION\$#-- Display the version of w3m
VIEW#@VIEW\$#-- Toggle between HTML shown or processed
VIEW_BOOKMARK#@VIEW_BOOKMARK\$#-- View bookmarks
VIEW_IMAGE#@VIEW_IMAGE\$#-- Display image in viewer
WHEREIS#@WHEREIS\$#-- Search forward
WRAP_TOGGLE#@WRAP_TOGGLE\$#-- Toggle wrapping mode in searches
/usr/share/doc/w3m/doc/README#@README_INTRO&#-- Readme intro page
/usr/share/doc/w3m/doc/README.cookie#@README_COOKIE&#-- Readme cookie page
/usr/share/doc/w3m/doc/README.cygwin#@README_CYGWIN&#-- Readme cygwin page
/usr/share/doc/w3m/doc/README.dict#@README_DICT&#-- Readme dictionary page
/usr/share/doc/w3m/doc/README.func#@README_FUNC&#-- Readme function page
/usr/share/doc/w3m/doc/README.img#@README_IMG&#-- Readme inline image page
/usr/share/doc/w3m/doc/README.m17n#@README_M17N&#-- Readme muntilingualizaion page
/usr/share/doc/w3m/doc/README.mouse#@README_MOUSE&#-- Readme mouse page
/usr/share/doc/w3m/doc/README.passwd#@README_PASSWD&#-- Readme password page
/usr/share/doc/w3m/doc/README.pre_form#@README_PRE_FORM&#-- Readme pre-fill form page
/usr/share/doc/w3m/doc/README.siteconf#@README_SITECONF&#-- Readme siteconf page
/usr/share/doc/w3m/doc/README.sixel#@README_SIXEL&#-- Readme sixel image page
/usr/share/doc/w3m/doc/README.tab#@README_TAB&#-- Readme tab browsing page
/usr/share/doc/w3m/doc/FAQ.html#@README_FAQ&#-- Readme FAQ page
/usr/share/doc/w3m/doc/MANUAL.html#@README_MANUAL&#-- Readme manual page
/usr/share/doc/w3m/doc/STORY.html#@README_STORY&#-- Readme story history of W3M page
__open_video.cgi#@OPEN_VIDEO&*#-- Open video link at cursor with mpv
__open_image.cgi#@OPEN_IMAGE&*#-- Open image link at cursor with mpv
__open_browser_link.cgi#@OPEN_BROWSER_LINK&#-- Open link at cursor in external browser ($BROWSER)
__open_browser_page.cgi#@OPEN_BROWSER_PAGE&#-- Open page URL in external browser ($BROWSER)
__download_link.cgi#@DOWNLOAD_LINK&*#-- Download link at cursor with wget
__download_youtube.cgi#@DOWNLOAD_YOUTUBE&*#-- Download youtube link at cursor with youtube-dl
__click_next.cgi#@CLICK_NEXT&#-- Click next page button 'Next'
__click_prev.cgi#@CLICK_PREV&#-- Click previous page button 'Previous'
__click_next_arrow.cgi#@CLICK_NEXT_ARROW&#-- Click next page button '>'
__click_prev_arrow.cgi#@CLICK_PREV_ARROW&#-- Click previous page button '<'
__closetab_stash.cgi#@CLOSE_TAB_STASH&#-- Close tab (Stash URL to ~/.config/w3m/RestoreTab.txt)
__dict_curl.cgi#@DICT_WORD_CURL&#-- Online dictionary for word at cursor
__display_borders.cgi#@BORDERS&#-- Toggle table boarders
__display_image.cgi#@DISPLAY_IMAGE_TOGGLE&#-- Toggle display image
__display_link_number.cgi#@LINK_NUMBER&#-- Toggle link number (hinting mode e.g press 3[ to jump to link 3)
__edit_bookmark.cgi#@EDIT_BOOKMARK&#-- Edit bookmark
__edit_config.cgi#@EDIT_CONFIG&#-- Edit W3M configuration
__edit_keymap.cgi#@EDIT_KEYMAP&#-- Edit W3M keymap
__edit_mailcap.cgi#@EDIT_MAILCAP&#-- Edit W3M mailcap
__edit_menu.cgi#@EDIT_MENU&#-- Edit W3M context menu
__edit_restoretab.cgi#@EDIT_RESTORETAB&#-- Edit W3M restoretab ~/.config/w3m/RestoreTab.txt
__edit_siteconf.cgi#@EDIT_SITECONF&#-- Edit W3M siteconf
__edit_urimethodmap.cgi#@EDIT_URIMETHODMAP&#-- Edit W3M urimethodmap
__search_1337x.cgi#@SEARCH_1337X&*#-- Search 1337x for torrents
__search_commandlinefu.cgi#@SEARCH_CMDFU&#-- Search for commandline one liners via commandlinefu
__search_duckduckgo.cgi#@SEARCH_DDG&*#-- Search the web via duckduckgo
__search_geminispace.cgi#@SEARCH_GEMSPC&#-- Search gemini capsules via geminispace
__search_google.cgi#@SEARCH_GOOGLE&*#-- Search the web via google
__search_invidious.cgi#@SEARCH_INVIDIOUS&#-- Search youtube videos via invidious
__search_nyaasi.cgi#@SEARCH_NYAASI&#-- Search nyaa for anime torrents
__search_piratebay.cgi#@SEARCH_TPB&*#-- Search piratebay for torrents
__search_veronica2.cgi#@SEARCH_V2&#-- Search gopherspace via veronica-2
__search_wikipedia.cgi#@SEARCH_WIKIPEDIA&#-- Search wikipedia for articles
__search_xdcceu.cgi#@SEARCH_XDCCEU&*#-- Search xdcceu for xdcc (irc dcc files)
__goto_tmux_clipboard.cgi#@GOTO_CLIP_TMUX&&#-- Paste URL and go (via tmux clipboard)
__goto_w3m_clipboard.cgi#@GOTO_CLIP_W3M&#-- Paste URL and go (via W3M clipboard /tmp/clipbrd.txt)
__goto_x11_clipboard.cgi#@GOTO_CLIP_X11&#-- Paste URL and go (via xsel X11 clipboard)
__readerview_rdrview.cgi#@RDRVIEW_RDRVIEW&*#-- Reader view using rdrview (c/c++)
__readerview_readability.cgi#@RDRVIEW_READABILITY&#-- Reader view using go-readability (golang)
__restore_tab.cgi#@RESTORE_TAB&#-- Restore tab from ~/.config/w3m/RestoreTab.txt
__save_session.cgi#@SAVE_SESSION&*#-- Save session and ask to quit (run 'w3mlastsession' command to restore)
__show_input_line_editing_mode_key_binding.cgi#@LIST_EDIT_MODE_KEY&#-- Show input editing mode key binding
__show_user_defined_key_binding.cgi#@LIST_DEFINED_KEY&*#-- Show user custom key binding
__toggle_color.cgi#@COLOR&#-- Toggle color
__toggle_line_number.cgi#@LINE_NUMBER&*#-- Toggle line number
__treat_url_like_strings.cgi#@TREAT_URL&*#-- Toggle plain text to clickable link
__clear_user_agent.cgi#@CLEAR_USER_AGENT&#-- Clear user agent string
__set_user_agent.cgi#@SET_USER_AGENT&#amazon_4k_firetv#-- Set user agent string amazon_4k_firetv
__set_user_agent.cgi#@SET_USER_AGENT&#amazon_kindle_3_ereader#-- Set user agent string amazon_kindle_3_ereader
__set_user_agent.cgi#@SET_USER_AGENT&#amazon_kindle_4_ereader#-- Set user agent string amazon_kindle_4_ereader
__set_user_agent.cgi#@SET_USER_AGENT&#android_browser#-- Set user agent string android_browser
__set_user_agent.cgi#@SET_USER_AGENT&#blackberry#-- Set user agent string blackberry
__set_user_agent.cgi#@SET_USER_AGENT&#chromebook#-- Set user agent string chromebook
__set_user_agent.cgi#@SET_USER_AGENT&#chromecast#-- Set user agent string chromecast
__set_user_agent.cgi#@SET_USER_AGENT&#linux#-- Set user agent string linux         
__set_user_agent.cgi#@SET_USER_AGENT&#macosx_10_15#-- Set user agent string macosx_10_15
__set_user_agent.cgi#@SET_USER_AGENT&#ios_12#-- Set user agent string ios_12       
__set_user_agent.cgi#@SET_USER_AGENT&#nintendo_3ds#-- Set user agent string nintendo_3ds
__set_user_agent.cgi#@SET_USER_AGENT&#nintendo_wii_u#-- Set user agent string nintendo_wii_u
__set_user_agent.cgi#@SET_USER_AGENT&#nvidia_shield_tablet_k1#-- Set user agent string nvidia_shield_tablet_k1
__set_user_agent.cgi#@SET_USER_AGENT&#opera_mini#-- Set user agent string opera_mini
__set_user_agent.cgi#@SET_USER_AGENT&#opera_mobile_11.10#-- Set user agent string opera_mobile_11.10
__set_user_agent.cgi#@SET_USER_AGENT&#playstation_4#-- Set user agent string playstation_4
__set_user_agent.cgi#@SET_USER_AGENT&#playstation_vita_psvita#-- Set user agent string playstation_vita_psvita
__set_user_agent.cgi#@SET_USER_AGENT&#roku_ultra#-- Set user agent string roku_ultra
__set_user_agent.cgi#@SET_USER_AGENT&#safari#-- Set user agent string safari    
__set_user_agent.cgi#@SET_USER_AGENT&#samsung_galaxy_tab_s3#-- Set user agent string samsung_galaxy_tab_s3
__set_user_agent.cgi#@SET_USER_AGENT&#windows_10#-- Set user agent string windows_10
__set_user_agent.cgi#@SET_USER_AGENT&#windows_7#-- Set user agent string windows_7
__set_user_agent.cgi#@SET_USER_AGENT&#xbox_one#-- Set user agent string xbox_one
__set_user_agent.cgi#@SET_USER_AGENT&#xbox_one_s#-- Set user agent string xbox_one_s
__yank_current_link.cgi#@YANK_LINK&*#-- Copy link at cursor to clipboard
__yank_page_url.cgi#@YANK_URL&*#-- Copy page URL to clipboard
~/Downloads#@DIR_DL&#-- Open ~/Downloads directory
/media#@DIR_MEDIA&#-- Open /media directory
EOF
}
_main
