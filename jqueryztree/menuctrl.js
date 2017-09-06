/**
* Control the menu tree on the tag selective page.
*
* by Alex @2017/9/4
*/
<!--
		
		/*
		var setting = {
			data: {
				key: {
					title: "t"
				},
				simpleData: {
					enable: true
				}
			},
			view: {
				fontCss: getFontCss
			}
		};
		*/
		
		//@Replace the string to I18N
		//@TODO prepare the group tree data
		//@TODO prepare the player tree data
		//@TODO custom icon
		//@TODO single level
		//@Delete icon and event on the right panel
		
		//Setting area
		var curMenu = null, zTree_Menu = null, curMenu2 = null, zTree_Menu2 = null;
		
		var setting = {
			view: {
				showLine: true,
				selectedMulti: false,
				dblClickExpand: false,
				fontCss: getFontCss
			},
			check: {
                enable: true
                ,chkStyle: 'checkbox'
                
            },
			data: {
				key: {
					title: "t"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				onNodeCreated: this.onNodeCreated,
				beforeClick: this.beforeClickMain,
				onClick: this.onClickMain,
				beforeDrag: beforeDrag,
				beforeDrop: beforeDrop,
				onCheck: nodeOnCheck
			}
		};
		
		/**
		* Check the main tree node.
		* If checked, add the node on the result tree,
		* unchecked, remove the node on the result tree.
		*/
		function nodeOnCheck(event, treeId, treeNode) {
			//Add node on right
			var treeMain = $.fn.zTree.getZTreeObj("treeMain");
				
			//Result tree
			var treeRs = $.fn.zTree.getZTreeObj("treeResult");
			//Get the string from 'Group/Player Name(G:123456)' inside the  
			var regex = /[a-zA-Z]{1}:\d{1,10}/; //G:10001
			
			if(treeNode && zTree_Menu2){//The node is checked
				//zTree_Menu2.getNodes()[0] && zTree_Menu2.getNodes()[0].children[0]
				var nodeArr = zTree_Menu2.getNodes();
				var gNode = nodeArr[0]; //0 group, 1 player?
				var pNode = nodeArr[1];
				if(treeNode.checked){
					//The selected node on the main tree
					//Create node by self
					
					//Add the node on last
					try{
						//Check existed the same data first
						var newNode; //treeNode.nocheck = false;
						
						var idStr = treeNode.t; //Target node title
						var idStrRs = String(idStr.match(regex));
						console.log("idStrRs='"+idStrRs+"'");
						
						var idStrArr = idStrRs.split(":");
						if(idStrArr[0]=="G"){//Group
							newNode = { id:treeNode.id, name:treeNode.name,t:"", nocheck:true,icon:"../../../image/icons/tree/group.gif"};
							newNode = treeRs.addNodes(gNode, newNode);
						}else if(idStrArr[0]=="P"){//Player node
							newNode = { id:treeNode.id, name:treeNode.name,t:"", nocheck:true,icon:"../../../image/icons/tree/player.gif"};
							newNode = treeRs.addNodes(pNode, newNode);
						}
					}catch(e){
						console.log(e);
					}
					console.log("after treeRs.addNodes!!!");
				}else{
					//Remove the node on right
					console.log("@TODO Remove the node on the result tree!!!");
					
					var childNodeArr,parentNode;
					
					loopOut:
					for (var i=0, l=nodeArr.length; i < l; i++) {// 0:Group, 1:Player
						console.log(nodeArr[i]);
						//treeRs.removeNode(nodes[i]);
						parentNode = nodeArr[i];
						if(parentNode && parentNode.children){
							childNodeArr = parentNode.children;
							if(childNodeArr){
								for(var jdx=0; jdx<childNodeArr.length; jdx++){
									if(childNodeArr[jdx] && childNodeArr[jdx].id == treeNode.id){
										treeRs.removeNode(childNodeArr[jdx]);
										break loopOut;
									}
								}//end inner for
							}
						}
					}//end outer for
				}//end if(treeNode.checked)
			}else{
				console.log("No data!");
			}
		};
		
		var settingRight = {
			view: {
				showLine: true,
				selectedMulti: false,
				dblClickExpand: false,
				fontCss: getFontCss
			},
			edit: {
				enable: true,
				showRemoveBtn: false,
				showRenameBtn: false
			},
			check: {
                enable: true
                ,chkStyle: 'checkbox'
                
            },
			data: {
				key: {
					title: "t"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				onNodeCreated: this.onNodeCreated,
				beforeClick: this.beforeClickResult,
				onClick: this.onClickRight,
				beforeDrag: beforeDrag,
				beforeDrop: beforeDrop
			}
		};
		
		/** Click the node body event. */
		function onClickRight(e, treeId, node) {
			console.log("Do what you want to do!");
		}
		
		//@TODO get data from service call
		
		//http://192.168.234.132/image/icons/tree/group_folder.gif;jsessionid=71A7AD76632C82795A3D238139ED26D0
		//http://192.168.234.132/image/icons/tree/group.gif;jsessionid=71A7AD76632C82795A3D238139ED26D0
		//player.gif
		//t:title - tooltip
		var zNodes =[
			{ id:1, pId:0, name:"Group",t:"G:0", nocheck:true },
			{ id:11, pId:1, name:"Sub Menu 1-1",t:"(G:11)", open:true, nocheck:true},
			{ id:111, pId:11, name:"Leaf Node 1-1-1",t:"Leaf Node(G:111)",icon:"../../../image/icons/tree/group_folder.gif" },
			{ id:112, pId:11, name:"Leaf Node 1-1-2",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:113, pId:11, name:"Leaf Node 1-1-3",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:114, pId:11, name:"Leaf Node 1-1-4",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:12, pId:1, name:"Sub Menu 1-2",t:"id=(G:11)", nocheck:true},
			{ id:121, pId:12, name:"Leaf Node 1-2-1",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:122, pId:12, name:"Leaf Node 1-2-2",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:123, pId:12, name:"Leaf Node 1-2-3",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:124, pId:12, name:"Leaf Node 1-2-4",t:"(G:11)",icon:"../../../image/icons/tree/group.gif"},
			{ id:2, pId:0, name:"Player",t:"(P:2)",nocheck:true},
			{ id:21, pId:2, name:"Sub Menu 2-1",t:"(P:11)", nocheck:true},
			{ id:211, pId:21, name:"Leaf Node 2-1-1",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:212, pId:21, name:"Leaf Node 2-1-2",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:213, pId:21, name:"Leaf Node 2-1-3",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:214, pId:21, name:"Leaf Node 2-1-4",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:22, pId:2, name:"Sub Menu 2-2",t:"(P:11)", nocheck:true},
			{ id:221, pId:22, name:"Leaf Node 2-2-1",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:222, pId:22, name:"Leaf Node 2-2-2",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:223, pId:22, name:"Leaf Node 2-2-3",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
			{ id:224, pId:22, name:"Leaf Node 2-2-4",t:"(P:11)",icon:"../../../image/icons/tree/player.gif"},
		];
		
		//The data of the selected group/player. t:title - tooltip
		var zNodesRs =[
			{ id:100, pId:0, name:"Group",t:"Group", nocheck:true},
			{ id:10001, pId:100, name:"Group Tag 1-1",t:"Tag 1", open:true, nocheck:true,icon:"../../../image/icons/tree/group.gif"},
			{ id:200, pId:0, name:"Player",t:"Player", nocheck:true},
			{ id:20001, pId:200, name:"Player Tag 2-1",t:"Tag 2", open:true, nocheck:true,icon:"../../../image/icons/tree/player.gif"},
		];
		
		function beforeClickMain(treeId, node) {
			if (node.isParent) {
				if (node.level === 0) {
					var pNode = curMenu;
					while (pNode && pNode.level !==0) {
						pNode = pNode.getParentNode();
					}
					if (pNode !== node) {
						var a = $("#" + pNode.tId + "_a");
						a.removeClass("cur");
						zTree_Menu.expandNode(pNode, false);
					}
					a = $("#" + node.tId + "_a");
					a.addClass("cur");

					var isOpen = false;
					for (var i=0,l=node.children.length; i<l; i++) {
						if(node.children[i].open) {
							isOpen = true;
							break;
						}
					}
					if (isOpen) {
						zTree_Menu.expandNode(node, true);
						curMenu = node;
					} else {
						zTree_Menu.expandNode(node.children[0].isParent?node.children[0]:node, true);
						curMenu = node.children[0];
					}
				} else {
					zTree_Menu.expandNode(node);
				}
			}
			return !node.isParent;
		}
		
		function beforeClickResult(treeId, node) {
			if (node.isParent) {
				if (node.level === 0) {
					var pNode = curMenu;
					while (pNode && pNode.level !==0) {
						pNode = pNode.getParentNode();
					}
					if (pNode !== node) {
						var a = $("#" + pNode.tId + "_a");
						a.removeClass("cur");
						zTree_Menu2.expandNode(pNode, false);
					}
					a = $("#" + node.tId + "_a");
					a.addClass("cur");

					var isOpen = false;
					for (var i=0,l=node.children.length; i<l; i++) {
						if(node.children[i].open) {
							isOpen = true;
							break;
						}
					}
					if (isOpen) {
						zTree_Menu2.expandNode(node, true);
						curMenu2 = node;
					} else {
						zTree_Menu2.expandNode(node.children[0].isParent?node.children[0]:node, true);
						curMenu2 = node.children[0];
					}
				} else {
					zTree_Menu2.expandNode(node);
				}
			}
			return !node.isParent;
		}
		
		/** Click the node body event. */
		function onClickMain(e, treeId, node) {
			//alert("Do what you want to do!");
			console.log("Do what you want to do!");
		}

		function focusKey(e) {
			if (key.hasClass("empty")) {
				key.removeClass("empty");
			}
		}
		function blurKey(e) {
			if (key.get(0).value === "") {
				key.addClass("empty");
			}
		}
		var lastValue = "", nodeList = [], fontCss = {};
		function clickRadio(e) {
			lastValue = "";
			searchNode(e);
		}
		
		function searchNode(e) {
			var zTree = $.fn.zTree.getZTreeObj("treeMain");
			if (!$("#getNodesByFilter").attr("checked")) {
				var value = $.trim(key.get(0).value);
				var keyType = "";
				if ($("#name").attr("checked")) {
					keyType = "name";
				} else if ($("#level").attr("checked")) {
					keyType = "level";
					value = parseInt(value);
				} else if ($("#id").attr("checked")) {
					keyType = "id";
					value = parseInt(value);
				}
				if (key.hasClass("empty")) {
					value = "";
				}
				if (lastValue === value) return;
				lastValue = value;
				if (value === "") return;
				updateNodes(false);

				if ($("#getNodeByParam").attr("checked")) {
					var node = zTree.getNodeByParam(keyType, value);
					if (node === null) {
						nodeList = [];
					} else {
						nodeList = [node];
					}
				} else if ($("#getNodesByParam").attr("checked")) {
					nodeList = zTree.getNodesByParam(keyType, value);
				} else if ($("#getNodesByParamFuzzy").attr("checked")) {
					nodeList = zTree.getNodesByParamFuzzy(keyType, value);
				}
			} else {
				updateNodes(false);
				nodeList = zTree.getNodesByFilter(filter);
			}
			updateNodes(true);

		}
		
		function updateNodes(highlight) {
			var zTree = $.fn.zTree.getZTreeObj("treeMain");
			for( var i=0, l=nodeList.length; i<l; i++) {
				nodeList[i].highlight = highlight;
				zTree.updateNode(nodeList[i]);
			}
		}
		
		function getFontCss(treeId, treeNode) {
			return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
		}
		
		function filter(node) {
			return !node.isParent && node.isFirstNode;
		}

		function beforeDrag(treeId, treeNodes) {
			for (var i=0,l=treeNodes.length; i<l; i++) {
				if (treeNodes[i].drag === false) {
					return false;
				}
			}
			return true;
		}
		
		function beforeDrop(treeId, treeNodes, targetNode, moveType) {
			return targetNode ? targetNode.drop !== false : true;
		}
		
		var key;
		
		//Initialize the left main menu and the right result menu
		$(document).ready(function(){
			$.fn.zTree.init($("#treeMain"), setting, zNodes);
			
			$.fn.zTree.init($("#treeResult"), settingRight, zNodesRs);
			
			key = $("#key");
			key.bind("focus", focusKey)
			.bind("blur", blurKey)
			.bind("propertychange", searchNode)
			.bind("input", searchNode);
			
			$("#name").bind("change", clickRadio);
			$("#level").bind("change", clickRadio);
			$("#id").bind("change", clickRadio);
			$("#getNodeByParam").bind("change", clickRadio);
			$("#getNodesByParam").bind("change", clickRadio);
			$("#getNodesByParamFuzzy").bind("change", clickRadio);
			$("#getNodesByFilter").bind("change", clickRadio);
			
			zTree_Menu = $.fn.zTree.getZTreeObj("treeMain");
			curMenu = zTree_Menu.getNodes()[0].children[0].children[0];
			zTree_Menu.selectNode(curMenu);
			var a = $("#" + zTree_Menu.getNodes()[0].tId + "_a");
			a.addClass("cur");
			
			//the result menu tree
			zTree_Menu2 = $.fn.zTree.getZTreeObj("treeResult");
			//curMenu2 = zTree_Menu2.getNodes()[0].children[0].children[0];
			if(zTree_Menu2 && zTree_Menu2.getNodes()[0] && zTree_Menu2.getNodes()[0].children[0]){
				curMenu2 = zTree_Menu2.getNodes()[0].children[0];
				zTree_Menu2.selectNode(curMenu2);
				var a2 = $("#" + zTree_Menu2.getNodes()[0].tId + "_a");
				a2.addClass("cur");
			}
			
			
			
		});