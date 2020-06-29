-- for泛型循环
days = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}  
for key,value in ipairs(days) 
do  
	print(key, value) 
	end
	
print()
-- while循环
a=10
while( a < 20 )
do
   print("a = ", a)
   a = a+1
end

print()
-- repeat...until循环
a = 10
repeat
	if (a > 15) then
		break
	end
	a = a + 1
	print("a = ", a)
	until(a >= 20)
	
print()
-- repeat...until循环, break打断
a = 10
repeat
	if (a > 15) then
		break
	end
	a = a + 1
	print("a = ", a)
	until(a >= 20)
	
print()
-- function
function Sum(t1, t2)
	return t1 + t2
end
local a, b = 3, 4
print("Sum of a"..a.." and b"..b.." is "..Sum(a, b))
	
print()
-- function可变参数
function average(...)
   result = 0
   local arg={...}
   for i,v in ipairs(arg) do
      result = result + v
   end
   print("总共传入 " .. select("#",...) .. " 个数")
   return result/select("#",...)
end

print("平均值为",average(10,5,3,4,5,6))

print()
-- function可变参数
function foo(...)  
	for i = 1, select('#', ...) do  -->获取参数总数
		local arg = select(i, ...); -->读取参数
		print("arg", arg);  
	end  
end  

foo(1, 2, 3, 4); 

print()
-- 初始化数组
array = {}
maxRows = 3
maxColumns = 3
for row=1,maxRows do
   for col=1,maxColumns do
      array[row*maxColumns +col] = row*col
   end
end

print()
-- 访问数组
for row=1,maxRows do
   for col=1,maxColumns do
      print(row*maxColumns +col, array[row*maxColumns +col])
   end
end

print()
--无状态迭代器
function square(iteratorMaxCount,currentNumber)
   if currentNumber<iteratorMaxCount
   then
      currentNumber = currentNumber+1
   return currentNumber, currentNumber*currentNumber
   end
end

for i,n in square,3,0
do
   print(i,n)
end

print()
-- test_module.lua 文件
-- module 模块为上文提到到 module.lua
local mdl = require("module")
 
print(mdl.constant)
 
mdl.func3()

print()
-- table & metatable
local mytable = {}
mytable.one = "One"
mytable.two = "Two"
print("Before set metatable:", mytable.one, mytable.two, mytable.three)

local mymetatable = 
{
	__index = function(t, key)
		if key == "three" then
			return "mymetatablekey"
		else 
			return nil
		end
	end
}
setmetatable(mytable, mymetatable)
print("After set metatable:", mytable.one, mytable.two, mytable.three)

print("Before set metatable __newindex:", mytable.one, mymetatable.one)
mymetatable.__newindex = mymetatable
mytable.four = "Four"
print("After set metatable __newindex: ", mytable.four, mymetatable.four)

print()
-- 实现一个类与继承
-- 定义父类内容
Parent = {testOne =  35}
Parent.__index = Parent

function Parent.new()
	-- body
	local self = {}
	--把Parent背包放在self身上
	setmetatable(self,Parent);
	return self
end

function Parent.ShowMe( ... )
	print('123')
end

--Son继承Parent
Son = Parent.new()
--调用父类的方法
Son.ShowMe()
--调用父类的属性
print(Son.testOne)

print()
varTable = {}
varTable["default"] = 1
print(varTable.default)
varTable.default = 2
print(varTable["default"])

print()
local newProductor

function productor()
	local i = 0
	while true do
		i = i + 1
		send(i)     -- 将生产的物品发送给消费者
	end
end

function consumer()
	local i = 0
	while i < 100 do
		i = receive()     -- 从生产者那里得到物品
		print(i)
	end
end

function receive()
	local status, value = coroutine.resume(newProductor)
	return value
end

function send(x)
	coroutine.yield(x)     -- x表示需要发送的值，值返回以后，就挂起该协同程序
end

-- 启动程序
newProductor = coroutine.create(productor)
consumer()

print("\nThe combination of resume and yield is powerful in that the resume is in the main, it passes the external state (data) into the coroutine, and the yield returns the internal state (data) to the master.\n")
function foo (a)
    print("foo func output", a)
    return coroutine.yield(2 * a) -- 返回  2*a 的值
end
 
co = coroutine.create(function (a , b)
    print("First output", a, b) -- co-body 1 10
    local r = foo(a + 1)
     
    print("Second output", r)
    local r, s = coroutine.yield(a + b, a - b)  -- a，b的值为第一次调用协同程序时传入
     
    print("Third output", r, s)
    return b, "End coroutine"                   -- b的值为第二次调用协同程序时传入
end)
       
print("main", coroutine.resume(co, 1, 10)) -- true, 4
print("---split line---")
print("main", coroutine.resume(co, "r")) -- true 11 -9
print("---split line---")
print("main", coroutine.resume(co, "x", "y")) -- true 10 end
print("---split line---")
print("main", coroutine.resume(co, "x", "y")) -- cannot resume dead coroutine
print("---split line---")

print("GetEnumerator")
map = {"AAA", "BBB", "CCC"}
iter = map.GetEnumerator()
while iter.MoveNext() do
	print(iter.Current.Value)
end