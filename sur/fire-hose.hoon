|%
+$  fh-action
  $%  [%deposit dap=term =json]
      [%make-hose id=@ta daps=(list term)]
  ==
+$  hose
  $:  time=@da
      daps=(set term)
      msgs=(list [@ud json])
  ==
--