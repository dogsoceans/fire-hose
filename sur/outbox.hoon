|%
+$  outbox-action
  $%  [%bind =path]
      [%deposit =json]
      [%make-outbox id=@ta daps=(list term)]
  ==
+$  outbox
  $:  daps=(set term)
      msgs=(list [@ud json])
  ==
--