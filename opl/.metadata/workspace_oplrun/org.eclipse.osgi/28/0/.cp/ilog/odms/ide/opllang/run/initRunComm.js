/*
	ilog.odms.ide.internal.core.run.comm.initRunComm.js
	Initializes OPL scripting communication layer for ODMS IDE.
*/

// ---------------------------------------------------------------------------

function _IloOdmsIde_GetConflicts() { 
  var out = new _IloOplDataOutputString(); 
  with (out) {
	  startElement("conflicts");
	startSet();
	var iter = thisOplModel.conflictIterator;
	var prevLocation = "#";
  	for(var c in iter) {
  		startTuple();
        addStringItem( ((c.ct!=null) ? c.ct.name : c.dvar.name) );
 		var location = c.location;
        if (location == prevLocation) {
        	addStringItem("@");
        } else {
        	addStringItem(location);
         	prevLocation = location;
        }		
        // info:
		// currentConflictStatus():
		// - ConflictPossibleMember
		// - ConflictMember
		var info = c.info;
		if (info == "ConflictPossibleMember")
			addStringItem("P")
		else if (info == "ConflictMember")
		    addStringItem("M");
		else 
		    addStringItem("U");
   		endTuple();
  	}
	endSet();
    endElement();
  }
  
  return out.getString();
}

function _IloOdmsIde_GetRelaxations() {
  var out = new _IloOplDataOutputString();
  
  with (out) {
	startElement("relaxations");
	startSet();
	var iter = thisOplModel.relaxationIterator
	var prevLocation = "#";
  	for(var r in iter) {
  		startTuple();
        addStringItem( ((r.ct!=null) ? r.ct.name : r.dvar.name) );
        var location = r.location;
        if (location == prevLocation) {
        	addStringItem("@");
        } else {
        	addStringItem(location);
         	prevLocation = location;
        }
        
        // info:
        // currentLB()/currentUB(): original range
         addStringItem(r.info);
        // info2:
        // currentRelaxedLB()/currentRelaxedUB(): relaxed range
        addStringItem(r.info2);
        // info3:
        // currentInfeas(): relaxed value (not used)
        // addStringItem(r.info3);
  		endTuple();
  	}
	endSet();
    endElement();
  }
  return out.getString();
}

function _IloOdmsIde_HasRelaxations() {
	var iter = thisOplModel.relaxationIterator
  	for(var r in iter) {
  		return true;
    }
	return false;
}

// ---------------------------------------------------------------------------

function _IloOdmsIde_AddProfileNode(out,node,level) {
  	with (out) {
        for(; node; node=node.next) {
        	startTuple();
        	addIntItem(level);
        	addStringItem(node.name);
        	addStringItem(node.location);
        	addStringItem(node.section);
        	addNumItem(node.time);
        	addNumItem(node.selfTime);
        	addNumItem(node.peakMemory);
        	addNumItem(node.localMemory);
        	addIntItem(node.count);
        	addIntItem(node.nodes);
            endTuple();
            _IloOdmsIde_AddProfileNode(out,node.firstChild,level+1);
        }
   	}
}

function _IloOdmsIde_GetProfile() {
  var out = new _IloOplDataOutputString();
  
  with (out) {
	startElement("profile");
	startSet();
	_IloOdmsIde_AddProfileNode(out,thisOplModel.settings._profilerRootNode,0);
	endSet();
    endElement();
  }
  
  return out.getString();
}

// ---------------------------------------------------------------------------

function _IloOdmsIde_AddExpandable(out,expandable,access) {
	with (out) {
		startTuple();
		addStringItem(expandable.name);
		addStringItem(expandable.print);
		addStringItem(access);
		endTuple();
	}
	return;
}

function _IloOdmsIde_DoExpand(out,expandable,access) {
 	_IloOdmsIde_AddExpandable(out,expandable,access);
	var expanded = expandable.expand;
	if ( expanded==null ) {
		return;
	}
	for(var i=0; i<expanded.length; i++) {
		_IloOdmsIde_AddExpandable(out,expanded[i],access+".expand["+i+"]");
	}
	return;
}

function _IloOdmsIde_Expand(arg) {
  var out = new _IloOplDataOutputString();
  
  with (out) {
	startElement("expand");
	startSet();
	var targ = typeof arg;
	if ( targ == "IloConstraint" || targ == "IloNumExpr" ) {
		_IloOdmsIde_DoExpand(out,arg._expandable,"._expandable");
	} else if ( targ == "object" ) {
		_IloOdmsIde_DoExpand(out,arg,"");
	}
	endSet();
    endElement();
  }  
  return out.getString();
}

// TODO remove, obsolete with IloConstraintItem
function _IloOdmsIde_ExpandArray(array,leafIndex) {
  var out = new _IloOplDataOutputString();
  
  with (out) {
	startElement("expandArray");
	startSet();
	var access = "._getLeafItems("+leafIndex+",1)[0].value._expandable";
	_IloOdmsIde_DoExpand(out,array._getLeafItems(leafIndex,1)[0].value._expandable,access);
	endSet();
    endElement();
  }  
  return out.getString();
}

function _IloOdmsIde_AbsoluteArrayItem(array,leafIndex) {
  return array._getLeafItems(leafIndex,1)[0].value;
}

// ---------------------------------------------------------------------------
// Debugging

function _IloOdmsIde_GetZone() {
	return _oplZone;
}

function _IloOdmsIde_GetFramesArray() {
	var result = new Array();
	var frame = _IloOplGetCurrentFrame();
	var count = 0;
	for(frame=frame.previous.previous.previous; frame!=null; frame=frame.previous) {
		result[count++] = frame;
	}
	// root frame gets index 0
	result.reverse();
	return result;
}

function _IloOdmsIde_GetFrame(i) {
	/* WONTWORK frames are reversed to get root at index 0
	var frame = _IloOplGetCurrentFrame();
	var count = 0;
	for(frame=frame.previous.previous; count<i; frame=frame.previous) {
		count++;
	}
	return frame;	
	*/
	return _IloOdmsIde_GetFramesArray()[i];
}

function _IloOdmsIde_AddFrame(out,frameNo,frame,access) {
	with (out) {
		startTuple();
		addIntItem(frameNo);
		addIntItem(frame.lineNo);
		addStringItem(frame.sourceDesc);
		addStringItem(((frame.funName==null)?"":frame.funName));
		addStringItem(access);
		endTuple();
	}
	return;
}

function _IloOdmsIde_GetFrames() {
  	var out = new _IloOplDataOutputString();
	var frames = _IloOdmsIde_GetFramesArray();
	var accessPrefix = "IloOdmsIde.getFrame";
	with (out) {
		startElement("frames");
		startSet();
		for(var i=frames.length-1; i>=0; i--) {
			var access = accessPrefix+"("+i+")";
			_IloOdmsIde_AddFrame(out,i,frames[i],access);
		}
		endSet();
    	endElement();
	}
  	return out.getString();
}

function _IloOdmsIde_AddArray(out,obj,accessPrefix) {
	with (out) {
		for(var i=0; i<obj.length; i++) {
			startTuple();
			addStringItem("["+i+"]");
			addStringItem(typeof obj[i]);
			addStringItem(obj[i]);
			addStringItem(accessPrefix+"["+i+"]");
			endTuple();
			if ( i>100 ) {
				startTuple();
				addStringItem("...");
				addStringItem("");
				addStringItem("...");
				addStringItem(null);
				endTuple();				
				break;				
			}
		}
	}
	return;
}

function _IloOdmsIde_AddSet(out,obj) {
	with (out) {
		var count=0;
		for(var p in obj) {
			startTuple();
			addStringItem(count);
			addStringItem(typeof p);
			addStringItem(p);
			addStringItem(null);
			endTuple();
			count++;
			if ( count>100 ) {
				startTuple();
				addStringItem("...");
				addStringItem("");
				addStringItem("...");
				addStringItem(null);
				endTuple();
				break;				
			}
		}
	}
	return;
}

function _IloOdmsIde_AddOneProperty(out,obj,property,accessPrefix) {
	with (out) {
			startTuple();
			addStringItem(property);
			addStringItem(typeof obj[property]);
			addStringItem(obj[property]);
			addStringItem(accessPrefix+"."+property);
			endTuple();
	}
}

function _IloOdmsIde_AddObject(out,obj,accessPrefix) {
	var objType = typeof obj;
	var objValue = ""+obj;
	if ( objType=="number" || objType=="string" ) {
		return;
	}
	// Exists?
	if ( objValue.indexOf("[a deleted")==0 ) {
		return;
	}	
	if ( objType=="IloOplMain.IloOplRunConfiguration" ) {
		return;
	}	
	if ( objType=="IloOplRelaxationIterator" || objType=="IloOplConflictIterator") {
		return;
	}
	if ( objType=="IloTupleSet" || objType=="IloDiscreteDataCollection" ) {
		_IloOdmsIde_AddSet(out,obj);
		return;
	}	
	if ( objType=="object" && (typeof obj.length)!="undefined" ) {
		_IloOdmsIde_AddArray(out,obj,accessPrefix);
		return;
	} 
	with (out) {
		var count=0;		
		for(var p in obj) {
			var pType = typeof p;
			var objpType = typeof obj[p];
			var objpValue = ""+obj[p];
		    if ( pType=="string" && p.charAt(0)=="_" ) { continue; }
		    if ( objpType=="function" ) { continue; }
		    if ( objpValue.indexOf("[a deleted")==0 ) { continue; }
			startTuple();
			addStringItem(p);
			addStringItem(objpType);
			addStringItem(objpValue);
			if ( pType=="string" ) {
				addStringItem(accessPrefix+"."+p);
			} else if ( pType=="IloTuple" ) {
				addStringItem(null);
			} else {
				addStringItem(accessPrefix+"["+p+"]");
			}
			endTuple();
			count++;
			if ( count>100 ) {
				startTuple();
				addStringItem("...");
				addStringItem("");
				addStringItem("...");
				addStringItem(null);
				endTuple();
				break;				
			}
		}
		// special properties for IloOplModel
		if ( objType == "IloOplModel" || objType == "IloOplMain.IloOplModel" ) {
			_IloOdmsIde_AddOneProperty(out,obj,"settings",accessPrefix);
		}
	}
	return;
}

function _IloOdmsIde_DoGetEnv(env,accessPrefix) {
  	var out = new _IloOplDataOutputString();
	with (out) {
		startElement("env");
		startSet();
		
		// redudent with local scope
		//if ( env.args ) {
		//	startTuple();
		//	addStringItem("[arguments]");
		//	addStringItem("");
		//	addStringItem("");
		//	addStringItem(accessPrefix+".args");
		//	endTuple();
		//}
		
		_IloOdmsIde_AddObject(out,env.object,accessPrefix+".object");
		
		if ( env.parent ) {
			startTuple();
			addStringItem("[with]");
			addStringItem(typeof env.parent.object);
			addStringItem(env.parent.object);
			addStringItem(accessPrefix+".parent");
			endTuple();
		}

		if ( env.that ) {
			startTuple();
			addStringItem("this");
			addStringItem(typeof env.that);
			addStringItem(env.that);
			addStringItem(accessPrefix+".that");
			endTuple();
		}

		endSet();
    	endElement();
	}
	return out.getString();
}

function _IloOdmsIde_GetFrameEnv(frame) {
	return _IloOdmsIde_DoGetEnv(frame.env,".env");
}

function _IloOdmsIde_GetEnv(env) {
	return _IloOdmsIde_DoGetEnv(env,"");
}

function _IloOdmsIde_GetObject(obj) {
  	var out = new _IloOplDataOutputString();
	with (out) {
		startElement("object");
		startSet();
		_IloOdmsIde_AddObject(out,obj,"");
		endSet();
    	endElement();
	}
  	return out.getString();
}

// FRED
function _IloOdmsIde_GetVarArrayRC(array,leafIndex) {
   var out = new _IloOplDataOutputString();
   with (out) {
    startElement("f");
     // get leaf element  ?
    var x = _IloOdmsIde_GetRCValue(thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0]);
    addStringItem(x);
    endElement();
   }
   return out.getString();
}

function _IloOdmsIde_GetVarArrayRC2(array,leafIndex) {
	return _IloOdmsIde_GetRCValue(thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0]);
}

function _IloOdmsIde_GetRCValue(elt) {
	return elt.value.reducedCost;
}

function _IloOdmsIde_GetVarArraySR(array,leafIndex) {
   var out = new _IloOplDataOutputString();
   with (out) {
	   startElement("f");
	   var x = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0];
	   addStringItem(_IloOdmsIde_GetSRValue(x));
	   endElement();
   }
   return out.getString();
}

function _IloOdmsIde_GetVarArraySR2(array,leafIndex) {
    var x = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0];
    return _IloOdmsIde_GetSRValue( x );
}

function _IloOdmsIde_GetSRValue(elt) {
    var boundSA = elt.value._boundSA;
    // TODO: format better (or send all 4 values), create a real tuple...
    var boundval = "[" + boundSA[0] + ".." + boundSA[1] + "] [" + boundSA[2] + ".." + boundSA[3] + "]";
    return boundval;	
}

function _IloOdmsIde_LTrim(str) {
	var i = 0;
	while( str.charAt(i) == ' ' ) {
		i++;
	}
	var result = "";
	for( ;i < str.length; i++) {
		result += str.charAt(i);	
	}
	return result;
}

function _IloOdmsIde_SaveScalarArray(array, row, nbRequested) {
	var nbElem = thisOplModel[array]._totalSize;
	if( nbRequested == -1 ) {
		nbRequested = nbElem;
	}
	var save = thisOplModel.settings.displayPrecision;
	thisOplModel.settings.displayPrecision = -1;
	var out = new _IloOplDataOutputString();
	with (out) {
		startElement("getValues");
		startSet();		
		for( var count = 0; count< nbRequested && row < nbElem; ++row, count++ ) {
			startTuple();
			var item = thisOplModel[array]._getLeafItems(row, 1, false)[0].value;
			if( typeof item == "string" ) {
				addStringItem(_IloOdmsIde_LTrim(item));
			} else {
				var tmp = new _IloOplDataOutputString();
				tmp.addNumItem(item);
				addStringItem(_IloOdmsIde_LTrim(tmp.getString()));				
			}
			endTuple();
		}
		endSet();
		endElement();
	}
	thisOplModel.settings.displayPrecision = save;	
	return out.getString();
}

function _IloOdmsIde_SaveNumVarArray(array, row, nbRequested) {

	var saveDisplayPrecision = thisOplModel.settings.displayPrecision;
	thisOplModel.settings.displayPrecision = -1;
	var out = new _IloOplDataOutputString();
	with (out) {
		startElement("getValues");
		startSet();		
		var nbElem = 200;

		var totalSize = thisOplModel[array]._totalSize;
		var stop = totalSize;
		if( row + nbRequested < totalSize && nbRequested != -1) {
			stop = row + nbRequested;
		}
		while(  row < stop ) {		
			if( row + nbElem > stop ) {
				nbElem = stop - row;
			}
			var items = thisOplModel[array]._getLeafItems(row, nbElem, false);
			row += nbElem;
			
			for( var i = 0; i < nbElem; ++i ) {
				var item = items[i];
				startTuple();
				var tmp = new _IloOplDataOutputString();
				tmp.addNumItem( item.value.solutionValue );
				addStringItem(_IloOdmsIde_LTrim(tmp.getString()));
				addStringItem(_IloOdmsIde_GetRCValue(item));
				addStringItem(_IloOdmsIde_GetSRValue(item));
				endTuple();
			}
		}
		endSet();
		endElement();
	}
	thisOplModel.settings.displayPrecision = saveDisplayPrecision;	
	return out.getString();
}

function _IloOdmsIde_SaveConstraintArray(array, row, nbRequested, nbFields) {
	var nbElem = thisOplModel[array]._totalSize;
	if( nbRequested == -1 ) {
		nbRequested = nbElem;
	}
	var save = thisOplModel.settings.displayPrecision;
	thisOplModel.settings.displayPrecision = -1;
	var out = new _IloOplDataOutputString();
	with (out) {
		startElement("getValues");
		startSet();		
		for( var count = 0; count< nbRequested && row < nbElem; ++row, count++ ) {
			startTuple();
			addStringItem(_IloOdmsIde_GetCtArrayValue2(array, row));
			if( nbFields > 1 ) {
				addStringItem(_IloOdmsIde_GetCtArraySlack2(array,row));
				if( nbFields > 2 ) {
					addStringItem(_IloOdmsIde_GetCtArrayDual2(array,row));
				}
			}			
			endTuple();
		}
		endSet();
		endElement();
	}
	thisOplModel.settings.displayPrecision = save;	
	return out.getString();
}

// access to individual constraint in an array
//Only for Collocated ...
function _IloOdmsIde_GetCtArraySlack(array,leafIndex) {
   var out = new _IloOplDataOutputString();
   with (out) {
    startElement("f");
    var ct = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0].value;
    addStringItem(ct.slack);
    endElement();
   }
   return out.getString();
}

function _IloOdmsIde_GetCtArraySlack2(array,leafIndex) {
   var ct = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0].value;
   return ct.slack;
}

// Only for Collocated ...
function _IloOdmsIde_GetCtArrayDual(array,leafIndex) {
   var out = new _IloOplDataOutputString();
   with (out) {
    startElement("f");
    var ct = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0].value;
    addStringItem(ct.dual);
    endElement();
   }
   return out.getString();
}

function _IloOdmsIde_GetCtArrayDual2(array,leafIndex) {
   var ct = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0].value;
   return ct.dual;
}

// Only for Collocated ...
function _IloOdmsIde_GetCtArrayValue(array,leafIndex) {
   var out = new _IloOplDataOutputString();
   with (out) {
   startElement("f");
   var ct = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0].value;
	addStringItem(ct._expandable.print);
    endElement();
   }
   return out.getString();
}

function _IloOdmsIde_GetCtArrayValue2(array,leafIndex){
	var ct = thisOplModel[array]._getLeafItems(leafIndex, 1, true)[0].value;
    return ct._expandable.print;
}

function _IloOdmsIde_OutputScalarConstraintSlackAndDual(out, ct) {
   with (out) {
      addStringItem(ct.slack);
      addStringItem(ct.dual);
   }
}

function _IloOdmsIde_OutputScalarConstraintBounds(out, ct) {
   with (out) {
      addStringItem(ct.LB);
      addStringItem(ct.UB);
   }
}

// value + slack + dual
function _IloOdmsIde_GetConstraintArrayInfo(array, leafIndex, level) {
   var out = new _IloOplDataOutputString();
   with (out) {
    startElement("cmapinfo");
    startSet();
    // using cache does take too much memory ?
    var leaf = array._getLeafItems(leafIndex, 1, false)[0];
    var ct = leaf.value;
    addStringItem(ct._expandable.print);
    if (level > 1) {
      addStringItem(ct.slack);
      if (level > 2) {
      	addStringItem(ct.dual);
      }
    }
    endSet();
    endElement();
   }
   return out.getString();
}

function _IloOdmsIde_GetIntervalArrayInfo(array,leafIndex) {
   var out = new _IloOplDataOutputString();
   with (out) {
    startElement("intervalmapinfo");
    startTuple();
    var leaf = array._getLeafItems(leafIndex, 1, true)[0];
    var interval = leaf.value;
    addStringItem(interval.present);
    addStringItem(interval.start);
    addStringItem(interval.end);
    addStringItem(interval.size);
    endTuple();
     endElement();
   }
   return out.getString();
}

// returns a set of values for given properties (in array order)
function _IloOdmsIde_getFullArraySortInfo(name, property) {
	var out = new _IloOplDataOutputString();
   	with (out) {
	    startElement("sortinfo");
	    startSet();
		for (var i = 0; i < name._totalSize; ++i) {
		   var item = name._getLeafItems(i, 1, true)[0].value;
	       addIntItem(item[property]);
	    }
	    endSet();
	    endElement();
	}
	return out.getString();
}

function _IloOdmsIde_GetScalarConstraintInfo(ct) {
   var out = new _IloOplDataOutputString();
   with (out) {
    startElement("cinfo");
    startSet();
    startTuple();
    _IloOdmsIde_OutputScalarConstraintSlackAndDual(out, ct);
    _IloOdmsIde_OutputScalarConstraintBounds(out, ct);
    endTuple();
    endSet();
    endElement();
   }
   return out.getString();
}

// ---------------------------------------------------------------------------

function _IloOdmsIde_WriteExternalData(path) {
	var out = new IloOplOutputFile(path);
	var save = thisOplModel.settings.displayPrecision;
	thisOplModel.settings.displayPrecision = -1;
	out.writeln( thisOplModel._all.printExternalData() );
	thisOplModel.settings.displayPrecision = save;
	out.close();
	return "OK";
}

function _IloOdmsIde_WriteInternalData(path) {
	var out = new IloOplOutputFile(path);
	var save = thisOplModel.settings.displayPrecision;
	thisOplModel.settings.displayPrecision = -1;
	out.writeln( thisOplModel._all.printInternalData() );
	thisOplModel.settings.displayPrecision = save;
	out.close();
	return "OK";
}

function _IloOdmsIde_GetNumberOfSegments(func) {
	var out = new _IloOplDataOutputString();
	with (out) {
		startElement("getNumberOfSegments");
		addNumItem( func.getNumberOfSegments() );
		endElement();
	}
	return out.getString();
}

function _IloOdmsIde_GetFunctionSegments(func) { 
	  var out = new _IloOplDataOutputString();
	  out.startElement("getFunctionSegments");
	  _IloOdmsIde_GetInternalFunctionSegments(func, out);
	  out.endElement();
	  return out.getString();
}

function _IloOdmsIde_GetInternalFunctionSegments(func, out) { 
	  with (out) {
		startSet();
		for( var i = 0; i < func.getNumberOfSegments(); ++i ) {
			startTuple(); 
			addNumItem( func.getSegmentStart(i) );
			addNumItem( func.getSegmentEnd(i) );
			addNumItem( func.getSegmentValue(i) );
			endTuple();
		}
		endSet();
	  }
}

function _IloOdmsIde_SaveVersion( path ) {
	var out = new IloOplOutputFile( path + "/+version");
	var serializer = new _IloOplDataOutputString();
	with(serializer) {
		startElement("bridgeVersion");
		addIntItem(2);
		endElement();
	}
	out.writeln(serializer.getString());
	out.close();
}

function _IloOdmsIde_Save( path ) {
	_IloOdmsIde_Save2( path, false );
}

function _IloOdmsIde_Save2( path, fromServer ) {
	_IloOdmsIde_SaveVersion( path );
	
	var out = new IloOplOutputFile( path + "/+model");
	with( out ) {
		writeln( _IloOdms_request( "getElements" ) );	
		writeln( _IloOdms_request( "getSolutions" ) );
		writeln( _IloOdms_request( "getInfo" ) );
	}
	out.close();

	var sum = 0;
	var allElt = _IloOdms_request( "getAllElement" );
	for( var i=0; i < allElt.length; ++i){
		var elt = allElt[i];
		var isAvailable = _IloOdms_OplElement_request( "isInfoAvailable",elt );

//		var start = new Date();
//		write( elt, ": [", typeof thisOplModel[elt], "]  (", start);
		
		_IloOdmsIde_SaveElt( path, elt );

		if( isAvailable ) {						
			var type = _IloOdms_OplElement_request( "getBridgeName",elt);
			if(  type == "ARRAY" || type == "MAP_INTERVAL") {
				_IloOdmsIde_SaveMap( path, elt );
				_IloOdmsIde_SaveIndexer( path, elt );
			} else if( type == "SET" ) {
				_IloOdmsIde_SaveSet( path, elt );
			} else if( type == "SET_TUPLE" ) {
				_IloOdmsIde_SaveTupleSet( path, elt );				
			} else if( type == "SEQUENCE" ) {
				_IloOdmsIde_SaveSequence( path, elt );
			} else if( type == "MAP_TUPLE" ) {
				_IloOdmsIde_SaveTupleMap( path, elt );
				_IloOdmsIde_SaveIndexer( path, elt );
			} else if( type == "MAP_SET_TUPLE" || type == "MAP_SEQUENCE" ) {
				_IloOdmsIde_SaveTupleSetMap( path, elt );
				_IloOdmsIde_SaveIndexer( path, elt );
			} else if( type == "CUMUL_FUNCTION" || type == "STATE_FUNCTION") {
				_IloOdmsIde_SaveFunction( path, elt );
			} else if( type == "MAP_CUMUL_FUNCTION" || type == "MAP_STATE_FUNCTION") {
				_IloOdmsIde_SaveFunctionMap( path, elt );
				_IloOdmsIde_SaveIndexer( path, elt );
			} else if( type == "TUPLE" ) {
				_IloOdmsIde_SaveTuple( path, elt );
			}
		}
//		var end = new Date();
//		sum += end-start;
//		writeln( ", ", end, ")   ", end-start);
	}
//	writeln( "TOTAL: ", sum);
	
	_IloOdmsIde_SaveProfile(path);
	
	if( fromServer && !thisOplModel.modelDefinition.hasMain()) {
		_IloOdmsIde_SaveRelaxations(path);
		_IloOdmsIde_SaveConflicts(path);
	}
	return "OK";
}

function _IloOdmsIde_SaveConflicts( path ) {
	var out = new IloOplOutputFile( path + "/ilog.odms.ide.ui.views.ConflictsView");
	out.write( _IloOdmsIde_GetConflicts() );
	out.close();
}

function _IloOdmsIde_SaveRelaxations( path ) {
	var out = new IloOplOutputFile( path + "/ilog.odms.ide.ui.views.RelaxationsView");
	out.write( _IloOdmsIde_GetRelaxations() );
	out.close();
}

function _IloOdmsIde_SaveProfile( path ) {
	var out = new IloOplOutputFile( path + "/ilog.odms.ide.ui.views.ProfilerView");
	out.write( _IloOdmsIde_GetProfile() );
	out.close();
}

function _IloOdmsIde_IsUpper(ch) { 
	var uppers = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; 
	return uppers.indexOf(ch) != -1; 
}

function _IloOdmsIde_GetEltFile( elt ) {
	var f = "";
	var c;
    for (var i=0; i<elt.length; i++) {
		c = elt.charAt(i);
		f += c;
		if (_IloOdmsIde_IsUpper(c)) {
			f += "+";
		}         
	}
	return f;       
}

function _IloOdmsIde_SaveElt( path, elt ) {
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "Elt" );
	with( out ) {	
		writeln(_IloOdms_OplElement_request( "getElementInfos",elt));
		writeln(_IloOdms_OplElement_request( "getElementType",elt));
		writeln(_IloOdms_OplElement_request( "getValue",elt));
		writeln(_IloOdms_Location_request( "getLocationInfos",elt));
	}
	out.close();
}

function _IloOdmsIde_SaveMap( path, elt ) {
	_IloOdmsIde_SaveMap2( path, elt, false );
}

function _IloOdmsIde_SaveMap2( path, elt, isTupleMap ) {
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "Map" );	
	with( out ) {
		var obj = _IloOdmsIde_createObject( elt );
		writeln(IloOplCallJava(obj,"getInfo",""));
		writeln(IloOplCallJava(obj,"getColumnsInfo",""));
		writeln(IloOplCallJava(obj,"getValueColumns",""));
		var totSize = thisOplModel[ elt ]._totalSize;
		if( isTupleMap ) {
			_IloOdmsIde_SaveTupleMapValues( out, elt );
		} else {
			for( var i=0; i < totSize; i+=1000 ) {			
				writeln(IloOplCallJava(obj,"getValues2","",i,1000));
			}
		}
	}
	out.close();
}

function _IloOdmsIde_SaveTupleMapValues( outFile, elt ) {
	var totSize = thisOplModel[elt]._totalSize;
	var requested = 200;
	var i = 0;
	while(  i < totSize ) {
		var tmp = thisOplModel[elt]._getLeafItems(i, requested, false);
		var out = new _IloOplDataOutputString();
		out.startElement("getValues");
		out.startSet();
		for( var t = 0; t < requested; ++t ) {
			out.startTuple();
			_IloOdmsIde_printTuple( tmp[t].value, out );
			out.endTuple();
		}
		out.endSet();
		out.endElement();
		outFile.writeln( out.getString() );		
		out.close();		
		i += requested; 
		if( i+requested > totSize ) {
	       requested = totSize - i;
		}
	}
}  

function _IloOdmsIde_ToString( item ) {
	if( typeof item == "string") {
	    var out = new _IloOplDataOutputString();
	    out.addStringItem(item);
	    return _IloOdmsIde_LTrim(out.getString());
	}
	return String( item );
}

function _IloOdmsIde_printTuple( aTuple, out ) {
	with( out ) {
		for( var field in aTuple ) {	
			if( typeof aTuple[field] == "IloTuple" ) {
				_IloOdmsIde_printTuple(aTuple[field], out);
			} else {
				addStringItem( _IloOdmsIde_ToString( aTuple[field] ) );
			}
		}
	}		
}

function _IloOdmsIde_SaveIndexer( path, elt ) {
	var obj = _IloOdmsIde_createObject( elt );
	var dim = IloOplCallJava(obj,"getDimensions","");
	for( var i = 0; i < dim; ++i ) {
		var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "Indexer" + i + "" );
		with( out ) {
			writeln(_IloOdms_Indexer_request2("getInfo", elt, i));
			writeln(_IloOdms_Indexer_request2("getIndexerInfo", elt, i));
			writeln(_IloOdms_Indexer_getSummaryColumnValue(elt, i, 0, -1));
			writeln(_IloOdms_Indexer_getColumnsValue(elt, i, 0, -1));
		}
		out.close();
	}
}

function _IloOdmsIde_SaveTupleMap( path, elt ) {
	_IloOdmsIde_SaveTupleMap2( path, elt, true );	
}

function _IloOdmsIde_SaveTupleMap2( path, elt, realTupleMap ) {
	_IloOdmsIde_SaveMap2( path, elt, realTupleMap );
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "TupleMap" );
	with( out ) {
		var obj = _IloOdmsIde_createObject( elt );
		writeln(IloOplCallJava(obj,"getSchema",""));
	}
	out.close();	
}

function _IloOdmsIde_SaveTupleSetMap( path, elt ) {
	_IloOdmsIde_SaveTupleMap2( path, elt, false );
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "TupleSetMap" );
	with( out ) {
		writeln(_IloOdms_TupleSetMap_request("getTotalRows", elt));
		writeln(_IloOdms_TupleSetMap_request("getSetSize", elt));
		writeln(_IloOdms_TupleSetMap_request("getMapIndexOfRows", elt));
		writeln(_IloOdms_TupleSetMap_request("getSetIndexOfRows", elt));
	}
	out.close();	
}

function _IloOdmsIde_SaveSet( path, elt ) {
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "Set" );
	with( out ) {
		var obj = _IloOdmsIde_createObject( elt );
		writeln(IloOplCallJava(obj,"getSize",""));
		writeln(IloOplCallJava(obj,"getTextValue","",0,-1));		
	}
	out.close();
}

function _IloOdmsIde_SaveTupleSet( path, elt ) {
	//writeln( "   set");
	_IloOdmsIde_SaveSet( path, elt );	
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "TupleSet" );
	with( out ) {	
		writeln(_IloOdms_TupleSet_request("getColumnInfo", elt));
		writeln(_IloOdms_TupleSet_request("getTotalColumnNumber", elt));
		_IloOdmsIde_SaveTupleSetValues( elt, out );
		writeln(_IloOdms_TupleSet_request("getSchema", elt));
	}
	out.close();
}

function _IloOdmsIde_SaveSequence( path, elt ) {
	_IloOdmsIde_SaveSet( path, elt );	
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "TupleSet" );
	with( out ) {	
		writeln(_IloOdms_TupleSet_request("getColumnInfo", elt));
		writeln(_IloOdms_TupleSet_request("getTotalColumnNumber", elt));
		writeln(_IloOdms_TupleSet_request3("getValues",elt, 0, -1));
		writeln(_IloOdms_TupleSet_request("getSchema", elt));
	}
	out.close();
}

function _IloOdmsIde_printAllFields( aTuple, out ) {
	with( out ) {
		var fields = aTuple._getFields();
		for( var i=0; i < fields.length; ++i ) {
			var aField = aTuple[fields[i]];
			if( typeof aField  == "IloTuple" ) {
				_IloOdmsIde_printAllFields(aField, out);
			} else {
				addStringItem( _IloOdmsIde_ToString( aField ) );
			}
		}
	}		
}

function _IloOdmsIde_SaveTupleSetValues(elt, outFile) {
	var aTupleSet = thisOplModel[elt];
	var fields;
	for( var f in aTupleSet ) {
		fields = f._getFields();
		break;
	}
	
  	var out = new _IloOplDataOutputString();  
	out.startElement("getValues");
  	out.startSet();
  
	var count = 0;			
	for( var aTuple in aTupleSet ) {  
		out.startTuple();  
		for( var t = 0; t < fields.length; ++t ) {
			if( typeof aTuple[fields[t]] == "IloTuple" ) {
				_IloOdmsIde_printAllFields( aTuple[fields[t]], out );
			} else {
				out.addStringItem( _IloOdmsIde_ToString(aTuple[fields[t]]) );
			}
		}
		out.endTuple();
      					
		count += 1;
		if( count > 999 ) {
			count = 0;
			out.endSet();
			out.endElement();
			outFile.writeln( out.getString() );		
			out.close();  
          		
			out = new _IloOplDataOutputString();  
			out.startElement("getValues");          		
			out.startSet();
		}      					  
	}  
  
	out.endSet();
	out.endElement();
	outFile.writeln( out.getString() );		
	out.close();		
}  



function _IloOdmsIde_SaveFunction( path, elt ) {
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "Function" );
	with( out ) {	
		write(_IloOdmsIde_GetNumberOfSegments( thisOplModel[elt] ) );
		write(_IloOdmsIde_GetFunctionSegments( thisOplModel[elt] ) );
	}
	out.close();
}

function _IloOdmsIde_SaveFunctionMap( path, elt ) {
	_IloOdmsIde_SaveMap( path, elt );
	
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "FunctionMap" );
	with( out ) {
		write(_IloOdmsIde_GetFunctionMapNumberOfSegments(thisOplModel[elt]));
		write(_IloOdmsIde_GetFunctionMapSegments(thisOplModel[elt]));
	}	
	out.close();	
}

function _IloOdmsIde_SaveTuple( path, elt ) {
	var out = new IloOplOutputFile( path + "/" + _IloOdmsIde_GetEltFile( elt ) + "Tuple" );
	with( out ) {
		write(_IloOdms_Tuple_request("getSchema", elt));
	}	
	out.close();		
}

function _IloOdmsIde_GetFunctionMapNumberOfSegments( elt ) {
	  var out = new _IloOplDataOutputString(); 
	  with (out) {
		startElement("getFunctionsNumberOfSegment");
		startSet();
		for( var i = 0; i < elt._totalSize; ++i ) {
			addIntItem( elt._getLeafItems(i, 1, false)[0].value.getNumberOfSegments() );
		}
		endSet();
	    endElement();
	  }	  
	  return out.getString();		
}

function _IloOdmsIde_GetFunctionMapSegments( elt ) {
	  var out = new _IloOplDataOutputString(); 
	  with (out) {
		startElement("getFunctionsSegments");
		startArray()
		for( var i = 0; i < elt._totalSize; ++i ) {
			var fct = elt._getLeafItems(i, 1, false)[0].value;
			_IloOdmsIde_GetInternalFunctionSegments(fct, out);			
		}
		endArray();
	    endElement();
	  }
	  return out.getString();	
}

function _IloOdmsIde_createObject( eltName ) {
	return IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloMapHelper",
			"createInstance","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
}

// ---------------------------------------------------------------------------
function _IloOdms_request( methodName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloModelBridge",
								"<init>","(Lilog/opl/IloOplModel;)V",thisOplModel);
	return IloOplCallJava(myObject,methodName,"");		  
}

function _IloOdms_OplElement_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloModelElementBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");						  
}

function _IloOdms_Set_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloSetBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");	
} 

function _IloOdms_Set_request2( methodName, eltName, index ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloSetBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", index);	
}

function _IloOdms_Set_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloSetBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);	
}

function _IloOdms_Location_request( methodName, eltName ) {
	return IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloLocationScriptHelper",
						  methodName,"",thisOplModel,eltName);
}

function _IloOdms_Location( methodName ) {
	return IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloLocationScriptHelper",
						  methodName,"",thisOplModel);
}

function _IloOdms_Map_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_Map_request2( methodName, eltName, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_Map_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}

function _IloOdms_NumVarMap_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloNumVarMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_NumVarMap_request2( methodName, eltName, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloNumVarMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_NumVarMap_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloNumVarMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}

function _IloOdms_ConstraintMap_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloConstraintMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_ConstraintMap_request2( methodName, eltName, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloConstraintMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_ConstraintMap_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloConstraintMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}

function _IloOdms_Tuple_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleBridge",
			"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_TupleMap_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_TupleMap_request2( methodName, eltName, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_TupleMap_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}

function _IloOdms_TupleMap_request4( methodName, eltName, param1, param2, param3 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2, param3);
}

function _IloOdms_TupleMap_request5( methodName, eltName, param1, param2, param3, param4 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2, param3, param4);
}


function _IloOdms_TupleSet_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleSetBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_TupleSet_request2( methodName, eltName, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleSetBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_TupleSet_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleSetBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}

function _IloOdms_TupleSetMap_request( methodName, eltName ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleSetMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_TupleSetMap_request2( methodName, eltName, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleSetMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_TupleSetMap_request3( methodName, eltName, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloTupleSetMapBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;)V",thisOplModel,eltName);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}


// ----------- Indexer ---------------------
function _IloOdms_Indexer_getColumnsValue( map, dim, row, nbRequested ) {

    var tmpMap = thisOplModel[map];
    while( dim > 0 ) {
        for( var v in tmpMap.indexer ) {
            tmpMap = tmpMap[v];
            break;
        }                 
        dim-=1;
    }       
   
    var size = tmpMap.size;
    if( nbRequested == -1 ) {
        nbRequested = size;
    }
    var out = new _IloOplDataOutputString();
    with( out ) {
        startElement("getColumnsValue");
        startSet();    
        if( typeof tmpMap.indexer == "IloIntRange" ) {
            var lb = tmpMap.indexer.LB;
            for( var j = 0; j < nbRequested && row < size; ++row, ++j ) {
                startTuple();       
                addStringItem( String(lb+row) );
                endTuple();
            }          
        } else if( typeof tmpMap.indexer ==  "IloTupleSet" ) {
            for( var k = 0; k < nbRequested && row < size; ++row, ++k ) { 
            	startTuple();
            	_IloOdmsIde_printTuple(Opl.item(tmpMap.indexer,row), out);
	            endTuple();
             }	            		    			
        } else {          
            for( var i = 0; i < nbRequested && row < size; ++row, ++i ) {
                startTuple();       
                addStringItem( _IloOdmsIde_LTrim(_IloOdmsIde_ToString(Opl.item(tmpMap.indexer,row))) );
                endTuple();                
            }       
        }   
        endSet();
        endElement();
    }
   
   return out.getString();
}

function _IloOdms_Indexer_getSummaryColumnValue( map, dim, row, nbRequested ) {

    var tmpMap = thisOplModel[map];
    while( dim > 0 ) {
        for( var v in tmpMap.indexer ) {
            tmpMap = tmpMap[v];
            break;
        }                 
        dim-=1;
    }       
   
    var size = tmpMap.size;
    if( nbRequested == -1 ) {
        nbRequested = size;
    }
    var out = new _IloOplDataOutputString();
    with( out ) {
        startElement("getSummaryColumnValue");
        startSet();    
        if( typeof tmpMap.indexer == "IloIntRange" ) {
            var lb = tmpMap.indexer.LB;
            for( var j = 0; j < nbRequested && row < size; ++row, ++j ) {       
                addStringItem( String(lb+row) );
            }          
        } else {     
            for( var i = 0; i < nbRequested && row < size; ++row, ++i ) {       
                addStringItem( _IloOdmsIde_LTrim(_IloOdmsIde_ToString(Opl.item(tmpMap.indexer,row))) );
            }       
        }   
        endSet();
        endElement();
    }
   
   return out.getString();
}  

function _IloOdms_Indexer_request2( methodName, eltName, dim ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloIndexerBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;I)V",thisOplModel,eltName,dim);
	return IloOplCallJava(myObject,methodName,"");
}

function _IloOdms_Indexer_request3( methodName, eltName, dim, param1 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloIndexerBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;I)V",thisOplModel,eltName,dim);
	return IloOplCallJava(myObject,methodName,"", param1);
}

function _IloOdms_Indexer_request4( methodName, eltName, dim, param1, param2 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloIndexerBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;I)V",thisOplModel,eltName,dim);
	return IloOplCallJava(myObject,methodName,"", param1, param2);
}

function _IloOdms_Indexer_request5( methodName, eltName, dim, param1, param2, param3 ) {
	var myObject=IloOplCallJava("ilog.odms.ide.opllang.remote.scripting.IloIndexerBridge",
								"<init>","(Lilog/opl/IloOplModel;Ljava/lang/String;I)V",thisOplModel,eltName,dim);
	return IloOplCallJava(myObject,methodName,"", param1, param2, param3);
}

// ---------------------------------------------------------------------------

IloOdmsIde = new Object();


IloOdmsIde.getConflicts = _IloOdmsIde_GetConflicts;
IloOdmsIde.hasRelaxations = _IloOdmsIde_HasRelaxations;
IloOdmsIde.getRelaxations = _IloOdmsIde_GetRelaxations;
IloOdmsIde.getProfile = _IloOdmsIde_GetProfile;
IloOdmsIde.expand = _IloOdmsIde_Expand;
// TODO remove, obsolete with IloConstraintItem
IloOdmsIde.expandArray = _IloOdmsIde_ExpandArray;
IloOdmsIde.absoluteArrayItem = _IloOdmsIde_AbsoluteArrayItem;

IloOdmsIde.getZone = _IloOdmsIde_GetZone;
IloOdmsIde.getFrame = _IloOdmsIde_GetFrame;
IloOdmsIde.getFrames = _IloOdmsIde_GetFrames;
IloOdmsIde.getFrameEnv = _IloOdmsIde_GetFrameEnv;
IloOdmsIde.getEnv = _IloOdmsIde_GetEnv; 
IloOdmsIde.getObject = _IloOdmsIde_GetObject; 

IloOdmsIde.getVarArrayRC = _IloOdmsIde_GetVarArrayRC;
IloOdmsIde.getVarArraySR = _IloOdmsIde_GetVarArraySR;
IloOdmsIde.getVarArrayRC2 = _IloOdmsIde_GetVarArrayRC2;
IloOdmsIde.getVarArraySR2 = _IloOdmsIde_GetVarArraySR2;
IloOdmsIde.getCtArraySlack = _IloOdmsIde_GetCtArraySlack;
IloOdmsIde.getCtArrayDual = _IloOdmsIde_GetCtArrayDual;
IloOdmsIde.getCtArrayValue = _IloOdmsIde_GetCtArrayValue;
IloOdmsIde.getCtArraySlack2 = _IloOdmsIde_GetCtArraySlack2;
IloOdmsIde.getCtArrayDual2 = _IloOdmsIde_GetCtArrayDual2;
IloOdmsIde.getCtArrayValue2 = _IloOdmsIde_GetCtArrayValue2;
IloOdmsIde.getConstraintArrayInfo = _IloOdmsIde_GetConstraintArrayInfo;
IloOdmsIde.getIntervalArrayInfo = _IloOdmsIde_GetIntervalArrayInfo;
IloOdmsIde.getScalarConstraintInfo = _IloOdmsIde_GetScalarConstraintInfo;

IloOdmsIde.writeInternalData = _IloOdmsIde_WriteInternalData;
IloOdmsIde.writeExternalData = _IloOdmsIde_WriteExternalData;

IloOdmsIde.getFullArraySortInfo = _IloOdmsIde_getFullArraySortInfo;

// ---------------------------------------------------------------------------
IloOdmsIde.request = _IloOdms_request;
IloOdmsIde.oplElement_request = _IloOdms_OplElement_request;
IloOdmsIde.set_request = _IloOdms_Set_request;
IloOdmsIde.set_request2 = _IloOdms_Set_request2;
IloOdmsIde.set_request3 = _IloOdms_Set_request3;
IloOdmsIde.location = _IloOdms_Location;
IloOdmsIde.location_request = _IloOdms_Location_request;
IloOdmsIde.map_request = _IloOdms_Map_request;
IloOdmsIde.map_request2 = _IloOdms_Map_request2;
IloOdmsIde.map_request3 = _IloOdms_Map_request3;
IloOdmsIde.numVarMap_request = _IloOdms_NumVarMap_request;
IloOdmsIde.numVarMap_request2 = _IloOdms_NumVarMap_request2;
IloOdmsIde.numVarMap_request3 = _IloOdms_NumVarMap_request3;
IloOdmsIde.constraintMap_request = _IloOdms_ConstraintMap_request;
IloOdmsIde.constraintMap_request2 = _IloOdms_ConstraintMap_request2;
IloOdmsIde.constraintMap_request3 = _IloOdms_ConstraintMap_request3;
IloOdmsIde.tupleMap_request = _IloOdms_TupleMap_request;
IloOdmsIde.tupleMap_request2 = _IloOdms_TupleMap_request2;
IloOdmsIde.tupleMap_request3 = _IloOdms_TupleMap_request3;
IloOdmsIde.tupleMap_request4 = _IloOdms_TupleMap_request4;
IloOdmsIde.tupleMap_request5 = _IloOdms_TupleMap_request5;
IloOdmsIde.tupleSet_request = _IloOdms_TupleSet_request;
IloOdmsIde.tupleSet_request2 = _IloOdms_TupleSet_request2;
IloOdmsIde.tupleSet_request3 = _IloOdms_TupleSet_request3;
IloOdmsIde.tupleSetMap_request = _IloOdms_TupleSetMap_request;
IloOdmsIde.tupleSetMap_request2 = _IloOdms_TupleSetMap_request2;
IloOdmsIde.tupleSetMap_request3 = _IloOdms_TupleSetMap_request3;
IloOdmsIde.indexer_getColumnValue = _IloOdms_Indexer_getColumnsValue;
IloOdmsIde.indexer_getSummaryColumnValue = _IloOdms_Indexer_getSummaryColumnValue;
IloOdmsIde.indexer_request2 = _IloOdms_Indexer_request2;
IloOdmsIde.indexer_request3 = _IloOdms_Indexer_request3;
IloOdmsIde.indexer_request4 = _IloOdms_Indexer_request4;
IloOdmsIde.indexer_request5 = _IloOdms_Indexer_request5;

IloOdmsIde.getFunctionSegments = _IloOdmsIde_GetFunctionSegments;
IloOdmsIde.getNumberOfSegments = _IloOdmsIde_GetNumberOfSegments;

IloOdmsIde.save = _IloOdmsIde_Save;
// ---------------------------------------------------------------------------

"initRunCommOK";
