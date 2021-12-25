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
   'yewtube' : 'https://yewtu.be/search?q={}',
   'invidious' : 'https://youtube.076.ne.jp/search?q={}',
}

c.tabs.position = 'left'
c.tabs.width = 120
c.tabs.favicons.scale = 2.0
c.tabs.padding = {"bottom": 10, "left": 5, "right": 5, "top": 10}
c.tabs.title.format = '{audio}{current_title}'
c.tabs.indicator.width = 0

config.bind('h', 'scroll left')
config.bind('t', 'scroll down')
config.bind('n', 'scroll up')
config.bind('s', 'scroll right')

config.bind('H', 'back')
config.bind('N', 'tab-prev')
config.bind('T', 'tab-next')
config.bind('S', 'forward')

config.bind('l', 'search-next')
config.bind('L', 'search-prev')

config.bind('e', 'hint all')
