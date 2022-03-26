function destroyAll()
  -- local i=#Platforms
  -- local j=#crystal
  -- local k=#Immovable_objects
  -- local l=#Movable_objects
  -- local m=#portal
  --
  -- while(i>-1)do
  --   if(platforms[i]!=nil)then
  --     platforms[i]:destroy()
  --   end
  --   table.remove(platforms,i)
  --   i=i-1
  -- end
  -- while(j>-1)do
  --   if(crystal[j]!=nil)then
  --     crystal[j]:destroy()
  --   end
  --   table.remove(crystal,j)
  --   j=j-1
  -- end
  -- while(k>-1)do
  --   if(Immovable_objects[k]!=nil)then
  --     Immovable_objects[k]:destroy()
  --   end
  --   table.remove(Immovable_objects,k)
  --   k=k-1
  -- end
  -- while(l>-1)do
  --   if(Movable_objects[l]!=nil)then
  --     Movable_objects[l]:destroy()
  --   end
  --   table.remove(Movable_objects,l)
  --   l=l-1
  -- end
  -- while(m>-1)do
  --   if(platforms[m]!=nil)then
  --     platforms[m]:destroy()
  --   end
  --   table.remove(portal,m)
  --   m=m-1
  -- end
  for k,v in pairs(Platforms)do
    v:destroy()
  end
  Platforms={}
  for k,v in pairs(Immovable_objects)do
    v:destroy()
  end
  Immovable_objects={}
  for k,v in pairs(Movable_objects)do
    v:destroy()
  end
  Movable_objects={}
  for k,v in pairs(crystal)do
    v:destroy()
  end
  crystal={}
  for k,v in pairs(portal)do
    v:destroy()
  end
  portal={}
end
