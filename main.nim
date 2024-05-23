import boxy, opengl, windy

let windowSize = ivec2(1280, 800)

let window = newWindow("Regnum Incognita", windowSize)
makeContextCurrent(window)

loadExtensions()

let bxy = newBoxy()

#bxy.addImage("bg", readImage("examples/data/bg.png"))

var frame: int

var
    player_pos = windowSize.vec2 / 2
    player_size = vec2(100, 100)
    player_velocity = vec2(0, 0)

proc process() =
    player_pos += player_velocity

proc display() =
    bxy.beginFrame(windowSize)

    # Draw the bg.
    #bxy.drawImage("bg", rect = rect(vec2(0, 0), windowSize.vec2))

    bxy.drawRect(rect(player_pos, player_size), color(0, 1, 0))

    bxy.endFrame()

    window.swapBuffers()
    inc frame

window.onButtonPress = proc(button: Button) =
    case button:
        of KeyW:
            player_velocity.y -= 8
        of KeyA:
            player_velocity.x -= 8
        of KeyS:
            player_velocity.y += 8
        of KeyD:
            player_velocity.x += 8
        else:
            echo button

window.onButtonRelease = proc(button: Button) =
    case button:
        of KeyW:
            player_velocity.y += 8
        of KeyA:
            player_velocity.x += 8
        of KeyS:
            player_velocity.y -= 8
        of KeyD:
            player_velocity.x -= 8
        else:
            echo button

while not window.closeRequested:
    process()
    display()
    pollEvents()