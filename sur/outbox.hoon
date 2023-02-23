|%
+$  outbox-action
  $:  [%bind =path]
      [%deposit =json]
  ==
+$  outbox
  $:  num=@ud :: monotonic
      daps=(set term)
      msgs=(list [@ud json])
  ==
--