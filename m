From: Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: "Too many levels of symbolic links"
Date: Thu, 20 Feb 2014 16:57:04 +0100
Message-ID: <530625D0.7020808@molgen.mpg.de>
References: <52E92627.9050801@molgen.mpg.de>	 <1391139080.2486.19.camel@perseus.fritz.box>	 <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de>	 <52EB7B07.2070707@molgen.mpg.de> <530484B7.6030305@molgen.mpg.de>	 <1392896501.2508.16.camel@perseus.fritz.box> <1392898704.2508.26.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
In-Reply-To: <1392898704.2508.26.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: autofs <autofs@vger.kernel.org>, Alexander Viro <aviro@redhat.com>

On 02/20/14 13:18, Ian Kent wrote:
> On Thu, 2014-02-20 at 19:41 +0800, Ian Kent wrote:
>>> 1969 (gdb) print *(struct dentry *) 0xffff88007fd06c50
>>> 1970 $3 = {d_flags = 1523840, d_seq = {sequence = 4}, d_hash = {next = 0xffff880214025c98, pprev = 0xffffc9000013d570}, d_parent = 0xffff8800caa66810, d_name = {{{hash = 1876415966, len = 7}, hash_len = 31941187038}, name = 0xffff88007fd06c88 "gbrowse"}, d_inode = 0xffff8800961ad250, d_iname = "gbrowse", '\000' <repeats 24 times>, d_lockref = {{lock_count = 8610971969, {
>>> 1971         lock = {{rlock = {raw_lock = {{head_tail = 21037377, tickets = {head = 321, tail = 321}}}}}}, count = 2}}}, d_op = 0xffffffff81c45b40, d_sb = 0xffff880222a33800, d_time = 0, d_fsdata = 0xffff8800ca443b80, d_lru = {next = 0xffff88007fd06cd0, prev = 0xffff88007fd06cd0}, d_u = {d_child = {next = 0xffff88007fc9f420, prev = 0xffff8800caa668b0}, d_rcu = {
>>> 1972       next = 0xffff88007fc9f420, func = 0xffff8800caa668b0}}, d_subdirs = {next = 0xffff88007fd06cf0, prev = 0xffff88007fd06cf0}, d_alias = {next = 0x0, pprev = 0xffff8800961ad360}}
> I wonder if there's a struct mount for which this dentry is
> mnt_mountpoint and if so what the value of m_count is for the struct
> mountpoint of the struct mount?

No there isn't. Already checked in 
http://owww.molgen.mpg.de/~buczek/autofs-demo/typescript.l lines 1795ff

Regards
   Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

