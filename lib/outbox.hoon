|%
:: ++  msg-de-json
::   |=  json
++  make-http-response-facts
  |=  [paths=(list path) hed=response-header:http data=(unit octs)]
  :~  [%give %fact paths %http-response-header !>(hed)]
      [%give %fact paths %http-response-data !>(data)]
      [%give %kick paths ~]
  ==
--