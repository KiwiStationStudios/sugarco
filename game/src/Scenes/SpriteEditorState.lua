-- Debug state --

SpriteEditorState = {}

function SpriteEditorState:enter()
    if not FEATURE_FLAGS.debug then gamestate.switch(MainMenuState) end
end

function SpriteEditorState:draw()
    
end

function SpriteEditorState:update(elapsed)
    
end

return SpriteEditorState