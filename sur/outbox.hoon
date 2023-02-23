|%
+$  outbox-action
  $:  [%bind =path]
      [%deposit =json]
  ==
+$  outbox
  $:  daps=(set term)
      msgs=(list [@ud json])
  ==
--