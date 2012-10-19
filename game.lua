local scene = storyboard.newScene();
local physics = require("physics");
local bridge = {};

local groupBackground = display.newGroup();
local groupMap = display.newGroup();

local config = {
}

function scene:createScene( event )
	local group = self.view

	function createSceneInit(data)
		setupGroups();
		setupBackground();
		setupPhysics();
		createMap();
		createPlayer();
		createTracker();
	end

	function createTracker()
		bridge.tracker = display.newCircle(0, 0, 10);
		bridge.tracker:setFillColor(30, 200, 30);
	end

	function setupGroups()
		group:insert(groupBackground);
		group:insert(groupMap);
	end

	function setupBackground()
		display.newRect(groupBackground,0,0,1024,768);
	end

	function setupPhysics()
		physics.start()
		physics.setGravity(0, 10)
	end

	function createMap()
		local physicsData = (require('map')).physicsData(1.0);
		
		bridge.map = display.newImageRect(groupMap, 'map.png', 3000, 3000);
		bridge.map:setReferencePoint(display.CenterReferencePoint);
		bridge.map.x = display.contentWidth/2;
		bridge.map.y = display.contentHeight/2;
		physics.addBody(bridge.map, 'static', physicsData:get('map'));

		groupMap:setReferencePoint(display.CenterReferencePoint);
	end

	function createPlayer()
		local radius = 20;
		bridge.player = display.newCircle(groupMap, 200, 200, radius);
		bridge.player:setFillColor(200, 30, 30);
		physics.addBody(bridge.player, {radius=radius});
	end

	createSceneInit(event.params);
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view;
	
	function enterSceneInit(data)
		animateMap();
		Runtime:addEventListener( "enterFrame", animate );
	end

	function animateMap()
		transition.to(bridge.map, {time=30000, rotation=bridge.map.rotation+360, onComplete=animateMap})
	end

	function animate()
		bridge.tracker.x, bridge.tracker.y = bridge.player:localToContent(0,0);

		--print('x: '..bridge.tracker.x..' y: '..bridge.tracker.y)
		
		print(groupMap.x);

		print('x = '..bridge.tracker.x);
		print('y = '..bridge.tracker.y);
		groupMap.xScale = 0.25;
		groupMap.yScale = 0.25
		--groupMap.x = display.contentWidth/2 + (display.contentWidth/2 - bridge.tracker.x);
		--groupMap.y = display.contentHeight/2;
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