/*!
 * cxSlide 1.0
 * http://code.ciaoca.com/
 * https://github.com/ciaoca/cxSlide
 * E-mail: ciaoca@gmail.com
 * Released under the MIT license
 * Date: 2012-12-27
 */

(function($){
	$.fn.cxSlide=function(settings){
		if(!this.length){return;};
		settings=$.extend({},$.cxSlide.defaults,settings);

		var obj=this;
		var slide={};
		slide.fn={};

		var _html;

		slide.box=obj.find(".box");
		slide.list=slide.box.find(".list");
		slide.items=slide.list.find("li");
		slide.itemSum=slide.items.length;

		if(slide.itemSum<=1){return;};

		slide.numList=obj.find(".btn");
		slide.numBtns=slide.numList.find("li");
		slide.plusBtn=obj.find(".plus");
		slide.minusBtn=obj.find(".minus");
		slide.boxWidth=slide.box.width();
		slide.boxHeight=slide.box.height();
		slide.s=0;

		if(settings.btn&&!slide.numList.length){
			_html="";
			for(var i=1;i<=slide.itemSum;i++){
				_html+="<li class='b_"+i+"'>"+i+"</li>";
			};
			slide.numList=$("<ul></ul>",{"class":"btn","html":_html}).appendTo(obj);
			slide.numBtns=slide.numList.find("li");
		};

		if(settings.plus&&!slide.plusBtn.length){
			slide.plusBtn=$("<div></div>",{"class":"plus"}).appendTo(obj);
		};
		if(settings.minus&&!slide.minusBtn.length){
			slide.minusBtn=$("<div></div>",{"class":"minus"}).appendTo(obj);
		};

		slide.fn.on=function(){
			if(!settings.auto){return;}
			slide.fn.off();

			slide.run=setTimeout(function(){
				slide.fn.goto();
			},settings.time);
		};

		slide.fn.off=function(){
			if(typeof(slide.run)!=="undefined"){clearTimeout(slide.run);};
		};

		slide.fn.checkBtn=function(n){
			if(slide.numList.length){
				slide.numBtns.eq(n).addClass("selected").siblings("li").removeClass("selected");
			};
		};

		slide.fn.goto=function(n){
			slide.fn.off();
			var _next=(typeof(n)=="undefined") ? slide.s+1 : parseInt(n,10);
			var _now=slide.s;
			var _max=slide.itemSum-1;

			if(_next==slide.s){
				slide.fn.on();
				return;
			};

			if(_next>_max){
				_next=0;
			}else if(_next<0){
				_next=_max;
			};
			slide.fn.checkBtn(_next);

			var _moveVal;
			switch(settings.type){
				case "x":
					_moveVal=slide.boxWidth*_next;
					if(_next==0&&_now==_max){
						slide.items.eq(0).css({"left":slide.boxWidth*slide.itemSum});
						_moveVal=slide.boxWidth*slide.itemSum;
					}else if(_now==0){
						slide.items.eq(0).css({"left":""});
						slide.box.scrollLeft(0);
					};
					slide.box.stop(true,false).animate({"scrollLeft":(_moveVal)},settings.speed);
					break;

				case "y":
					_moveVal=slide.boxHeight*_next;
					if(_next==0&&_now==_max){
						slide.items.eq(0).css({"top":slide.boxHeight*slide.itemSum});
						_moveVal=slide.boxHeight*slide.itemSum;
					}else if(_now==0){
						slide.items.eq(0).css({"top":""});
						slide.box.scrollTop(0);
					};
					slide.box.stop(true,false).animate({"scrollTop":(_moveVal)},settings.speed);
					break;

				case "fade":
					slide.items.css({"display":"none","position":"absolute","top":0,"left":0,"zIndex":""});
					slide.items.eq(_now).css({"display":"none","zIndex":1});
					slide.items.eq(_next).css({"zIndex":2}).fadeIn(settings.speed);
					break;

				case "toggle":
					slide.items.eq(_next).show().siblings("li").hide();
					break;
			};

			slide.s=_next;
			slide.box.queue(function(){
				slide.fn.on();
				slide.box.dequeue();
			});
		};

		slide.box.hover(function(){
			slide.fn.off();
		},function(){
			slide.fn.on();
		});

		if(settings.btn){
			slide.numList.delegate("li",settings.events,function(){
				slide.fn.goto(slide.numBtns.index($(this)));
			});
		};

		if(settings.plus){
			slide.plusBtn.bind(settings.events,function(){
				slide.fn.goto();
			});
		};

		if(settings.minus){
			slide.minusBtn.bind(settings.events,function(){
				slide.fn.goto(slide.s-1);
			});
		};

		slide.fn.checkBtn(settings.start);
		slide.fn.goto(settings.start);
	};
	
	$.cxSlide={defaults:{
		events:"click",
		type:"x",
		start:0,
		speed:800,
		time:5000,
		auto:true,
		btn:true,
		plus:false,
		minus:false
	}};
})(jQuery);