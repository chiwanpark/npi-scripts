const CONFIG = {
  baseURI: process.env.FLOOD_BASE_URI || '/',
  dbCleanInterval: 1000 * 60 * 60,
  dbPath: '/home/rtorrent/flood.git/server/db/',
  floodServerHost: '0.0.0.0',
  floodServerPort: 3000,
  maxHistoryStates: 30,
  pollInterval: 1000 * 5,
  secret: process.env.FLOOD_SECRET || 'flood',
  scgi: {
    socket: true,
    socketPath: process.env.RTORRENT_SOCK_PATH || '/home/rtorrent/session/rpc.sock',
  },
  ssl: false
};

module.exports = CONFIG;
