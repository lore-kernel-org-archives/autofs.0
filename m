From: Ian Kent <raven@themaw.net>
Subject: Re: "Too many levels of symbolic links"
Date: Thu, 20 Feb 2014 20:18:24 +0800
Message-ID: <1392898704.2508.26.camel@perseus.fritz.box>
References: <52E92627.9050801@molgen.mpg.de>
	 <1391139080.2486.19.camel@perseus.fritz.box>
	 <1391145206.2486.25.camel@perseus.fritz.box> <52EB7694.20707@molgen.mpg.de>
	 <52EB7B07.2070707@molgen.mpg.de> <530484B7.6030305@molgen.mpg.de>
	 <1392896501.2508.16.camel@perseus.fritz.box>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=15xAbSy8CvjrOkMpwEWJD9eXGIQ=; b=kFiERMr1V9+JozillPNqGsufyhRY
	z+re8JEita8BL78IhRhxAUDeIkQ+BuehnJSK1hXLQYX6+X67UDd/h/oyHMODpHdR
	OkJAfQYi9SL41nwol1THNE7VqsiTFBvXS2E5D8O53t49lcUhcxrAk1l/kzyp5kjL
	sDOkTDBuxYyquoc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=15xAbSy8CvjrOkMpwEWJD9
	eXGIQ=; b=l2PGy0+Os1d3IdgPug7mgMDFRxdCNUG7qDge8lHP3zehyhjlsgbo/V
	hJQmd6alWbJPEGOwijHW1JWeiyQlhpfMLj+Y6+hjHh3LIc09LvRTqH0nja3qY0W2
	c4nK9B/PRUYrsF/EAiSVl5XB3zhBlW4wkEIT4UEOax5qTi1fpGahM=
In-Reply-To: <1392896501.2508.16.camel@perseus.fritz.box>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Donald Buczek <buczek@molgen.mpg.de>
Cc: autofs <autofs@vger.kernel.org>, Alexander Viro <aviro@redhat.com>

On Thu, 2014-02-20 at 19:41 +0800, Ian Kent wrote:
> > 
> > 1969 (gdb) print *(struct dentry *) 0xffff88007fd06c50
> > 1970 $3 = {d_flags = 1523840, d_seq = {sequence = 4}, d_hash = {next = 0xffff880214025c98, pprev = 0xffffc9000013d570}, d_parent = 0xffff8800caa66810, d_name = {{{hash = 1876415966, len = 7}, hash_len = 31941187038}, name = 0xffff88007fd06c88 "gbrowse"}, d_inode = 0xffff8800961ad250, d_iname = "gbrowse", '\000' <repeats 24 times>, d_lockref = {{lock_count = 8610971969, {
> > 1971         lock = {{rlock = {raw_lock = {{head_tail = 21037377, tickets = {head = 321, tail = 321}}}}}}, count = 2}}}, d_op = 0xffffffff81c45b40, d_sb = 0xffff880222a33800, d_time = 0, d_fsdata = 0xffff8800ca443b80, d_lru = {next = 0xffff88007fd06cd0, prev = 0xffff88007fd06cd0}, d_u = {d_child = {next = 0xffff88007fc9f420, prev = 0xffff8800caa668b0}, d_rcu = {
> > 1972       next = 0xffff88007fc9f420, func = 0xffff8800caa668b0}}, d_subdirs = {next = 0xffff88007fd06cf0, prev = 0xffff88007fd06cf0}, d_alias = {next = 0x0, pprev = 0xffff8800961ad360}}

I wonder if there's a struct mount for which this dentry is
mnt_mountpoint and if so what the value of m_count is for the struct
mountpoint of the struct mount?

Oh boy ... this stuff has changed so much.
It does look like mount->mountpoint->m_mount controls the setting and
clearing of DCACHE_MOUNTED.

If there is and m_count is non-zero then there may be a reference
counting problem somewhere or some other weirdness. Be worth looking at
the mount struct and it's neighbors if you can find it.

> > 
> > 
> > which is 0x174080 which is
> > 
> >    DCACHE_RCUACCESS+
> >    DCACHE_FSNOTIFY_PARENT_WATCHED+
> >    DCACHE_MOUNTED+
> >    DCACHE_NEED_AUTOMOUNT+
> >    DCACHE_MANAGE_TRANSIT+
> >    DCACHE_DIRECTORY_TYPE
> > 
> > so again we have DCACHE_MOUNTED but no mount ( line 1753ff )
> > 

Ian

