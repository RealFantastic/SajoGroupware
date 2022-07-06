function orgChart($targetElem){
console.log("2");
	var context = sessionStorage.getItem('contextPath');
	var url = context + "/member/empchart";
	console.log(context);
	$.ajax({
				type:'post',
				url:url,
				success:function(result){
					createJSTree($targetElem,result);
				}
			});
}

function createJSTree($elem,jsonData){
    console.log(typeof jsonData);
    //JSON String => JSON Object로 형변환
    //이유 : JSTree에서 String 형태의 JSON을 파싱하지 못함.
    var objData = JSON.parse(jsonData);
    console.log(typeof objData);

    $elem.jstree({
          'core' : {
                  'check_callback' : true,
                  'themes' : {"stripes" : true},
                  'data' : objData,
                "plugins" : ["search"],
                "search" : {
                    "show_only_matches" : true,
                    "show_only_matches_children" : true,
                }
              },
        "plugins" : [ "search" ]
      });
    $elem.jstree("open_all");
}
function searchJstree($target){
	console.log($target);
    var to = false;
    if(to){clearTimeout(to);}
    to = setTimeout(searchEventJstree($target),250);
}
function searchEventJstree($element){
    var v = $element.val();
    console.log($element.next());
    
    let result = $element.next().jstree(true).search(v);
    
    $element.next().jstree('open_node',result);
}

