-- 类Class的声明，其实就是个table，这里有两个成员变量x,y
Class =
{
	x = 1,
	y = 2
}

-- 设置metatable的元方法__index，指向表Class自己
Class.__index = Class

-- 构造函数,叫什么名字无所谓，这里采用了C++的new名字
function Class:new(x, y)
	print("Class:Simulate Constructors new()")

	-- 新建一个对象，这样通过Class:new()函数创建的每一个实例都是独立的
	local tempObj = {}
	tempObj.x = x
	tempObj.y = y

	-- 设置新对象的metatable，谨记：这一步非常重要
	setmetatable(tempObj,Class)

	-- 返回这个新创建的对象
	return tempObj
end

-- 类的其他成员函数1
function Class:Print()
	print("Class:Print()")
	print("x = "..self.x..", y = "..self.y)
end

-- 类的其他成员函数2
function Class:Add(val)
	print("Class:Add()")
	self.x = self.x + val
	self.y = self.y + val
end

-- 类的其他成员函数3
function Class:Modify()
	print("Class:Modify()")
	self.x = 11
	self.y = 22
end

-- 下面是测试代码

-- 新构造一个类实例
local Obj = Class:new(11,22)

-- 调用函数Print()进行打印
Obj:Print()

-- 调用函数Add()进行加操作
Obj:Add(5)

-- 再次调用函数Print()进行打印，会发现调用Add()函数确实成功了
Obj:Print()

-- 做修改
Obj:Modify()

-- 再次调用函数Print()进行打印，会发现调用Modify()函数确实成功了
Obj:Print()

-- 这里打印出Class本身的数据，会发现数据没有改动，说明是新建的类实例互不影响
print("Class Class.x = "..Class.x..", Class.y = "..Class.y)