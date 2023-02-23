::  outbox [UQ| DAO]
::
::  UQ| outbox agent. Eliminates the need for .subscribe() connections
::  from the frontend. Use with <<NPM PACKAGE>>
::
/-  *outbox
/+  default-agent, dbug, verb, 
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
%+  verb  |
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
  =+  !<(old=versioned-state vase)
  ?-  -.old
    %0  this(state old)
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
      [%pass /connect %arvo %e %connect `path.act dap.bowl]~
    ::
        %deposit
      =.  outboxes
        %-  ~(urn by outboxes)
        |=  [id=@ta =outbox]
        ?.  (~(has in daps.outbox) dap.bowl)  outbox
        [+(num.outbox) daps.outbox [json.act msgs.outbox]]
      `this
    ==
  ::
  ++  outbox-req
    |=  [=bowl:gall rid=@tas req=inbound-request:eyre]
    ^-  (quip card _this)
    ?>  =(%.y authenticated.req)
    =/  paths  [/http-response/[rid]]~
    ?+    method.request.req  `this :: TODO crash probably?
        %'GET'
      :: don't think header-list.request.req matters
      :: don't think        body.request.req matters
      :: URL must be /[connection-id]/[ack-number]
      =/  parsed-url=path  (rash url.request.req stap)
      ?>  ?=([@ @ ~] parsed-url)
      =*  connection-id    i.parsed-url
      =*  message-id     i.t.parsed-url :: TODO need to cut off msgs based on this

      =/  head=response-header:http
        [200 ['Content-Type' 'application/json']~]
      =/  data=(unit-octs)
        %-  some
        %-  as-octs:mimes:html
        %-  crip
        %-  en-json:html
        [%a [%s 'test string']~] :: TODO needs to aggregate all the json in the outbox. Probably also needs to store as an object map from number > payload
      :_  this :: TODO need to delete a bunch of stuff
      :~  [%give %fact paths %http-response-header !>(head)]
          [%give %fact paths %http-response-data !>(data)]
          [%give %kick paths ~]
      ==
    ::
        %'POST'
      =*  id=@t  (crip (en-json:html s+(rear (rash url stap))))
      =/  connection-id=(unit octs)  `(as-octs:mimes:html id)
      =/  head=response-header:http
        [200 ['Content-Type' 'application/json']~]
      =/  daps=(set term)  (silt (limo ~['test' 'asdf' 'fdsa']))
      :: have to create a new outbox
      :_  this(outboxes  (~(put by outboxes) outbox-id [0 daps ~]))
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
  ?+    wire  (on-arvo:def wire sign-arvo)
      [%connect ~]
    ?+    -.sign.arvo  (on-arvo:def wire sign-arvo)
        %eyre
      :: TODO this is could be cleaner
      ?>  =(%bound -.gift.sign-arvo)
      ?:  =(%.y accepted.gift.sign-arvo)
        `this(binding path.binding.gift.sign-arvo)
      ~&  >>>  "error binding to {<path.binding.gift.sign-arvo>}"
      `this
    ==
  ==
::
++  on-peek  on-peek:def
++  on-leave  on-leave:def
++  on-fail   on-fail:def
--
