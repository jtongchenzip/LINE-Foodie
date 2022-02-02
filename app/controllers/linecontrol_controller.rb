require 'line/bot'
class LinecontrolController < ApplicationController
    protect_from_forgery with: :null_session
  
    def webhook
      # 設定回復文字
      reply_text = keyword_reply(received_text)

      # 傳送訊息
      response = reply_to_line(reply_text)
          
      # 回應 200
      head :ok    
    end 

    # 取得對方說的話
    def received_text
      message = params['events'][0]['message']
      if message.nil?
        nil
      else
        message['text']
      end
    end


    # 關鍵字回覆
    def keyword_reply(received_text)
      $keyword = ""    
      keyword_mapping = {
        '牛排' => '你附近的牛排有:',
        '咖啡廳' => '你附近的咖啡廳有:',
        '甜點店' => '你附近的甜點店有:'
      }

      # 擷取關鍵字
      keysArray = []
      keysArray = keyword_mapping.keys
      #p keysArray
      #p keysArray.length

      i = 0
      while i < keysArray.length
        if received_text.include?keysArray[i]
          $keyword = keysArray[i]
        end
        i += 1
      end

      # 查表
      keyword_mapping[$keyword]    
    end


    # 傳送文字訊息到line
    def reply_to_line(reply_text)
      reply_text = '找美食請輸入關鍵字,如:咖啡廳' if reply_text.nil?
      

      # 取得reply roken
        reply_token = params['events'][0]['replyToken']

      # 設定textMessage
        textMessage = {
          type: 'text', 
          text: reply_text
        }
      

      # 設定 coffee carousel Mode Message
        coffeeCarouselModeMessage =   
          {
            "type": "template",
            "altText": "你搜尋了咖啡廳",
            "template": {
                "type": "carousel",
                "columns": [
                    {             
                      "thumbnailImageUrl": "https://i.ibb.co/371G73C/S-66674818.jpg",
                      "imageBackgroundColor": "#FFFFFF",
                      "title": "ACME CAFE",
                      "text": "LINE Pay回饋2%",
                      "defaultAction": {
                          "type": "uri",
                          "label": "View detail",
                          "uri": "http://example.com/page/123"
                      },
                      "actions": [
                          {
                              "type": "postback",
                              "label": "4.5顆星 點擊查看評論",
                              "data": "action=buy&itemid=111"
                          },
                          {
                              "type": "postback",
                              "label": "平均價位 $300",
                              "data": "action=add&itemid=111"
                          },
                          {
                              "type": "uri",
                              "label": "距離你500公尺",
                              "uri": "http://example.com/page/111"
                          }
                      ]
                    },
                    {
                      "thumbnailImageUrl": "https://i.ibb.co/bbNcYRS/S-66682899.jpg",
                      "imageBackgroundColor": "#000000",
                      "title": "93人文空間",
                      "text": "LINE Pay回饋1%",
                      "defaultAction": {
                          "type": "uri",
                          "label": "View detail",
                          "uri": "http://example.com/page/222"
                      },
                      "actions": [
                          {
                              "type": "postback",
                              "label": "4顆星 點擊查看評論",
                              "data": "action=buy&itemid=222"
                          },
                          {
                              "type": "postback",
                              "label": "平均價位 $200",
                              "data": "action=add&itemid=222"
                          },
                          {
                              "type": "uri",
                              "label": "距離你300公尺",
                              "uri": "http://example.com/page/222"
                          }
                      ]
                    },
                    
                    {             
                      "thumbnailImageUrl": "https://i.ibb.co/sP7vdL0/S-66682902.jpg",
                      "imageBackgroundColor": "#FFFFFF",
                      "title": "Reverse",
                      "text": "LINE Pay回饋3%",
                      "defaultAction": {
                          "type": "uri",
                          "label": "View detail",
                          "uri": "http://example.com/page/123"
                      },
                      "actions": [
                          {
                              "type": "postback",
                              "label": "4.6顆星 點擊查看評論",
                              "data": "action=buy&itemid=111"
                          },
                          {
                              "type": "postback",
                              "label": "平均價位 $300",
                              "data": "action=add&itemid=111"
                          },
                          {
                              "type": "uri",
                              "label": "距離你100公尺",
                              "uri": "http://example.com/page/111"
                          }
                      ]
                    }
                ],
                "imageAspectRatio": "square",
                "imageSize": "cover"
            }
          }

        # 設定 coffee carousel Mode Message
        carouselModeMessage =   
        {
          "type": "template",
          "altText": "This is carousel template.",
          "template": {
              "type": "carousel",
              "columns": [
                  {             
                    "thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
                    "imageBackgroundColor": "#FFFFFF",
                    "title": "#{$keyword}1",
                    "text": "LINE Pay回饋2%",
                    "defaultAction": {
                        "type": "uri",
                        "label": "View detail",
                        "uri": "http://example.com/page/123"
                    },
                    "actions": [
                        {
                            "type": "postback",
                            "label": "4.5顆星 點擊查看評論",
                            "data": "action=buy&itemid=111"
                        },
                        {
                            "type": "postback",
                            "label": "平均價位 $300",
                            "data": "action=add&itemid=111"
                        },
                        {
                            "type": "uri",
                            "label": "距離你500公尺",
                            "uri": "http://example.com/page/111"
                        }
                    ]
                  },
                  {
                    "thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
                    "imageBackgroundColor": "#000000",
                    "title": "#{$keyword}2",
                    "text": "LINE Pay回饋1%",
                    "defaultAction": {
                        "type": "uri",
                        "label": "View detail",
                        "uri": "http://example.com/page/222"
                    },
                    "actions": [
                        {
                            "type": "postback",
                            "label": "4顆星 點擊查看評論",
                            "data": "action=buy&itemid=222"
                        },
                        {
                            "type": "postback",
                            "label": "平均價位 $200",
                            "data": "action=add&itemid=222"
                        },
                        {
                            "type": "uri",
                            "label": "距離你300公尺",
                            "uri": "http://example.com/page/222"
                        }
                    ]
                  },
                  
                  {             
                    "thumbnailImageUrl": "https://example.com/bot/images/item1.jpg",
                    "imageBackgroundColor": "#FFFFFF",
                    "title": "#{$keyword}3",
                    "text": "LINE Pay回饋3%",
                    "defaultAction": {
                        "type": "uri",
                        "label": "View detail",
                        "uri": "http://example.com/page/123"
                    },
                    "actions": [
                        {
                            "type": "postback",
                            "label": "4.6顆星 點擊查看評論",
                            "data": "action=buy&itemid=111"
                        },
                        {
                            "type": "postback",
                            "label": "平均價位 $300",
                            "data": "action=add&itemid=111"
                        },
                        {
                            "type": "uri",
                            "label": "距離你100公尺",
                            "uri": "http://example.com/page/111"
                        }
                    ]
                  }
              ],
              "imageAspectRatio": "square",
              "imageSize": "cover"
          }
        }
      

      # 設定回覆訊息
        if $keyword == "咖啡廳"
          message = [textMessage, coffeeCarouselModeMessage]
        elsif $keyword != ""
          message = [textMessage, carouselModeMessage]
        else
          message = textMessage
        end

      # 傳送訊息
        line.reply_message(reply_token, message)
    end

    # Line Bot API 物件初始化
    def line
      return @line unless @line.nil?
      @line = Line::Bot::Client.new { |config|
      config.channel_secret = '3d9a702940892f06b59b6b7649cb70d0'
      config.channel_token = 'ZE7NSG2srmKcngaEF9LlHuZieBJJw0zcjaPR0+bN82clLh0Fp8qgEqCkcZ+BiCLh9/8fcgxxnX0WMX4sniXdKgRxGqOI/xMNAQ0/E4SYREh+ZS2o44BeUf7+MjYCs4PkTNr7qoOocGPJSMZQ5tnsWQdB04t89/1O/w1cDnyilFU='
    }  
    end

end
