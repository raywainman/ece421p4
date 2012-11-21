require "xmlrpc/server"

class Server
  def initialize(port, game_type, players)
    @game = Game.new(game_type, players)
    @server = XMLRPC::Server.new(port)
    @server.add_handler("")
    @server.serve()
  end
end