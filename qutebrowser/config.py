# load theme from git clone https://github.com/leosolid/qutebrowser-themes ~/.qutebrowser
config.source('themes/onedark.py')

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

c.tabs.position = 'left'
c.tabs.width = 40
c.tabs.favicons.scale = 2.0
c.tabs.padding = {"bottom": 10, "left": 5, "right": 5, "top": 10}
c.tabs.title.format = '{audio}'
c.tabs.indicator.width = 0
