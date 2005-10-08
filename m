From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
Date: Sat, 8 Oct 2005 08:50:39 -0400
Message-ID: <17223.49311.723163.216415@segfault.boston.redhat.com>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
	<17208.24786.729632.221157@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0510081341460.2069@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932093AbVJHMu6@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0510081341460.2069@donald.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> On Mon, 26 Sep 2005, Jeff Moyer wrote:
>> I put together a different patch, but I want to get your input on the
>> approach before I post it.  It requires both user-space and kernel-space
>> changes.
>> 
>> Basically, you identify that a given automount tree is a direct map
>> tree.  This information is passed along to the kernel (I did this via a
>> mount option), and recorded (in the super block info).  Then, when a
>> directory lookup occurs, if we are in a direct map tree, and ghosting is
>> enabled, then we pass the lookup on to the real lookup code.
>> 
>> I'm not sold on the approach, as I haven't thought through all of the
>> implications.  Care to comment?

raven> Can you post your patch please Jeff.

I would, if it worked!  I'm away until the 17th.  I'll see what I can
come up with when I get back.  Sorry!

-Jeff
