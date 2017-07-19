cc.exports.my_res = {
	ttf = "res/msyh.ttf"
}

cc.exports.GameEnum = {}

GameEnum.WordType = {
	xzj = 1,  		--修真界（凡界）
	xj = 2, 		--仙界
	sj = 3, 		--神界
	shj = 4			--圣界
}

GameEnum.XiulianType = {
	cm = 1, 		--普通修真
	jd = 2 			--金丹修真
}


GameEnum.PropType = {
	error = 0,
	zawu = 1, 			--用来卖钱的啊，
	finxfa = 2, 		--心法
	daofa = 3,			--道法
	fabao = 4, 			--法宝
}

--心法等级
GameEnum.XinfaLevel = {
	error = 0,
	huang = 1,			--黄级功法(基本无望飞升)
	xuan = 2, 			--玄级功法(比较有希望飞升)
	di = 3, 			--地级心法(会比较迅速的飞升)
	tian = 4,			--天级心法(很快就会飞升)
	xian = 5, 			--仙级心法(开外挂飞升)
	shen = 6, 			--神级心法(凡间不可能得到, 得到也不能修炼)
	sheng = 7			--圣级心法(凡、仙不可能得到， 得到也不能修炼)
}

--心法等级对修为的加成
GameEnum.XinfaAdds = {}
GameEnum.XinfaAdds[GameEnum.XinfaLevel.huang] 	= 1
GameEnum.XinfaAdds[GameEnum.XinfaLevel.xuan] 	= 10
GameEnum.XinfaAdds[GameEnum.XinfaLevel.di] 		= 100
GameEnum.XinfaAdds[GameEnum.XinfaLevel.tian] 	= 1000
GameEnum.XinfaAdds[GameEnum.XinfaLevel.xian] 	= 10000
GameEnum.XinfaAdds[GameEnum.XinfaLevel.shen] 	= 100000
GameEnum.XinfaAdds[GameEnum.XinfaLevel.sheng] 	= 1000000