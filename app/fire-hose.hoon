::  %fire-hose [UQ| DAO]
::
::  UQ| fire-hose agent. Eliminates the need for .subscribe() connections
::  from the frontend. Use with <<NPM PACKAGE>>
::
/-  *fire-hose
/+  default-agent, dbug, verb, ob=fire-hose
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      hoses=(map @ta hose)
  ==
+$  card  card:agent:gall
--
::
=|  state-0
=*  state  -
::
%-  agent:dbug
%+  verb  &
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  :_  this
  [%pass /bind %arvo %e %connect `/fire-hose dap.bowl]~
::
++  on-save  !>(state)
::
++  on-load
  :: NOTE/TODO you could just nuke state on every update. Connections are ephemeral
  |=  =vase
  ^-  (quip card _this)
  =+  !<(old=versioned-state vase)
  ?-  -.old
    %0  `this(state old)
  ==
::
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  ?=([%http-response *] path)
  `this
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  |^
  ?+  mark  (on-poke:def mark vase)
    %handle-http-request  (fh-req bowl !<([@tas inbound-request:eyre] vase))
    %fh-action            (fh-act bowl !<(fh-action vase))
  ==
  ::
  ++  fh-act
    |=  [=bowl:gall act=fh-action]
    ^-  (quip card _this)
    ?-    -.act
        %deposit
      =.  hoses
        %-  ~(urn by hoses)
        |=  [id=@ta =hose]
        ?.  (~(has in daps.hose) dap.act)  hose :: TODO need to write app source into bowl:gall, this is a security flaw right now
        =/  index  ?~(msgs.hose 0 +(-.i.msgs.hose))
        [time.hose daps.hose [[index json.act] msgs.hose]]
      `this
    ::
        :: TODO This is temporary. Do this by POSTing later
        %make-hose
      =.  hoses
        (~(put by hoses) id.act [now.bowl (silt daps.act) ~])
      `this
    ==
  ::
  ++  fh-req
    |=  [=bowl:gall rid=@tas req=inbound-request:eyre]
    ^-  (quip card _this)
    =/  paths  [/http-response/[rid]]~
    =/  head=response-header:http
      [200 ['Content-Type' 'application/json']~]
    ?>  =(%'GET' method.request.req)
    =/  parsed-url=path  (rash url.request.req stap) :: URL must be /[connection-id]/[ack-number]
    ?>  ?=([%fh @ @ ~] parsed-url)
    =*  connection-id  i.t.parsed-url
    =/  message-id     (slav %ud i.t.t.parsed-url)
    =/  current-ob=hose  (~(got by hoses) connection-id)
    =.  msgs.current-ob
      =|  new=(list [@ud json])
      |-
      ?~  msgs.current-ob                    (flop new)
      ?:  =(message-id -.i.msgs.current-ob)  (flop new)
      $(msgs.current-ob t.msgs.current-ob, new [i.msgs.current-ob new])
    =.  time.current-ob  now.bowl
    :: TODO ugly code
    :_  this(hoses (~(put by hoses) connection-id current-ob))
    %^  make-http-response-facts:ob  paths  head
    %-  some
    %-  as-octs:mimes:html
    %-  crip
    %-  en-json:html
    a+(turn msgs.current-ob |=([id=@ud =json] json))
  --
++  on-agent  on-agent:def
::
++  on-arvo
  :: TODO need to write logic that cancels timers.
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+  wire  (on-arvo:def wire sign-arvo)
    :: TODO maybe error handling instead of ?>
    [%bind ~]  ?>(?=([%eyre %bound %.y *] sign-arvo) `this)
  ==
::
++  on-peek  on-peek:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
