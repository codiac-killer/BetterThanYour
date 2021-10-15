# load theme from git clone https://github.com/dracula/qutebrowser-dracula-theme.git ~/.config/dracula && ln -s ~/.config/dracula ~/.config/BetterThanYour/qutebrowser/themes/dracula
# config.source('themes/dracula')
import themes.dracula.draw

# True allows to load settings configured in autoconfig.yml
config.load_autoconfig(True)

# Aliases for commands. The keys of the given dictionary are the
# aliases, while the values are the commands they map to.
# Type: Dict
c.aliases = {
  'q': 'tab-close',
  'qa': 'quit',
  'w': 'session-save',
  'wq': 'quit --save',
}

c.url.searchengines = {
   'DEFAULT' : 'https://searx.be/search?q={}',
   'osm' : 'https://www.openstreetmap.org/search?query={}',
   'youtube' : 'https://www.youtube.com/results?search_query={}',
}

themes.dracula.draw.blood(c, {
    'spacing': {
        'vertical': 2,
        'horizontal': 8
    }
})

c.tabs.position = 'left'
c.tabs.width = 120
c.tabs.favicons.scale = 2.0
c.tabs.padding = {"bottom": 10, "left": 5, "right": 5, "top": 10}
c.tabs.title.format = '{audio}{current_title}'
c.tabs.indicator.width = 0

