|%
+$  outbox-action
  $%  [%deposit dap=term =json]
      [%make-outbox id=@ta daps=(list term)]
  ==
+$  outbox
:: TODO add time last updated. If someone tries to push e.g. 30 msgs, then check to make sure the time isn't too late
  $:  daps=(set term)
      msgs=(list [@ud json])
  ==
--