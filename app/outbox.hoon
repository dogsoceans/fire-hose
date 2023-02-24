::  outbox [UQ| DAO]
::
::  UQ| outbox agent. Eliminates the need for .subscribe() connections
::  from the frontend. Use with <<NPM PACKAGE>>
::
/-  *outbox
/+  default-agent, dbug, verb
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0
  $:  %0
      binding=path
      outboxes=(map @ta outbox)
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
++  on-init  on-init:def
++  on-save  !>(state)
::
++  on-load
  :: NOTE/TODO you could just nuke state on every update. Connections can be ephemeral
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
    %handle-http-request  (outbox-req bowl !<([@tas inbound-request:eyre] vase))
    %outbox-action        (outbox-act bowl !<(outbox-action vase))
  ==
  ::
  ++  outbox-act
    |=  [=bowl:gall act=outbox-action]
    ^-  (quip card _this)
    ?-    -.act
        %bind
      :_  this
      [%pass /bind %arvo %e %connect `path.act dap.bowl]~
    ::
        %deposit
      =.  outboxes
        %-  ~(urn by outboxes)
        |=  [id=@ta =outbox]
        ?.  (~(has in daps.outbox) dap.bowl)  outbox
        =/  index  ?~(msgs.outbox 0 +(-.i.msgs.outbox))
        [daps.outbox [[index json.act] msgs.outbox]]
      `this
    ::
        :: TODO This is temporary. Do this by posting later
        %make-outbox
      =.  outboxes
        (~(put by outboxes) id.act [(silt daps.act) ~])
      `this
    ==
  ::
  ++  outbox-req
    |=  [=bowl:gall rid=@tas req=inbound-request:eyre]
    ^-  (quip card _this)
    ?>  =(%.y authenticated.req)
    =/  paths  [/http-response/[rid]]~
    =/  head=response-header:http
      [200 ['Content-Type' 'application/json']~]
    ?+    method.request.req  `this :: TODO crash probably?
        %'GET'
      =/  parsed-url=path  (rash url.request.req stap) :: URL must be /[connection-id]/[ack-number]
      ?>  ?=([@ @ ~] parsed-url)
      =*  connection-id    i.parsed-url
      =/  message-id     (scot %ud i.t.parsed-url)
      =/  cob=outbox  (~(got by outboxes) connection-id)
      =.  msgs.cob
        =|  new=(list [@ud json])
        |-
        ?~  msgs.cob                    (flop new)
        ?:  =(message-id -.i.msgs.cob)  (flop new)
        $(msgs.cob t.msgs.cob, new [i.msgs.cob new])
      =/  data=(unit octs)
        %-  some
        %-  as-octs:mimes:html
        %-  crip
        %-  en-json:html
        a+(turn msgs.cob |=([id=@ud =json] json))
      :_  this :: TODO need to delete a bunch of stuff
      :~  [%give %fact paths %http-response-header !>(head)]
          [%give %fact paths %http-response-data !>(data)]
          [%give %kick paths ~]
      ==
    ::
        %'POST' :: TODO this doesn't work????? need to try from a browser or smth 
      =*  id=@ta  (crip (en-json:html s+(rear (rash url.request.req stap)))) :: TODO this is kind of retarded
      =/  connection-id=(unit octs)  `(as-octs:mimes:html id)
      =/  daps=(set term)  (silt (limo ~['test' 'asdf' 'fdsa'])) :: TODO implement for real
      :_  this(outboxes (~(put by outboxes) id [daps ~]))
      :~  [%give %fact paths %http-response-header !>(head)]
          [%give %fact paths %http-response-data !>(connection-id)]
          [%give %kick paths ~]
      ==
    ==
  --
++  on-agent  on-agent:def
::
++  on-arvo
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
