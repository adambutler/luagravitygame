local scene = storyboard.newScene()

local bridge = {};

local config = {
}

function scene:createScene( event )
	local group = self.view

	function createSceneInit(data)
	end

	createSceneInit(event.params);
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view;
	
	function enterSceneInit(data)
	end

	enterSceneInit(event.params);
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	function exitSceneInit()
		-- body
	end	
	
	exitSceneInit();
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view

	function destroySceneInit()
		-- body
	end	
	
	destroySceneInit();
	
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene;