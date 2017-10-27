#!/usr/bin/ruby
require 'mysql2'
require "spreadsheet"
	
def readTables()
  client = Mysql2::Client.new(
    :host     => '127.0.0.1', # 主机
    :username => 'root',      # 用户名
    :password => 'root',    # 密码
    :database => 'mydata',      # 数据库
    :encoding => 'utf8'       # 编码
  ) 
  table = "t_user"  
  result = client.query("select * from #{table}")  
  result.each do |item|
  puts "#{item}"
  result
  end
end

def writeExcel()

    result  = readTables()
    
    Spreadsheet.client_encoding="utf-8"

    book = Spreadsheet::Workbook.new
     
    sheet1=book.create_worksheet :name => "test1"
    
	sheet1.row(0)[0]="uid"
    sheet1.row(0)[1]="userName"
	
	i=0
    
    #result.size().times do |i|
	       
           result.each do |item|
                  i=i+1		   
				  sheet1.row(i)[0]="#{item['uid']}"
                  sheet1.row(i)[1]="#{item['userName']}"
           end	      
     
	#end
	
	book.write "#{Dir.pwd}/test1.xls"
end
      
writeExcel()

