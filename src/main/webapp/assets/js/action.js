$(document).ready(function(){

    $("td").click(function(){
        var _obj=$(this);
        var _result=_obj.attr("result");
        if(_result==null){
            _result="没有意见";
        }
        
        var color=_obj.css("background-color");
        console.log(color);
        if(color!="rgba(0, 0, 0, 0)"){

            var d = dialog({
                title: '提示',
                content:'<center>您的意见是:'+_result+'</center><br/><br/><form class=\"question\" action=\"\" method=\"get\"><label><input name=\"question\" type=\"radio\" />A.重复填报</label><br/><label><input name=\"question\" type=\"radio\" />B.没有统计数据 </label><br/><label><input name=\"question\" type=\"radio\" />C.指标没有统计意义 </label><br/><label><input name=\"question\" type=\"radio\" />D.解释含糊不清楚 </label><br/><label><input name=\"question\" id="other" type=\"radio\" />其他意见:<input id=\"other2\"/></label><br/><label><input name=\"question\" id="cancel" type=\"radio\" />没有意见</label></form>',
                okValue:'确定',
                ok:function(){
                    var _changed=$("input:radio:checked");
                    var _res="";
                    if(_changed.size()>0){
                        if(_changed.attr("id")=="other"){
                            _res="其他意见:"+_changed.next().val();
                            _obj.css("background-color","#FF4040");
                        }else if(_changed.attr("id")=="cancel"){
                            _res=null;
                            _obj.css("background-color","#98FB98");
                        }else{
                            _res=_changed.parent().text();
                            _obj.css("background-color","#FF4040");
                        }
                        _obj.attr("result",_res);
                    }

                }
            });
            d.showModal();
        }


    });
});