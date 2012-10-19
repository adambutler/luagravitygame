-- GENERAL HELPERS

function anyScoresInDatabase()
	local n = 0;
	for row in db:nrows([[SELECT * FROM user_scores]]) do
		n = n + 1;
	end

	if n == 0 then
		return false
	else
		return true
	end
end

function getSetting(name)
	for row in db:nrows([[SELECT value FROM settings WHERE name == ']]..name..[[']]) do
	  return row.value;
	end
end

function log(type, msg)
	if type == 'debug' then
		--print("DEBUG: " .. msg);
	elseif type == 'error' then
		--print("ERROR: " .. msg);
	elseif type == 'warn' then
		--print("WARN: " .. msg);
	elseif type == 'time' then
		print('@'..system.getTimer()..' - '..msg);
	end
end

function hex2rgb(hex)
	local r = hex:sub(1, 2)
	local g = hex:sub(3, 4)
	local b = hex:sub(5, 6)
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

function shadowText(text, x, y, font, size, colourFrom, colourTo, shadowColour, offsetX, offsetY, center)
	local group = display.newGroup();
	local t2 = display.newText(group, text, x + offsetX, y + offsetY, font, size)
	local t1 = display.newText(group, text, x, y, font, size)

	local g = graphics.newGradient( { hex2rgb(colourFrom) }, { hex2rgb(colourTo) }, "down" )

	t2:setTextColor(hex2rgb(shadowColour));
	t1:setTextColor(g);
	if center then
		t1.x = x;
		t2.x = x + offsetX;
	end
	return group; 
end

function list_iter (t)
	local i = 0
	local n = table.getn(t)
	return function ()
		i = i + 1
		if i <= n then return t[i] end
	end
end

function timerx(ms,callback, onTick)

	local timerx = {};
	timerx.count = ms;
	timerx.pausedDuration = 0;
	timerx.running = false;
	timerx.paused = false;
	timerx.callback = callback;

	if(onTick)then
		timerx.onTick = onTick;
	end

	timerx.complete = function()
		timerx.stop();
		timerx.callback();
	end

	timerx.stop = function()
		timerx.running = false;
		Runtime:removeEventListener( "enterFrame", timerx.tick );
	end
	
	timerx.pause = function()
		timerx.paused = true;
		timerx.stoppedTime = system.getTimer();
		Runtime:removeEventListener( "enterFrame", timerx.tick );
	end

	timerx.resume = function()
		timerx.paused = false;
		timerx.pausedDuration = timerx.pausedDuration + (system.getTimer() - timerx.stoppedTime);
		Runtime:addEventListener( "enterFrame", timerx.tick );
	end
	
	timerx.tick = function ()
		if((system.getTimer() - timerx.start) >= timerx.count + timerx.pausedDuration) then
			timerx.complete();
			Runtime:removeEventListener( "enterFrame", timerx.tick );
		elseif(timerx.onTick)then
			timerx.onTick(timerx);
		end
	end
	
	timerx.start = function ()
		timerx.running = true;
		timerx.paused = false;
		timerx.start = system.getTimer();
		Runtime:addEventListener( "enterFrame", timerx.tick );
	end
	
	timerx.getTime = function()
		if(timerx.paused)then
			return system.getTimer() - timerx.start - (system.getTimer()- timerx.stoppedTime);
		elseif(timerx.running == false)then
			return "Error: Cant request time when timer is not running / stopped"
		else
			return system.getTimer() - timerx.start - timerx.pausedDuration;
		end
	end

	return(timerx);     
end

function pad(number, length)
	local str = '' .. number;

	while string.len(str) < length do
		str = '0' .. str;
	end

	return str;
end

function shuffle(t)
  local n = #t
 
  while n >= 2 do
    -- n is now the last pertinent index
    local k = math.random(n) -- 1 <= k <= n
    -- Quick swap
    t[n], t[k] = t[k], t[n]
    n = n - 1
  end
 
  return t
end

function superPrint(wat)
	print('')
	print('-----------------------------------------------------------------------------')
	print('*****************************************************************************');
	print('-----------------------------------------------------------------------------')
	print('')
	print(wat);
	print('')
	print('-----------------------------------------------------------------------------')
	print('*****************************************************************************');
	print('-----------------------------------------------------------------------------')
	print('')
end
