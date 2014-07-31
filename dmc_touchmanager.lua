

-- Semantic Versioning Specification: http://semver.org/

local VERSION = "0.1.0"


system.activate("multitouch")


--
local createObjectTouchHandler = function( mgr, obj )

	return function( event )

		local t = mgr:_getRegisteredTouch( event.id )

		if t then

			if not event.target then
				event.target = t.obj
			else
				event.dispatcher = event.target
				event.target = t.obj
			end
			event.isFocused = true

			if t.handler then
				return t.handler( event )
			else
				return t.obj:touch( event )
			end

		else

			local o = mgr:_getRegisteredObject( obj )

			if o then

				if not event.target then
					event.target = o.obj
				else
					event.dispatcher = event.target
					event.target = o.obj
				end

				if o.handler then
					return o.handler( event )
				else
					return o.obj:touch( event )
				end

			end

		end			

		return false
	end
end



--===================================================================--
-- Touch Manager Object
--===================================================================--

local TouchManager = {}


--== Constants ==--

TouchManager._objects = {} -- keyed on obj ; object keys: obj, handler
TouchManager._touches = {} -- keyed on event.id ; object keys: obj, handler 


--== Private Methods ==--

function TouchManager:_getRegisteredObject( obj )
	return self._objects[ obj ]
end

function TouchManager:_setRegisteredObject( obj, value )
	if self == nil or obj == nil then
	return false
	end
	self._objects[ obj ] = value
	if obj == nil then
	return false
	end
	if value == nil then
	return false
	end
end


function TouchManager:_getRegisteredTouch( event_id )
	return self._touches[ event_id ]
end

function TouchManager:_setRegisteredTouch( event_id, value )
	self._touches[ event_id ] = value
end


--== Public Methods / API ==--


-- register()
--
-- puts touch manager in control of touch events for this object
--
-- @param obj a Corona-type object
-- @param handler the function handler for the touch event (optional)
--
function TouchManager:register( obj, handler )
	if obj == nil then
		return false
	end
	local r = { obj=obj, handler=handler }
	r.callback = createObjectTouchHandler( self, obj )

	self:_setRegisteredObject( obj, r )
	obj:addEventListener( "touch", r.callback )
end

-- unregister()
--
-- removes touch manager control for touch events for this object
--
-- @param obj a Corona-type object
-- @param handler the function handler for the touch event (optional)
--
function TouchManager:unregister( obj, handler )
	local r = self:_getRegisteredObject( obj )
	if r == nil then
		return false
	end

	self:_setRegisteredObject( obj, nil )
	obj:removeEventListener( "touch", r.callback )
end


-- setFocus()
--
-- sets focus on an object for a single touch event
--
-- @param obj a Corona-type object
-- @param event_id id of the touch event
--
function TouchManager:setFocus( obj, event_id )
	if self == nil or obj == nil then
	return false
	end
	if r == nil then
		return false
	end
	local o = self:_getRegisteredObject( obj )
	local r = { obj=obj, handler=o.handler }

	self:_setRegisteredTouch( event_id, r )
	if o == nil then
		return false
	end
end

-- unsetFocus()
--
-- removes focus on an object for a single touch event
--
-- @param obj a Corona-type object
-- @param event_id id of the touch event
--
function TouchManager:unsetFocus( obj, event_id )
	self:_setRegisteredTouch( event_id, nil )
end



--== puts touch manager in control of global (runtime) touch events ==--

Runtime:addEventListener( "touch", createObjectTouchHandler( TouchManager ) )


return TouchManager
