--------------------------------------   基类Class    ------------------------------------------

-- 类Class的声明，其实就是个table，这里有两个成员变量x,y
Class =
{
	x = 0,
	y = 0
}

-- 设置metatable的元方法__index，指向表Class自己
Class.__index = Class

-- 构造函数,叫什么名字无所谓，这里采用了C++的new名字
function Class:new(x, y)
	print("Class:Simulate Constructors")

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
	print("Class:Print() x = "..self.x..", y = "..self.y)
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
	self.x = 111
	self.y = 222
end

--------------------------------------   子类SubClass    ---------------------------------------

-- 子类SubClass的声明，这里又声明了一个新的变量z
SubClass =
{
	z = 0
}

-- 设置元表为Class
setmetatable(SubClass, Class)

-- 设置metatable的元方法__index，指向表SubClass自己
SubClass.__index = SubClass


-- 构造函数
function SubClass:new(x,y,z)

	print("Simulate Constructors: SubClass")

	-- 先调用父类的构造函数，构造出一个父类的实例
	local tempObj = Class:new(x,y)

	-- 将该对象的元表指向SubClass，谨记：这步非常重要，一定不要弄错了，是SubClass
	setmetatable(tempObj,SubClass)

	-- 新属性z赋值，有了子类自己的数据，这样就是子类实例了
	tempObj.z = z

	return tempObj
end


-- 定义一个新的成员函数
function SubClass:SubPrint()
	print("SubClass:SubPrint() x = "..self.x..", y = "..self.y..", z = "..self.z)
end

-- 重定义父类的函数Add()，注意：和父类的不同，这里是增加了2倍的val
function SubClass:Add(val)
	print("SubClass:Add()")
	self.x = self.x + 2*val
	self.y = self.y + 2*val
end


-------------------------------------    下面是测试代码      -----------------------------------

-- 构造一个基类实例
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


print("\n")

-- 构造一个子类实例
local SubObj = SubClass:new(1,2,3)

-- 访问父类的函数
SubObj:Print()

-- 访问子类自己的函数
SubObj:SubPrint()

-- 调用Add()，这里会发现实际调用的是子类的Add()函数，即实现了多态
SubObj:Add(5)

-- 再次调用自己的函数，会发现调用自己的Add()函数确实成功了
SubObj:SubPrint()