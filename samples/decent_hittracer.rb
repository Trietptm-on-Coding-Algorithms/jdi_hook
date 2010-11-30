#!/usr/bin/env jruby
require 'rubygems'
require 'jdi_hook'

vm = JdiHook.socket_attach(8000)
dbg = JdiHook::MethodTracer.new(vm)

en_proc = lambda {|this, evt| puts " [*] #{evt.jh_describe_event}" }
ex_proc = lambda {|this, evt| puts " [*] #{evt.jh_describe_event}" }

dbg.meth_hooks = { 
  /\.*$/ => { :on_entry => en_proc, :on_exit => ex_proc },
}

STDERR.puts "Starting hit-trace"
dbg.go