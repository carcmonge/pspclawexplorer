function navegador(d,u,r,l,val,num)
   if controls.press("down") and VM > 0 and VM ~= numOpci and d then
      VM = VM + 1
   elseif  controls.press("down") and VM >= numOpci and d then 
      VM = 1
   end
   
   if controls.press("up") and (VM ~= 1 or VM > 1) and VM <= numOpci and u then   
      VM = VM - 1
   elseif  controls.press("up") and VM == 1 and u then 
      VM = numOpci
   end
   if controls.press("right") and VM > 0 and VM ~= numOpci then
      VM = VM + 1
   elseif  controls.press("right") and VM >= numOpci then 
      VM = 1
   end
   
   if controls.press("left") and (VM ~= 1 or VM > 1) and VM <= numOpci then
      VM = VM - 1
   elseif  controls.press("left") and VM == 1 then 
      VM = numOpci
   end   
end