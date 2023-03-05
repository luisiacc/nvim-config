import sys
import subprocess

instructions = """
tmux set -g status-style "bg=%(bg)s,fg=%(fg)s,bold"
tmux set -g status-left-style "bg=%(bg)s,fg=%(fg)s"
tmux set -g status-left "#[fg=%(fg)s,bg=%(dbg)s,nobold] ❐ #S #[fg=%(dbg)s,bg=%(bg)s,nobold]⮀"

# Set the window list style
tmux set -g window-status-format "#[fg=colour244] #I ⮁ #[fg=%(fg)s]#W "
tmux set -g window-status-current-format "#[fg=colour255,bold] #I ⮁ #[fg=%(accent)s,bold]#W "
"""

print(sys.argv)
if len(sys.argv) < 5:
    print("Wrong")
    sys.exit(1)


bg, fg, accent, darker_bg = sys.argv[1:]

instructions = instructions % {'bg': bg, 'fg': fg, 'accent': accent, "dbg": darker_bg}

subprocess.run(instructions, shell=True)
