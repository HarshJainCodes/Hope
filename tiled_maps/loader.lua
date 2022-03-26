Platforms={}
Immovable_objects={}
Movable_objects={}
crystal={}
portal={}

function map_spawn(mapName)
  destroyAll()
  gameMap = sti("tiled_maps/"..mapName..".lua")

  for k,v in pairs(gameMap.layers['Platforms'].objects)do
    spawn_platform(v.x,v.y,v.width,v.height)
  end

  for k,v in pairs(gameMap.layers['Immovable_objects'].objects)do
    spawnImm_objects(v.x,v.y,v.width,v.height)
  end

  for k,v in pairs(gameMap.layers['Moveable_objects'].objects)do
    spawnMov_objects(v.x,v.y,v.width,v.height)
  end

  for k,v in pairs(gameMap.layers['Crystal'].objects)do
    spawn_crystal(v.x,v.y,v.width,v.height)
  end

  for k,v in pairs(gameMap.layers['Portal'].objects)do
    spawn_portal(v.x,v.y,v.width,v.height)
  end
end

function spawn_platform(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="Platforms"})
  collider:setType('static')
  table.insert(Platforms,collider)
end

function spawnImm_objects(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="Immovable_objects"})
  collider:setType('static')
  table.insert(Immovable_objects,collider)
end

function spawnMov_objects(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="Moveable_objects"})
  collider:setType('dynamic')
  collider:setFixedRotation(true)
  table.insert(Movable_objects,collider)
end

function spawn_crystal(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="Crystal"})
  collider:setType('static')
  table.insert(crystal,collider)
end

function spawn_portal(x,y,w,h)
  local collider=world:newRectangleCollider(x,y,w,h,{collision_class="Portal"})
  collider:setType('static')
  table.insert(portal,collider)
end
