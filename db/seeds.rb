# -*- encoding : utf-8 -*-
role = Role.create(name: '管理员', omnipotent: true, creatable: true, updatable: true, listable: true, showable: true, destroyable: true, searchable: true, operatable: true)
Administrator.create(role: role, account: 'admin', password: '123456', password_confirmation: '123456', name: '王皓', available: true)
ArticleCategory.create([{ name: '学会公告', position: 1 }, { name: '环球孔院', position: 2, default: true }, { name: '汉教动态', position: 3 }, { name: '社会关注', position: 4 }, { name: '会议信息', position: 5 }, { name: '项目信息', position: 6 }, { name: '职位信息', position: 7 }])
root_category = BookCategory.create(name: '教材/教辅')
sub_category = root_category.children.create(name: '适用对象')
sub_category.children.create([{ name: '幼儿' }, { name: '中小学' }, { name: '大学' }, { name: '通用' }])
sub_category = root_category.children.create(name: '内容范围')
sub_category.children.create([{ name: '综合汉语' }, { name: '专业汉语' }, { name: '专项训练' }, { name: '汉字教学' }])
BookCategory.create([{ name: '汉语测试' }, { name: '汉语读物' }, { name: '学术著作与教学参考' }])
BookCategory.create(name: '文化').children.create([{ name: '影视作品' }, { name: '武术保健' }, { name: '中国文化' }])
BookCategory.create([{ name: '工具书' }, { name: '期刊杂志' }])
ResourceCategory.create([{ name: '课件', position: 1, default: true }, { name: '教案', position: 2 }, { name: '示范课', position: 3 }])
Forum.create([{ name: '国别调研', position: 1 }, { name: '教学互动', position: 2 }, { name: '案例交流', position: 3 }, { name: '学术探讨', position: 4 }, { name: '随感杂谈', position: 5 }, { name: '成果交流', position: 6 }])