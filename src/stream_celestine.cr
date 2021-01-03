require "celestine"
require "kemal"

require "./macros/**"

get "/" do
  svg = Celestine.draw do |ctx|
    ctx.id = "mysvg"
    ctx.height = 100
    ctx.height_units = "%"
    ctx.view_box = {x: 0, y: 0, w: 1000, h: 1000}
  end

  render_layout("view")
end

ws "/" do |socket|
  20.times do |x|
    new_svg = Celestine.draw do |ctx|
      ctx.id = "mysvg"
      ctx.height = 100
      ctx.height_units = "%"
      ctx.view_box = {x: 0, y: 0, w: 1000, h: 1000}

      x.times do |y|
        ctx.rectangle do |r|
          r.x = (y*20*2)
          r.y = (y*20*2)
          r.width = 20
          r.height = 20
          r.fill = (y == (x-1) ? "blue" : "red")
          r
        end
      end
    end
    socket.send new_svg

    sleep 1
  end

  socket.close
end
Kemal.config.port = ARGV.size == 0 ? 3000 : ARGV[0].to_i
Kemal.run
