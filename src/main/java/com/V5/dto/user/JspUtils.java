package com.V5.dto.user;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.V5.dto.Show;

public class JspUtils {
	    public static boolean hasNonNullShowTime(Map<LocalDate, List<Show>> dateShowMap) {
	        
	    	System.out.println("=== > JspUtils");
	    	for (List<Show> showList : dateShowMap.values()) {
	    		    System.out.println("showList:"+showList);
	            for (Show show : showList) {
	            	System.out.println("===== show.getShowTime() ====:"+show.getShowTime());
	                if (show.getShowTime() != null) {
	                    return true;
	                }
	            }
	        }
	        return false;
	    }
	}



