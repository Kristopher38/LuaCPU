local n, lim, k, p, pc, p1, p2 
 
pc  = 0 
n   = 1 
lim = 2500
p1 = 1
p2 = 2
 
while n < lim do 
    k = 3 
    p = true
    n = n + p2 
    while k * k <= n and p do 
        p = math.floor(n // k) * k ~= n 
        k = k + p2 
    end 
    if p then 
        pc = pc + p1 
    end 
end
print(pc)

-- local a,b,c,d,e,f,g;e=0;a=1;b=2500;f=1;g=2;while a<b do c=3;d=true;a=a+g;while c*c<=a and d do d=math.floor(a//c)*c~=a;c=c+g end;if d then e=e+f end end;print(e)