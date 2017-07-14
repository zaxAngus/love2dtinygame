local shine = require 'init'

function love.load()
    -- load the effects you want
    local grain = shine.filmgrain()
    
    -- many effects can be parametrized
    grain.opacity = 0.2
    
    -- multiple parameters can be set at once
    local vignette = shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.7}
    
    -- you can also provide parameters on effect construction
    local desaturate = shine.desaturate{strength = 0.6, tint = {255,250,200}}
    
    -- you can chain multiple effects
    post_effect = desaturate:chain(grain):chain(vignette)

    -- warning - setting parameters affects all chained effects:
    post_effect.opacity = 0.5 -- affects both vignette and film grain

    -- more code here
end
    
function love.draw()
    -- wrap what you want to be post-processed in a function:
    post_effect:draw(function()
        draw()
        my()
        stuff()
    end)
    
    -- alternative syntax:
    -- post_effect(function()
    --     draw()
    --     my()
    --     stuff()
    -- end)
    
    -- everything you draw here will not be affected by the effect
end