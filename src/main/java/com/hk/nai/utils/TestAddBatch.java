package com.hk.nai.utils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import org.jsoup.Jsoup;
import org.jsoup.select.Elements;

public class TestAddBatch {

	public static void main(String[] args) throws IOException {
		org.jsoup.nodes.Document doc=
				Jsoup.connect("http://www.hrd.go.kr/hrdp/api/apieo/APIEO0101T.do?authKey=AUH4A14dZOUPfSzwB1njsyBwRBT1Hd1H&outType=1&srchTraEndDt=20190601&srchTraStDt=20180101&sortCol=TR_STT_DT&returnType=XML&pageSize=297&pageNum=1&sort=ASC&srchKeco2=2001&srchKeco1=20&srchTraPattern=1&srchPart=-99&apiRequstPageUrlAdres=/jsp/HRDP/HRDPO00/HRDPOA10/HRDPOA10_1.jsp&apiRequstIp=112.221.224.124").get();
		Elements datas = doc.select("scn_list");
		
        Connection conn = null;
        PreparedStatement pstmt = null ;
        
        String url="jdbc:oracle:thin:@192.168.4.110:1521:xe";
        String user="WEBBOARD1108";
        String password="1234";
         
        String sql = "INSERT INTO ACADEMY(AC_SEQ,AC_NAME,AC_CLASS,AC_CRE_DATE,AC_LOCATION,AC_END_DATE) "
        		+ "VALUES(AC_SEQ.NEXTVAL,?,?,?,?,?)";

        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn=DriverManager.getConnection(url, user, password);
 
            pstmt = conn.prepareStatement(sql) ;
            System.out.println("DB연결성공!!");
             
            for(int i = 0; i < datas.size(); i++){
    			/*검색 조건분류*/
            	String AC_NAME = String.valueOf(datas.get(i).select("subTitle").text()); //학원명
            	String AC_CLASS = String.valueOf(datas.get(i).select("title").text()); //과정명
              	String AC_CRE_DATE = String.valueOf(datas.get(i).select("traStartDate").text()).trim();  //개강일
              	String AC_END_DATE = String.valueOf(datas.get(i).select("traEndDate").text()).trim();  //종강일
            	String AC_LOCATION = String.valueOf(datas.get(i).select("address").text()); //지역명   
  
    			/*과정상세페이지에서 불러올 정보*/
    			/*ex)-학원명,과정명,개강일*/
            	
     
                 pstmt.setString(1, AC_NAME) ;
                 pstmt.setString(2, AC_CLASS);
                 pstmt.setString(3, AC_CRE_DATE);
                 pstmt.setString(4, AC_LOCATION);
                 pstmt.setString(5, AC_END_DATE);
                 
            	
                // addBatch에 담기
                pstmt.addBatch();
                 
                // 파라미터 Clear
                pstmt.clearParameters() ;
                 
                 
                // OutOfMemory를 고려하여 만건 단위로 커밋
                if( (i % 10000) == 0){
                     
                    // Batch 실행
                    pstmt.executeBatch() ;
                     
                    // Batch 초기화
                    pstmt.clearBatch();
                     
                    // 커밋
                    conn.commit() ;
                     
                }
            }
             
             
            // 커밋되지 못한 나머지 구문에 대하여 커밋
            pstmt.executeBatch() ;
            conn.commit() ;
             
        }catch(Exception e){
            e.printStackTrace();
             
            try {
                conn.rollback() ;
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
             
        }finally{
            if (pstmt != null) try {pstmt.close(); pstmt = null;} catch(SQLException e){}
            if (conn != null) try {conn.close(); conn = null;} catch(SQLException e){}
        }

	}

}
